import QtQuick
import QtQuick.Layouts
import "code/osbFetcher.js" as OSB
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid

DropArea {
    property var buildModel

    width: 200
    height: 40

    PlasmaComponents.Label {
        anchors.centerIn: parent
        text: overallStatus === "succeeded" ? i18n("Success") : i18n("Error")
        font.pixelSize: Kirigami.Theme.defaultFont.pointSize * 1.5
        color: overallStatus === "succeeded" ? Kirigami.Theme.positiveTextColor : Kirigami.Theme.negativeTextColor
        horizontalAlignment: Text.AlignHCenter
    }

}