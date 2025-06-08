<div align="center">
  <h1>OSBMonitor</h1>
  <a href="https://kde.org/de/">
  <img src="https://img.shields.io/badge/KDE_Plasma-6.1+-blue?style=flat&logo=kde" alt="KDE">
</a>
 <a href="https://www.gnu.org/licenses/gpl-3.0.html">
  <img src="https://img.shields.io/badge/License-GPLv3-blue.svg" alt="License: GPLv3">
</a>
  <a href="https://paypal.me/agundur">
  <img src="https://img.shields.io/badge/donate-PayPal-%2337a556" alt="PayPal">
</a>
  </a>
  <a href="https://store.kde.org/p/2290729">
  <img src="https://img.shields.io/badge/KDE%20Plasma-1D99F3?logo=kdeplasma&logoColor=fff" alt="OSBMonitor">
  
  <script src="https://liberapay.com/Agundur/widgets/button.js"></script>
<noscript><a href="https://liberapay.com/Agundur/donate"><img alt="Donate using Liberapay" src="https://liberapay.com/assets/widgets/donate.svg"></a></noscript>
</a></div>

## Description
OSBMonitor is a lightweight KDE Plasma 6 applet that displays real-time data from your solar inverter.

Developed for the APsystems EZ1 microinverter series, it connects to the local JSON API provided by the device and shows:
- 🌞 Live panel power (in Watts)
- 📊 Daily yield (in kWh)
- 🔄 Updates every 10 seconds

No cloud service, no third-party backend – all data stays local.

## ✅ Features

- Built with pure QML – no C++ or Python dependencies
- Compatible with Plasma 6
- Uses standard HTTP API (see: [APsystems EZ1 API Manual](https://forum.iobroker.net/assets/uploads/files/1701255814508-apsystems-ez1-local-api-user-manual.pdf))
- Clean UI for live monitoring



## Visuals
![psystems EZ1 power output](OsbMonitor.png)



## Installation
mkdir build && cd build

cmake ..

make

make install (as root)


### 🖱 KDE GUI (recommended)

1. Download `de.agundur.osbmonitor-X.Y.Z.plasmoid`
2. Drag & drop onto your KDE panel or desktop
3. Or install with:

```bash
kpackagetool6 --type Plasma/Applet --install de.agundur.osbmonitor-X.Y.Z.plasmoid
```

## 🛠️ Installing OSBMonitor via the openSUSE Build Service Repository

[![build result](https://build.opensuse.org/projects/home:Agundur/packages/OSBMonitor/badge.svg?type=default)](https://build.opensuse.org/package/show/home:Agundur/OSBMonitor)

For openSUSE Tumbleweed (and compatible systems):

```bash
# Add the repository
sudo zypper ar -f https://download.opensuse.org/repositories/home:/Agundur/openSUSE_Tumbleweed/home:Agundur.repo

# Automatically import GPG key (required once)
sudo zypper --gpg-auto-import-keys ref

# Refresh repository metadata
sudo zypper ref

# Install OSBMonitor
sudo zypper in OSBMonitor
```


## Usage
Enable the local API of your APsystems EZ1-M

and 

add the plasmoid to your desktop and enjoy.

## Support
Open an issue in git ...

[OSBMonitor Issues](https://www.opencode.net/agundur/osbmonitor/-/issues)


## Roadmap


## Contributing
accepting contributions ...

[OSBMonitor](https://www.opencode.net/agundur/osbmonitor)



## Authors and acknowledgment
Alec

## License
GPL


## Project status
active
