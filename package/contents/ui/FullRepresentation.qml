import QtQuick
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid

DropArea {
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

        KCM.ScrollView {
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
