import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root

    property string targetProject: Plasmoid.configuration.TargetProject
    property int refreshInterval: Plasmoid.configuration.RefreshInterval //8050

    function callback(x) {
    }

    function request(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = (function f() {
            callback(xhr);
        });
        xhr.open('GET', url, true);
        xhr.send();
    }

    Plasmoid.title: i18n("OSB Monitor")
    Plasmoid.status: PlasmaCore.Types.ActiveStatus
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground
    Layout.minimumWidth: Kirigami.Units.gridUnit * 5
    Layout.minimumHeight: Kirigami.Units.gridUnit * 5
    implicitHeight: Kirigami.Units.gridUnit * 10
    implicitWidth: Kirigami.Units.gridUnit * 10

    fullRepresentation: ColumnLayout {
        readonly property bool isVertical: {
            switch (Plasmoid.formFactor) {
            case PlasmaCore.Types.Planar:
            case PlasmaCore.Types.MediaCenter:
            case PlasmaCore.Types.Application:
            default:
                if (root.height > root.width)
                    return true;
                else
                    return false;
            }
        }

        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        spacing: 5
        width: isVertical ? root.width : implicitWidth
        height: isVertical ? implicitHeight : root.height

        Kirigami.Heading {
            text: "KCast"
            level: 2
            Layout.fillWidth: true
        }

        PlasmaComponents.Label {
            font: Kirigami.Theme.defaultFont
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.leftMargin: 5
            wrapMode: Text.Wrap
            text: i18n("OSB home:" + targetProject)
        }

    }

}