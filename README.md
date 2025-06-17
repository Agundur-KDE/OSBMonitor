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
OSBMonitor is a lightweight KDE Plasma 6 applet that displays build status from your Open Suse Build service projects


## ✅ Features

- Built with pure QML – no C++ or Python dependencies


## Visuals
![Full Representation](OSBMonitor_1.png)
![Compact Representation](OSBMonitor_2.png)


## Installation

```bash
mkdir build && cd build

cmake ..

make

make install (as root)
```

### 🖱 KDE GUI

1. Download `de.agundur.osbmonitor.plasmoid`
2. install with:

```bash
plasmapkg2  --type Plasma/Applet -i de.agundur.osbmonitor.plasmoid
```

## 🛠️ Installing OSBMonitor via the openSUSE Build Service Repository  (recommended)


```bash
# Add the repository
sudo zypper ar -f https://download.opensuse.org/repositories/home:/Agundur/openSUSE_Tumbleweed/home:Agundur.repo

# Automatically import GPG key (required once)
sudo zypper --gpg-auto-import-keys ref

# Refresh repository metadata
sudo zypper ref

# Install OSBMonitor
sudo zypper in osbmonitor
```


## Support
Open an issue in git ...


## Contributing
accepting contributions ...


## Authors and acknowledgment
Alec

## License
GPL


## Project status
active
