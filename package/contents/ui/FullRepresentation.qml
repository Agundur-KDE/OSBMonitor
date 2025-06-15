// }

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

    Component.onCompleted: {
        buildModel.append({
            "package": "KCast",
            "status": "succeeded"
        });
    }

    ListView {
        id: buildList

        anchors.fill: parent
        spacing: 4
        model: buildModel
        clip: true

        delegate: Rectangle {
            width: buildList.width
            height: 32
            color: status === "failed" ? "#ffcccc" : status === "building" ? "#fffacc" : "#ddffdd"

            RowLayout {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: model["package"]
                    Layout.fillWidth: true
                    font.bold: true
                }

                Text {
                    text: model["status"]
                    color: "black"
                    Layout.alignment: Qt.AlignRight
                }

            }

        }

        header: Rectangle {
            height: 30
            color: "#cccccc"
            width: parent.width

            RowLayout {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: "Package"
                    font.bold: true
                    Layout.fillWidth: true
                }

                Text {
                    text: "Status"
                    font.bold: true
                    Layout.alignment: Qt.AlignRight
                }

            }

        }

    }

}
