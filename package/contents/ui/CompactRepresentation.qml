import QtQuick
import QtQuick.Layouts
import "code/osbFetcher.js" as OSB
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid

DropArea {
    property string overallStatus: "unknown"

    width: 200
    height: 40

    PlasmaComponents.Label {
        anchors.centerIn: parent
        text: "Status: " + overallStatus
        width: parent.width - Kirigami.Units.largeSpacing * 2
        wrapMode: Text.Wrap
        font.pixelSize: Kirigami.Theme.defaultFont.pointSize * 1.5
        color: overallStatus === "succeeded" ? Kirigami.Theme.positiveTextColor : Kirigami.Theme.negativeTextColor
        horizontalAlignment: Text.AlignHCenter
    }

}