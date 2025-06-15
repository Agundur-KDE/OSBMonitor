import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami

KCM.SimpleKCM {
    id: root

    property alias cfg_targetProject: update_targetProject.text
    property alias cfg_refreshInterval: update_refreshInterval.value
    property string cfg_targetProjectDefault: "home:Agundur"
    property int cfg_refreshIntervalDefault: 60

    Kirigami.FormLayout {
        QQC2.TextField {
            id: update_targetProject

            Kirigami.FormData.label: i18n("OBS project name")
            text: plasmoid.configuration.targetProject // Initialwert
            onTextChanged: {
                plasmoid.configuration.targetProject = text;
            }
        }

        QQC2.SpinBox {
            id: update_refreshInterval

            Kirigami.FormData.label: i18n("Refresh interval (seconds)")
            from: 10
            to: 3600
            onValueChanged: plasmoid.configuration.refreshInterval = value
        }

    }

}
