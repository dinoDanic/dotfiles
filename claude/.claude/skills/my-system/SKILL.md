---
name: my-system
description: Full hardware specs and software environment for Dino's TUXEDO laptop. Use when user asks hardware questions, upgrade advice, compatibility checks, driver issues, performance tuning, or anything requiring knowledge of this specific machine's specs.
---

# My System — TUXEDO InfinityBook Max 15 AMD Gen10

## Machine

| Field | Value |
|---|---|
| Model | TUXEDO InfinityBook Max 15 AMD Gen10 |
| Board | NB02 X5KK45xS_X5SP45xS |
| Firmware | UEFI AMI v N.1.20A13 (2025-10-14) |

## CPU

| Field | Value |
|---|---|
| Model | AMD Ryzen AI 9 HX 370 w/ Radeon 890M |
| Architecture | Zen 5 |
| Cores / Threads | 12 cores / 24 threads |
| Base / Boost | ~605 MHz idle / up to 5158 MHz boost |
| Cache | L1 960 KiB · L2 12 MiB · L3 24 MiB |
| Features | AVX/AVX2, SMT, SVM (virtualisation), NPU (AI accelerator) |

## RAM

| Field | Value |
|---|---|
| Total | 64 GiB |
| Available to OS | ~62 GiB |
| Swap | 62 GiB swapfile + 4 GiB zram |

## GPU — Discrete (dGPU)

| Field | Value |
|---|---|
| Model | NVIDIA GeForce RTX 5060 Laptop GPU (GB206M Max-Q/Mobile) |
| Architecture | Lovelace (RTX 50 series) |
| VRAM | 8151 MiB (~8 GiB GDDR7) |
| Driver | nvidia 595.58.03 (proprietary) |
| Bus | PCIe @ 65:00.0 |

## GPU — Integrated (iGPU)

| Field | Value |
|---|---|
| Model | AMD Radeon 890M (Strix) |
| VRAM | 512 MiB dedicated + dynamic shared from system RAM |
| Driver | amdgpu (kernel) |
| Current render | Active (default for Wayland/Hyprland via radeonsi) |
| Bus | PCIe @ 66:00.0 |

## Display

### Built-in (eDP-2) — primary
| Field | Value |
|---|---|
| Panel | BOE NE153QDM-NZ2, 15" |
| Resolution | 2560×1600 @ 120 Hz (up to 300 Hz) |
| Scale | 1.33× (Hyprland HiDPI) |
| Physical | 330×210 mm |

### External (HDMI-A-2) — also connected
| Field | Value |
|---|---|
| Monitor | Dell U3415W ultrawide |
| Resolution | 3440×1440 @ 60 Hz |
| Physical | 800×330 mm (34") |
| Serial | F1T1W01T0WTL |

## Storage

| Field | Value |
|---|---|
| Drive | WD BLACK SN7100 1TB NVMe SSD |
| Size | 931.5 GiB |
| Filesystem | btrfs on dm-crypt (LUKS encryption) |
| Used / Free | ~251 GiB used / ~680 GiB free |
| Boot | 2 GiB EFI partition (vfat) |

## Audio

- PipeWire 1.6.2 (active)
- Sources: NVIDIA HD Audio · AMD Radeon HD Audio · AMD Audio Coprocessor · AMD Ryzen HD Audio

## Network

| Device | Driver | Status |
|---|---|---|
| MediaTek MT7922 WiFi 6E (802.11ax) | mt7921e | Up |
| Motorcomm YT6801 Gigabit Ethernet | N/A | Driver missing (not working out-of-box) |
| Bluetooth | MediaTek via btusb (USB) | Up |

## OS / Desktop Stack

| Field | Value |
|---|---|
| OS | Arch Linux with Omarchy 3.5.0 (by DHH / Basecamp, github.com/basecamp/omarchy) |
| Kernel | 6.19.11-arch1-1 |
| Desktop | Hyprland 0.54.3 (Wayland) |
| Display server | Wayland + Xwayland 24.1.9 |
| Shell | fish |
| Packages | ~1099 (pacman) |
| Compilers | GCC 15.2.1 · Clang 22.1.2 |

## Tuxedo-Specific Software

| Package | Version |
|---|---|
| tuxedo-control-center | 2.1.21-1 |
| tuxedo-drivers-nocompatcheck-dkms | 4.15.2-1 |
| tccd (daemon) | running, enabled at boot |

## Upgrade / Compatibility Notes

- **RAM**: 64 GiB already installed — check max supported by board before expanding (likely maxed out at 2×32 GiB DDR5)
- **dGPU**: RTX 5060 Mobile uses Lovelace; CUDA 12.x+ required for AI/ML workloads
- **iGPU**: Radeon 890M handles daily Wayland rendering; PRIME offload to NVIDIA for heavy tasks
- **Ethernet**: YT6801 driver not loaded — may need `yt6801` kernel module or AUR package
- **Kernel**: Running mainline Arch kernel (non-LTS); Tuxedo drivers use nocompatcheck DKMS variant
- **Storage**: NVMe is encrypted with LUKS; btrfs allows snapshots/subvolumes
