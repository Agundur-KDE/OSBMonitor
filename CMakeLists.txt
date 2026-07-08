cmake_minimum_required(VERSION 3.16)
project(osbmonitor)

set(KF6_MIN_VERSION "6.10.0")

find_package(ECM ${KF6_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(ECMInstallIcons)

set(PLASMOID_ID de.agundur.osbmonitor)

install(DIRECTORY package/ DESTINATION ${KDE_INSTALL_DATADIR}/plasma/plasmoids/${PLASMOID_ID})

ecm_install_icons(
    ICONS icons/16-apps-osbmonitor.png
          icons/22-apps-osbmonitor.png
          icons/32-apps-osbmonitor.png
          icons/48-apps-osbmonitor.png
          icons/64-apps-osbmonitor.png
          icons/128-apps-osbmonitor.png
          icons/256-apps-osbmonitor.png
    DESTINATION ${KDE_INSTALL_ICONDIR}
)
