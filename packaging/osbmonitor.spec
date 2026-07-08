%ifarch aarch64
%undefine source_date_epoch_from_changelog
%endif

Name:           osbmonitor
Version:        0.1.0
Release:        1%{?dist}
Summary:        KDE Plasma 6 panel widget for openSUSE Build Service status

License:        GPL-3.0-or-later
URL:            https://github.com/Agundur-KDE/OSBMonitor


BuildRequires:  cmake
BuildRequires:  gcc-c++
BuildRequires:  qt6-base-devel
BuildRequires:  qt6-declarative-devel
BuildRequires:  kf6-extra-cmake-modules


Requires:       plasma6-workspace
Requires:       osc

%description
OSBMonitor is a lightweight KDE Plasma 6 widget (Plasmoid) that monitors the
build status of your Open Build Service (OBS) projects and packages. It
provides at-a-glance visual feedback about the health of your builds,
directly in your Plasma desktop panel.

Source0: _service

%prep

rm -rf ./*

shopt -s nullglob
picked=""
for d in %{_sourcedir}/OSBMonitor-* %{_sourcedir}/osbmonitor-* %{_sourcedir}/OSBMonitor ; do
  if [ -d "$d" ] && [ -f "$d/CMakeLists.txt" ]; then
    picked="$d"
    break
  fi
done

if [ -n "$picked" ]; then
  cp -a "$picked"/. .
else
  for f in %{_sourcedir}/* ; do
    base="$(basename "$f")"
    case "$base" in
      *.spec|*.dsc|*.changes|*.obsinfo|_service|service_attic|screenshot|*.patch)
        continue ;;
    esac
    cp -a "$f" .
  done
fi

%build
%cmake \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DCMAKE_INSTALL_PREFIX=%{_prefix}
%cmake_build

%install
%cmake_install


%files
%license LICENSE
%doc README.md
%{_datadir}/plasma/plasmoids/de.agundur.osbmonitor/

%changelog
* Wed Jul 08 2026 Alec <info@agundur.de> - 0.1.0
- First automated OBS release via GitHub Actions (obs_scm pinned to the tag)
- Fixed Source0 tarball name mismatch (_service filename param said "ezmonitor")
- Added osc as a runtime Requires (main.qml shells out to it)
- Fixed URL (was pointing at a non-existent opencode.net address)
