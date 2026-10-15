---
name: my-system
description: Full hardware specs and software environment for Dino's TUXEDO laptop (Tuxedo OS 24.04 + i3/X11). Use when user asks hardware questions, upgrade advice, compatibility checks, driver issues, performance tuning, or anything requiring knowledge of this specific machine's specs.
---

# My System — TUXEDO InfinityBook Max 15 AMD Gen10

*Verified 2026-10-15 on Tuxedo OS 24.04 + i3. Re-check exact versions with `dpkg -l <pkg>` / `uname -r` before relying on them.*

## Machine

| Field | Value |
|---|---|
| Model | TUXEDO InfinityBook Max 15 AMD Gen10 |
| Board | X5KK45xS_X5SP45xS |
| Firmware | UEFI AMI N.1.20A13 (2025-10-14) |
| Hostname | dino |

## CPU

| Field | Value |
|---|---|
| Model | AMD Ryzen AI 9 HX 370 w/ Radeon 890M |
| Architecture | Zen 5 (+ XDNA NPU) |
| Cores / Threads | 12 / 24 |
| Clock | ~605 MHz min / ~5158 MHz boost |
| Cache | L1d 576 KiB · L2 12 MiB · L3 24 MiB |

## RAM & Swap

| Field | Value |
|---|---|
| Total | 64 GiB (~61 GiB visible) |
| Swap | **none** (no swapfile, no zram) — hibernate won't work; add a swapfile if needed |

## GPU — Discrete

| Field | Value |
|---|---|
| Model | NVIDIA GeForce RTX 5060 Laptop GPU (GB206M) — **Blackwell** |
| VRAM | 8151 MiB GDDR7 |
| Driver | `nvidia-driver-open` 580.178.04 (Tuxedo repo, pinned by `tuxedo-nvidia-driver-default-pinning`) — open module is **required** on Blackwell |
| Bus / DRM | `65:00.0` → `card1` |

## GPU — Integrated

| Field | Value |
|---|---|
| Model | AMD Radeon 890M (Strix) |
| Driver | `amdgpu` · Mesa 26.1.6 (Tuxedo build, incl. i386 Vulkan) |
| Bus / DRM | `66:00.0` → `card2` |

### Hybrid graphics under X11 — important

- `prime-select query` → **on-demand**, but `xrandr --listproviders` shows **NVIDIA-0 as the primary X screen** and AMD as *Sink Output* (reverse PRIME). So everything (i3, glxinfo) renders on the **RTX 5060**; frames are sent to the AMD outputs.
- **All physical outputs are wired to the iGPU** (`card2`). Under X their names are reverse-PRIME style: `eDP-1-0` (internal), `DisplayPort-1-1` (external) — not `eDP-1`/`DP-2`.
- Consequence: dGPU is always awake → higher idle power/heat on battery. Switching X to AMD-primary would save power but changes output names and needs testing.
- Run apps explicitly on NVIDIA: `tuxedo-dgpu-run <app>` or `__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia <app>`.
- Kernel cmdline has `nvidia.NVreg_PreserveVideoMemoryAllocations=1` (suspend fix, `tuxedo-fix-nvidia-preserve-vram-suspend`).
- `supergfxd` is not used.

## Display

| Output (X name) | Device | Mode | Physical |
|---|---|---|---|
| `eDP-1-0` | BOE 15" internal panel | 2560×1600 @ **240 Hz** (60 Hz also) | 329×206 mm |
| `DisplayPort-1-1` | LG HDR 4K | 3840×2160 @ 60 Hz | 697×392 mm (~32") |

- Layout: LG on top (`+0+0`), laptop panel below, centered (`+640+2160`).
- DPI: `Xft.dpi: 144` (1.5×) via `~/.Xresources`, merged by i3 `exec_always xrdb`.
- Backlight: **two** nodes — `amdgpu_bl2` (max 62451, the real panel) and `nvidia_0` (EC/WMI, 0–100). `brightnessctl` is not installed; i3 has no brightness keys bound yet.
- `autorandr` installed.

## Storage

| Field | Value |
|---|---|
| Drive | WD BLACK SN7100 1TB NVMe (`nvme0n1`, 931.5 GiB) |
| Layout | `p1` 300 MiB vfat `/boot/efi` · `p2` 931 GiB **ext4** `/` — **no LUKS, no btrfs/snapshots** |
| Used | ~37 GiB / 916 GiB (5%) |

## Audio

- PipeWire 1.6.8 + WirePlumber 0.5.15
- Default sink/source: **Family 17h/19h HD Audio Controller Analog Stereo** (Realtek ALC245, internal speakers/mic)
- HDMI/DP audio: "Rembrandt Radeon HD Audio Digital Stereo (HDMI)"; NVIDIA HDA also present
- Volume keys in i3 → `pactl`, refresh i3status

## Network

| Device | Driver | Notes |
|---|---|---|
| MediaTek MT7922 WiFi 6E | `mt7921e` → `wlp99s0` | `tuxedo-fix-wifi-set-reg-domain` installed |
| Motorcomm YT6801 Gigabit Ethernet | **`yt6801`** (from `tuxedo-yt6801` package) → `eno1` | kernel 7.0 also ships `dwmac_motorcomm`, but Tuxedo's `yt6801` is what binds |
| Bluetooth | MediaTek via `btusb` | powered on |

## OS / Desktop Stack

| Field | Value |
|---|---|
| OS | **Tuxedo OS 24.04** (Ubuntu noble base, KDE Plasma installed as fallback) |
| Kernel | `linux-tuxedo` 7.0.0-111031-tuxedo (older 111030 still installed) |
| Session | **i3 4.23 on X11** (Xorg 21.1.12); Plasma Wayland as fallback |
| Login | SDDM; `~/.xsessionrc` sets `QT_QPA_PLATFORMTHEME=kde`, `XDG_MENU_PREFIX=plasma-` |
| Bar | i3bar + i3status |
| Launcher | dmenu (`mod+space`, `mod+d`) |
| Terminal | Alacritty 0.13 |
| Shell | fish 3.7 |
| Notifications | dunst 1.9 (`notify-send` via `libnotify-bin`) |
| Lock | xss-lock + i3lock |
| File manager | Dolphin; image viewer Gwenview |
| Screenshots | `~/.config/i3/screenshot.sh` (maim + xclip), Super+Alt+3/4/5 |
| Packages | ~2900 (dpkg) |
| Compilers | GCC 13.3 |
| Firewall | ufw active (`tuxedo-ufw-profiles`) |
| Dotfiles | `~/dotfiles` with stow (this skill lives there) |

i3 keys: `$mod` = Super, CapsLock also Super (`setxkbmap -option caps:super`), vim hjkl focus/move, `mod+q` kill, autotiling from `~/.local/bin/autotiling`.

## Tuxedo-Specific Software

| Package | Version |
|---|---|
| `tuxedo-control-center` | 3.0.10 (`tccd` active) |
| `tuxedo-drivers` | 4.24.0 |
| `tuxedo-dgpu-run` | 2.0.0 |
| `tuxedo-yt6801` | 1.0.31 |
| `tuxedo-touchpad-switch`, `tuxedo-tomte` | installed |

**Loaded modules:** `tuxedo_keyboard`, `tuxedo_io`, `uniwill_wmi`, `clevo_wmi`, `ite_8291`, `tuxedo_nb02_nvidia_power_ctrl`, `tuxedo_compatibility_check`

- Fans, ODM performance profiles / TDP, battery charge limits → through **TCC** (`/dev/tuxedo_io`), not hwmon/sysfs. No `charge_control_end_threshold` node.
- RGB keyboard via `ite_8291` (per-key zones under `/sys/class/leds/rgb:kbd_backlight*`).
- `tuxedo-tomte` manages Tuxedo fixes/packages — don't remove its packages blindly.

## Sensors

`k10temp` (Tctl) · `amdgpu` (edge) · `nvme` (Composite) · `mt7921_phy0` · `acpitz` · `spd5118` ×2 (DIMM) · `ucsi_source_psy_USBC000:001/002`. Fans not in `sensors`.

## Upgrade / Compatibility Notes

- **Packages**: Ubuntu 24.04 apt + Tuxedo repo. Some apt packages are old (e.g. Neovim → installed from GitHub tarball in `~/.local/opt`; Node via nvm; Python tools via pipx).
- **NVIDIA**: stay on the Tuxedo-pinned open driver; Blackwell (SM 12.x) needs CUDA ≥ 12.8. Don't install Ubuntu's `nvidia-driver-*` over the Tuxedo one.
- **Kernel**: use `linux-tuxedo` (has board patches); mainline Ubuntu generic kernels may lack fixes.
- **RAM**: 64 GiB, likely 2×32 GiB DDR5 (max for this board).
- **Android dev**: SDK `~/Android/Sdk`, Studio in `/opt`, JDK 17.
