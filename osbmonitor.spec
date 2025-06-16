Name:           osbmonitor
Version:        0.1.0
Release:        0
Summary:        KDE Plasma 6 applet to monitor
License:        GPL-3.0-or-later
URL:            https://www.opencode.net/agundur/osbmonitor
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

BuildRequires:  cmake
BuildRequires:  gcc-c++

BuildRequires: qt6-base-devel
BuildRequires: qt6-declarative-devel
BuildRequires: kf6-extra-cmake-modules
BuildRequires: qt6-tools-devel

Requires: plasma6-workspace

%global plasmoid_id de.agundur.osbmonitor

%description
OSBMonitor is a lightweight KDE Plasma 6 widget (Plasmoid) that monitors the build status of your [Open Build Service (OBS)](https://openbuildservice.org/) projects and packages. It provides at-a-glance visual feedback about the health of your builds, directly in your Plasma desktop panel.


%prep
%setup -q

%build
%cmake package
%cmake_build

%install
%cmake_install


%files
%license LICENSE
%doc README.md
%{_datadir}/plasma/plasmoids/de.agundur.osbmonitor/