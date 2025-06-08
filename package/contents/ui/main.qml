import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root

    property string targetProject: Plasmoid.configuration.TargetProject
    property int refreshInterval: Plasmoid.configuration.RefreshInterval

    Plasmoid.title: i18n("OSB Monitor")
    Plasmoid.status: PlasmaCore.Types.ActiveStatus

    ColumnLayout {
        anchors.fill: parent
        spacing: Kirigami.Units.smallSpacing

        PlasmaComponents.Label {
            text: i18n("OSB Monitor")
            font.pixelSize: Kirigami.Theme.defaultFont.pointSize * 2
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        PlasmaComponents.Label {
            text: i18n("Monitoring project: %1").arg(root.targetProject)
            color: Kirigami.Theme.disabledTextColor
            Layout.alignment: Qt.AlignHCenter
        }

        ListView {
            id: buildList

            Layout.fillWidth: true
            Layout.fillHeight: true

            model: ListModel {
                ListElement {
                    name: "home:Agundur/EZMonitor"
                    status: "succeeded"
                }

                ListElement {
                    name: "home:Agundur/OSBMonitor"
                    status: "failed"
                }

            }

            delegate: RowLayout {
                spacing: Kirigami.Units.largeSpacing
                Layout.fillWidth: true

                PlasmaComponents.Label {
                    text: name
                    Layout.fillWidth: true
                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                }

                PlasmaComponents.Label {
                    text: status
                    color: status === "succeeded" ? "green" : status === "failed" ? "red" : "orange"
                    font.bold: true
                }

            }

        }

    }

}
