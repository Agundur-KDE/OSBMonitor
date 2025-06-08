import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root

    // Bindings zu deiner Config
    property string targetProject: Plasmoid.configuration.TargetProject
    property int refreshInterval: Plasmoid.configuration.RefreshInterval

    // Mindestgröße beim Start
    implicitWidth: Kirigami.Units.gridUnit * 30
    implicitHeight: Kirigami.Units.gridUnit * 25
    clip: true
    Plasmoid.title: i18n("OSB Monitor")
    Plasmoid.status: PlasmaCore.Types.ActiveStatus
    Component.onCompleted: {
        // Beispiel-Daten – später per request() ersetzen
        buildModel.clear();
        buildModel.append({
            "name": root.targetProject + "/package1",
            "status": "succeeded"
        });
        buildModel.append({
            "name": root.targetProject + "/package2",
            "status": "failed"
        });
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing
        spacing: Kirigami.Units.largeSpacing

        // Überschrift
        PlasmaComponents.Label {
            text: i18n("OSB Monitor")
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Kirigami.Theme.defaultFont.pointSize * 2
            Layout.fillWidth: true
            wrapMode: Text.Wrap
        }

        // Konfig-Projekt-Anzeige
        PlasmaComponents.Label {
            text: i18n("Monitoring project: %1").arg(root.targetProject)
            horizontalAlignment: Text.AlignHCenter
            color: Kirigami.Theme.disabledTextColor
            Layout.fillWidth: true
            wrapMode: Text.Wrap
        }

        // Scrollbare Liste der Build-Status
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ListView {
                id: buildListView

                anchors.fill: parent
                spacing: Kirigami.Units.smallSpacing
                clip: true
                model: buildModel

                delegate: RowLayout {
                    Layout.fillWidth: true
                    spacing: Kirigami.Units.largeSpacing

                    PlasmaComponents.Label {
                        text: name
                        Layout.fillWidth: true
                        wrapMode: Text.NoWrap
                        elide: Text.ElideRight
                    }

                    PlasmaComponents.Label {
                        text: status
                        font.bold: true
                        color: status === "succeeded" ? Kirigami.Theme.positiveTextColor : status === "failed" ? Kirigami.Theme.negativeTextColor : Kirigami.Theme.warningTextColor
                    }

                }

            }

        }

    }

    // Dynamisches Model statt ListElement-Ausdrücken
    ListModel {
        id: buildModel
    }

}
