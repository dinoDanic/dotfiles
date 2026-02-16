#!/usr/bin/env bash
set -euo pipefail

PREVIEW_SCRIPT="${HOME}/.config/fish/scripts/pp_preview.sh"

need() { command -v "$1" >/dev/null 2>&1 || { echo "$1 not found" >&2; exit 1; }; }
need powerprofilesctl
need fzf
need awk
need sed

[[ -x "$PREVIEW_SCRIPT" ]] || { echo "Preview script not executable: $PREVIEW_SCRIPT" >&2; exit 1; }

current="$(powerprofilesctl get)"
list="$(powerprofilesctl list)"

# Extract profile names from lines like:
# performance:
# balanced:
# power-saver:
mapfile -t profiles < <(printf '%s\n' "$list" | sed -nE 's/^[ *]*([a-z-]+):$/\1/p')

if (( ${#profiles[@]} == 0 )); then
  echo "No profiles detected from powerprofilesctl list" >&2
  echo >&2
  echo "Debug (first 40 lines):" >&2
  printf '%s\n' "$list" | head -n 40 >&2
  exit 1
fi

tmpdir="$(mktemp -d)"
cleanup() { rm -rf "$tmpdir"; }
trap cleanup EXIT

# Cache per-profile blocks from the *cached* list (READ ONLY)
for p in "${profiles[@]}"; do
  printf '%s\n' "$list" | awk -v prof="$p" '
    $0 ~ ("^" prof ":") {found=1}
    found {print}
    found && NR>1 && $0 ~ "^[a-z-]+:$" && $0 !~ ("^" prof ":") {exit}
  ' > "$tmpdir/$p"
done

# Menu (current first)
{
  echo "* $current"
  for p in "${profiles[@]}"; do
    [[ "$p" == "$current" ]] || echo "  $p"
  done
} | fzf --no-sort \
        --prompt="Power > " \
        --header="Current: $current" \
        --preview "$PREVIEW_SCRIPT {} $tmpdir 2>&1" \
        --preview-window=right:50%:wrap \
  | sed 's/^[* ]*//' \
  | xargs -r powerprofilesctl set
