import QtQuick
import QtQuick.Layouts
import "code/osbFetcher.js" as OSB
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid

DropArea {
    id: compact
    property string overallStatus: "unknown"

    Layout.minimumWidth: Kirigami.Units.iconSizes.small
    Layout.minimumHeight: Kirigami.Units.iconSizes.small
    implicitWidth: Kirigami.Units.iconSizes.medium
    implicitHeight: Kirigami.Units.iconSizes.medium

    readonly property color statusColor: {
        switch (OSB.statusCategory(overallStatus)) {
            case "good": return Kirigami.Theme.positiveTextColor
            case "warn": return Kirigami.Theme.neutralTextColor
            case "bad": return Kirigami.Theme.negativeTextColor
            default: return Kirigami.Theme.disabledTextColor
        }
    }

    Kirigami.Icon {
        anchors.centerIn: parent
        width: Math.min(parent.width, parent.height) * 0.8
        height: width
        source: Plasmoid.icon
    }

    // Small status dot in the corner — same idea as unread/online badges
    // elsewhere in Plasma, cheaper than tinting the whole multi-color logo.
    Rectangle {
        width: Math.max(6, compact.width * 0.28)
        height: width
        radius: width / 2
        color: compact.statusColor
        border.color: Kirigami.Theme.backgroundColor
        border.width: 1
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: Plasmoid.expanded = !Plasmoid.expanded
        PlasmaComponents.ToolTip.visible: containsMouse
        PlasmaComponents.ToolTip.text: i18n("OSBMonitor: %1", compact.overallStatus)
    }
}
