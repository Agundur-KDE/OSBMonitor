import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami

KCM.SimpleKCM {
    id: root

    property alias cfg_targetProject: update_targetProject.text
    property alias cfg_refreshInterval: update_refreshInterval.value

    Kirigami.FormLayout {
        QQC2.TextField {
            id: update_targetProject
            Kirigami.FormData.label: i18n("OBS project name")
            placeholderText: "home:YourUser"
        }

        QQC2.Label {
            text: i18n("Requires osc to be installed and configured (~/.config/osc/oscrc)")
            font.italic: true
            wrapMode: Text.Wrap
            Layout.fillWidth: true
        }

        QQC2.SpinBox {
            id: update_refreshInterval
            Kirigami.FormData.label: i18n("Refresh interval (seconds)")
            from: 60
            to: 3600
        }
    }
}
