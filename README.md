<div align="center">
  <h1>OSBMonitor</h1>
  <a href="https://kde.org/de/">
    <img src="https://img.shields.io/badge/KDE_Plasma-6.1+-blue?style=flat&logo=kde" alt="KDE Plasma">
  </a>
  <a href="https://www.gnu.org/licenses/gpl-3.0.html">
    <img src="https://img.shields.io/badge/License-GPLv3-blue.svg" alt="License: GPLv3">
  </a>
  <a href="https://build.opensuse.org/package/show/home:Agundur/OSBMonitor">
    <img src="https://build.opensuse.org/projects/home:Agundur/packages/OSBMonitor/badge.svg?type=default" alt="OBS build result">
  </a>
  <a href="https://paypal.me/agundur">
    <img src="https://img.shields.io/badge/donate-PayPal-%2337a556" alt="Donate via PayPal">
  </a>
</div>

## Description

OSBMonitor is a lightweight KDE Plasma 6 widget that watches your
[openSUSE Build Service](https://build.opensuse.org/) project and shows
build health at a glance, directly in the Plasma panel.

## Features

- **Dual view**: compact panel indicator, full popup with per-package status
- Monitors one configurable OBS project (`home:YourUser` etc.)
- **Configurable refresh interval** — default 5 minutes, adjustable from
  60 seconds up to an hour (Settings)

## Visuals

![Full Representation](OSBMonitor_1.png)
![Compact Representation](OSBMonitor_2.png)

## Install

Easiest: **"Get New Widgets"** in System Settings, or grab the `.plasmoid`
from the [latest release](https://github.com/Agundur-KDE/OSBMonitor/releases/latest)
and:
```bash
kpackagetool6 --type Plasma/Applet --install osbmonitor-*.plasmoid
```

Also available as a proper package, if you'd rather have `zypper`/`apt`
manage updates:
```bash
# openSUSE Tumbleweed
sudo zypper ar -f https://download.opensuse.org/repositories/home:/Agundur/openSUSE_Tumbleweed/home:Agundur.repo
sudo zypper --gpg-auto-import-keys ref
sudo zypper in osbmonitor

# Debian/Ubuntu — grab the .deb from the latest release above
```

Or straight from source, no build step needed:
```bash
git clone https://github.com/Agundur-KDE/OSBMonitor.git
kpackagetool6 --type Plasma/Applet --install OSBMonitor/package/
```

## Support

Open an issue: [OSBMonitor Issues](https://github.com/Agundur-KDE/OSBMonitor/issues)

## Contributing

Fork and adapt freely.

## License

GPL-3.0-or-later
