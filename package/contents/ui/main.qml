import QtQuick 2.15
import QtQuick.Controls 6.5 // Controls für Qt 6
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0 // sehr wichtig für preferredRepresentation

PlasmoidItem {
    id: root

    property string overallStatus: {
        for (let i = 0; i < buildModel.count; ++i) if (buildModel.get(i).status !== "succeeded") {
            return "failed";
        }
        return "succeeded";
    }

    // Choose representation based on containment
    Plasmoid.preferredRepresentation: root.containment.location === PlasmaCore.Types.Panel ? Plasmoid.compactRepresentation : Plasmoid.fullRepresentation
    Component.onCompleted: {
        // Temp-Daten; später durch deine API-Logik ersetzen
        buildModel.clear();
        buildModel.append({
            "name": plasmoid.configuration.TargetProject + "/pkg1",
            "status": "succeeded"
        });
        buildModel.append({
            "name": plasmoid.configuration.TargetProject + "/pkg2",
            "status": "failed"
        });
    }

    // ---------------------------------------------------------------------
    // Gemeinsame Logik
    ListModel {
        id: buildModel
    }

    // ---------------------------------------------------------------------
    // 1) Full Representation (Desktop)
    Plasmoid.fullRepresentation: Item {
        implicitWidth: Kirigami.Units.gridUnit * 40
        implicitHeight: Kirigami.Units.gridUnit * 35
        clip: true

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Kirigami.Units.largeSpacing
            spacing: Kirigami.Units.largeSpacing

            PlasmaComponents.Label {
                text: i18n("OSB Monitor")
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Kirigami.Theme.defaultFont.pointSize * 2
                Layout.fillWidth: true
                wrapMode: Text.Wrap
            }

            PlasmaComponents.Label {
                text: i18n("Monitoring project: %1").arg(plasmoid.configuration.TargetProject)
                horizontalAlignment: Text.AlignHCenter
                color: Kirigami.Theme.disabledTextColor
                Layout.fillWidth: true
                wrapMode: Text.Wrap
            }

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
                            color: status === "succeeded" ? Kirigami.Theme.positiveTextColor : Kirigami.Theme.negativeTextColor
                        }

                    }

                }

            }

        }

    }

    // ---------------------------------------------------------------------
    // 2) Compact Representation (Panel)
    Plasmoid.compactRepresentation: Item {
        implicitWidth: Kirigami.Units.gridUnit * 10
        implicitHeight: Kirigami.Units.gridUnit * 10
        clip: true

        PlasmaComponents.Label {
            anchors.centerIn: parent
            text: overallStatus === "succeeded" ? i18n("Success") : i18n("Error")
            font.pixelSize: Kirigami.Theme.defaultFont.pointSize * 1.5
            color: overallStatus === "succeeded" ? Kirigami.Theme.positiveTextColor : Kirigami.Theme.negativeTextColor
            horizontalAlignment: Text.AlignHCenter
        }

    }

}
