#!/usr/bin/env bash
# Usage: pp_preview.sh "<selected_line>" "<tmpdir>"
set -u

raw="${1:-}"
tmpdir="${2:-}"

# Trim leading "* " / spaces
sel="${raw#\* }"
sel="${sel#"  "}"
sel="${sel#" "}"

echo "Power profiles preview"
echo "======================"
echo
echo "Selected: ${sel:-n/a}"
echo "Active:   $(powerprofilesctl get 2>/dev/null || echo n/a)"
echo

# 1) Cached block from `powerprofilesctl list` (whatever is available)
info="$tmpdir/$sel"
if [[ -r "$info" ]]; then
  echo "From powerprofilesctl list"
  echo "--------------------------"
  cat "$info"
else
  echo "(No cached block for '$sel')"
fi

echo
echo "Current system knobs (right now)"
echo "--------------------------------"

read_or() { [[ -r "$1" ]] && cat "$1" || echo "n/a"; }

echo "governor: $(read_or /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"
echo "EPP:      $(read_or /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference)"
echo "boost:    $(read_or /sys/devices/system/cpu/cpu0/cpufreq/boost)"
echo "platform: $(read_or /sys/firmware/acpi/platform_profile)"

if [[ -r /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ]]; then
  awk '{printf "cpu0 freq: %.2f GHz\n", $1/1000000}' /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
else
  echo "cpu0 freq: n/a"
fi

# avg freq across all CPUs
sum=0; count=0
for f in /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq; do
  [[ -r "$f" ]] || continue
  val="$(cat "$f" 2>/dev/null || true)"
  [[ -n "${val:-}" ]] || continue
  sum=$((sum + val))
  count=$((count + 1))
done
if (( count > 0 )); then
  awk -v s="$sum" -v c="$count" 'BEGIN{printf "avg  freq: %.2f GHz\n", (s/c)/1000000}'
else
  echo "avg  freq: n/a"
fi

if [[ -r /proc/loadavg ]]; then
  echo "load:     $(cut -d' ' -f1-3 /proc/loadavg)"
else
  echo "load:     n/a"
fi

tfile="$(ls /sys/class/thermal/thermal_zone*/temp 2>/dev/null | head -n1 || true)"
if [[ -n "${tfile:-}" ]] && [[ -r "$tfile" ]]; then
  awk '{printf "temp:     %.1f°C\n", $1/1000}' "$tfile"
else
  echo "temp:     n/a"
fi

echo
echo "Expected behavior if you set '$sel'"
echo "-----------------------------------"

case "$sel" in
  performance)
    cat <<'TXT'
- Prefers performance: ramps clocks quickly, keeps them higher under load.
- Usually sets EPP closer to "performance".
- Often enables/keeps boost behavior (if supported).
- May increase fan activity and power draw.
TXT
    ;;
  balanced)
    cat <<'TXT'
- Middle ground: boosts when needed but returns to lower clocks sooner.
- Usually sets EPP to something like "balance_performance".
- Good default for mixed work (dev + browsing + some builds).
TXT
    ;;
  power-saver|powersaver|power_save|power-save)
    cat <<'TXT'
- Prefers efficiency: slower ramp, lower sustained clocks.
- Usually sets EPP closer to "power" / "balance_power".
- Often reduces boost aggressiveness (if supported).
- Lower heat/noise, better battery.
TXT
    ;;
  *)
    cat <<TXT
- This profile name isn't one of the common three, so I can't describe it confidently.
- You'll still see the "Current system knobs" above and the raw block from powerprofilesctl.
TXT
    ;;
esac

echo
echo "(Note: exact knobs depend on your CPU driver + kernel; read-only preview can't guarantee every change.)"
