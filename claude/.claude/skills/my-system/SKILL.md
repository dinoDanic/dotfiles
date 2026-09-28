---
name: my-system
description: Full hardware specs and software environment for Dino's TUXEDO laptop. Use when user asks hardware questions, upgrade advice, compatibility checks, driver issues, performance tuning, or anything requiring knowledge of this specific machine's specs.
---

# My System — TUXEDO InfinityBook Max 15 AMD Gen10

*Verified 2026-08-21. Version numbers drift on a rolling release — re-check with `pacman -Q` / `uname -r` before relying on an exact version.*

## Machine

| Field | Value |
|---|---|
| Model | TUXEDO InfinityBook Max 15 AMD Gen10 |
| Board | NB02 X5KK45xS_X5SP45xS |
| Firmware | UEFI AMI v N.1.20A13 (2025-10-14) |
| Hostname | din |

## CPU

| Field | Value |
|---|---|
| Model | AMD Ryzen AI 9 HX 370 w/ Radeon 890M |
| Architecture | Zen 5 |
| Cores / Threads | 12 cores / 24 threads |
| Base / Boost | ~605 MHz idle / up to 5158 MHz boost |
| Cache | L1 960 KiB · L2 12 MiB · L3 24 MiB |
| Features | AVX/AVX2, SMT, SVM (virtualisation), XDNA NPU |
| ODM TDP (set by tccd) | 100 W / 100 W / 105 W |

## RAM & Swap

| Field | Value |
|---|---|
| Total | 64 GiB (~61 GiB visible to OS) |
| Swapfile | 61.9 GiB at `/swap/swapfile` (prio 0) |
| zram | 61.9 GiB `/dev/zram0` (prio 100 — used first) |

## GPU — Discrete (dGPU)

| Field | Value |
|---|---|
| Model | NVIDIA GeForce RTX 5060 Laptop GPU (GB206M Max-Q/Mobile) |
| Architecture | **Blackwell** (RTX 50 series) — *not* Lovelace |
| VRAM | 8151 MiB (~8 GiB GDDR7) |
| Driver | `nvidia-open-dkms` 610.57.04 (open kernel module — **required** on Blackwell) |
| Bus / DRM node | PCIe `65:00.0` → `card1` / `renderD128` |

## GPU — Integrated (iGPU)

| Field | Value |
|---|---|
| Model | AMD Radeon 890M (Strix) |
| VRAM | 512 MiB dedicated + dynamic shared from system RAM |
| Driver | `amdgpu` (kernel) · Mesa 26.1.8 · `vulkan-radeon` 26.1.7 |
| Bus / DRM node | PCIe `66:00.0` → `card2` / `renderD129` |

### Hybrid graphics wiring — important

- **Both display outputs hang off the iGPU** (`card2`): `eDP-2` (internal panel) and `HDMI-A-2` (external). Hyprland composites on amdgpu.
- Panel **brightness** goes through `nvidia_wmi_ec_backlight` → `/sys/class/backlight/nvidia_0` (EC-based, 0–100). There is no `amdgpu_bl*` node. `brightnessctl` works.
- Xwayland/GLX defaults to the NVIDIA renderer (`glxinfo -B` reports RTX 5060).
- `supergfxctl` 5.2.7 is installed but `supergfxd` is **disabled/inactive** — no GPU mode switching in use.
- Pin the render device with `AQ_DRM_DEVICES` in `~/.config/hypr/monitors.lua` if the GPU misbehaves (currently commented out).

## Display

### Built-in — `eDP-2` (on amdgpu)
| Field | Value |
|---|---|
| Panel | BOE NE153QDM-NZ2, 15" |
| Resolution | 2560×1600 @ 120 Hz (panel rated up to 300 Hz) |
| Physical | 330×210 mm |

> Reports `disconnected` when the lid is closed — normal clamshell behaviour, not a driver fault.

### External — `HDMI-A-2` (on amdgpu)
| Field | Value |
|---|---|
| Monitor | Dell U3415W ultrawide (34") |
| Resolution | 3440×1440 @ 60 Hz, scale 1.6 |
| Physical | 800×330 mm |
| Serial | F1T1W01T0WTL |

## Storage

| Field | Value |
|---|---|
| Drive | WD BLACK SN7100 1TB NVMe SSD (`nvme0n1`) |
| Size | 931.5 GiB |
| Layout | `p1` 2 GiB vfat `/boot` · `p2` 929.5 GiB LUKS → btrfs (`/dev/mapper/root`) |
| Used / Free | ~403 GiB used / ~520 GiB free (44%) |

## Audio

- PipeWire 1.6.8 + WirePlumber (active)
- Devices: GB206 HD Audio · Radeon HD Audio · Ryzen HD Audio Controller
- Default sink & source: **Ryzen HD Audio Controller Analog Stereo** (internal speakers/mic, SN6140 codec)
- HDMI output available as "Radeon HD Audio Digital Stereo (HDMI 2)"
- Webcam: FHD WebCam (v4l2, 4 nodes)
- Known harmless boot message: `acp_asoc_acp70.0: No matching ASoC machine driver found` — the AMD ACP DSP path is unused; audio runs over legacy HDA.

## Network

| Device | Driver | Status |
|---|---|---|
| MediaTek MT7922 WiFi 6E (802.11ax) | `mt7921e` → `wlp99s0` | Up |
| Motorcomm YT6801 Gigabit Ethernet | **`dwmac-motorcomm` (mainline, kernel ≥7.1)** → `eno1` | Works out-of-box; `DOWN`/`NO-CARRIER` only when no cable |
| Bluetooth | MediaTek via `btusb` | Up |

> The old AUR `yt6801-dkms` workaround is **no longer needed** — the mainline stmmac-based `dwmac-motorcomm` driver binds `eno1` automatically.

## OS / Desktop Stack

| Field | Value |
|---|---|
| OS | Arch Linux with Omarchy 4.0.0.alpha (by DHH / Basecamp, github.com/basecamp/omarchy) |
| Kernel | 7.1.8-arch1-3 (mainline `linux`, non-LTS) + `linux-headers` |
| Firmware blobs | `linux-firmware` 20260810 + `linux-firmware-nvidia` |
| Desktop | Hyprland 0.56.2 (Wayland) |
| Display server | Wayland + Xwayland 24.1.13 |
| Shell | fish 4.8.1 |
| Packages | ~1144 (pacman) |
| Compilers | GCC 16.2.1 · Clang 22.1.8 |
| Firewall | ufw active (logs `[UFW BLOCK]` lines to dmesg) |

## Tuxedo-Specific Software

| Package | Version | State |
|---|---|---|
| `tuxedo-control-center-bin` | 3.0.9-1 | installed |
| `tuxedo-drivers-nocompatcheck-dkms` | 4.22.1-1 | built for 7.1.8-arch1-3 |
| `tccd` (daemon) | — | enabled + active at boot |

**Loaded TUXEDO modules:** `tuxedo_keyboard`, `tuxedo_io`, `uniwill_wmi`, `clevo_wmi`, `ite_8291`, `tuxedo_nb02_nvidia_power_ctrl`, `tuxedo_compatibility_check`

**What works via these drivers:**
- Fan control — tccd detects **2 fans**, uses `/dev/tuxedo_io` in manual mode with CPU + GPU curves
- ODM performance profiles / TDP limits
- RGB keyboard backlight — 125 per-key zones under `/sys/class/leds/rgb:kbd_backlight*` (brightness 0–50). Boot logs ~125 `Led rgb:kbd_backlight renamed ... due to name collision` lines from `ite_8291` — cosmetic.
- Fans are **not** exposed via hwmon (`fan*_input` is empty) — read them through TCC / `tuxedo_io`, not `sensors`.

## Sensors available

`k10temp` (CPU Tctl) · `amdgpu` · `nvme` · `mt7921_phy0` · `acpitz_0/1` · `spd5118` ×2 (DIMM temps) · `BAT0` · `AC0` · `ucsi_source_psy_USBC000:001/002`

No `charge_control_end_threshold` sysfs node — battery charge limiting must go through TCC, not sysfs.

## Known-harmless log noise

- `NVRM: nvAssertFailedNoLog: Assertion failed: 0 @ osapi.c:2145` ×~15 at boot — nvidia-open chatter
- `ite_8291 ... Led rgb:kbd_backlight renamed ... name collision` ×125
- `acp_asoc_acp70.0: warning: No matching ASoC machine driver found`
- `Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported`
- `block nvme0n1: No UUID available providing old NGUID`

## Upgrade / Compatibility Notes

- **RAM**: 64 GiB installed; likely maxed at 2×32 GiB DDR5 for this board
- **dGPU / CUDA**: Blackwell (SM 12.x) needs **CUDA ≥ 12.8** and the **open** NVIDIA kernel module. Do not switch to `nvidia-dkms`/proprietary — it does not support GB206.
- **Kernel**: mainline non-LTS, so DKMS modules (`nvidia-open-dkms`, `tuxedo-drivers-nocompatcheck-dkms`) rebuild on every kernel bump — verify with `dkms status` after upgrades. Stale entries for removed kernels are harmless; clean with `sudo dkms remove <module>/<ver> -k <old-kernel>`.
- **Why nocompatcheck**: the standard `tuxedo-drivers-dkms` refuses to load on this board revision; the nocompatcheck variant disables that gate.
- **Storage**: LUKS-encrypted btrfs — snapshots/subvolumes available
- **32-bit Vulkan**: `lib32-vulkan-radeon` is *not* installed (only `lib32-mesa`); install it if a 32-bit game needs Vulkan on the iGPU
