import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts
import "code/osbFetcher.js" as OSB
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid

DropArea {
    property var buildModel
    property var tableHeaders: ["name", "i586", "x86_64"] // wird zur Laufzeit ersetzt
    property alias buildTableModel: buildTable.model

    width: 300
    height: 200

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

        Frame {
            Layout.fillWidth: true
            Layout.fillHeight: true

            TableView {
                id: buildTable

                anchors.fill: parent
                clip: true
                Component.onCompleted: {
                    for (let i = 0; i < root.tableHeaders.length; ++i) {
                        const role = root.tableHeaders[i];
                        buildTable.setColumn(i, {
                            "role": role,
                            "title": role,
                            "width": role === "name" ? 140 : 80
                        });
                    }
                    console.log("🪵 Headers:", root.tableHeaders);
                    console.log("🪵 Rows:", buildTable.model.count);
                }

                delegate: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 30
                    border.color: "#ccc"
                    color: model[TableView.role] === "failed" ? "#fdd" : "#dfd"

                    Text {
                        anchors.centerIn: parent
                        text: model[TableView.role] || "-"
                        font.pixelSize: 13
                    }

                }

            }

        }

    }

}
