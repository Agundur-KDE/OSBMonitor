import QtQuick
import "code/osbFetcher.js" as OSB
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid

DropArea {
    id: compact
    property string overallStatus: "unknown"
    signal toggleExpanded()

    readonly property color statusColor: {
        switch (OSB.statusCategory(overallStatus)) {
            case "good": return Kirigami.Theme.positiveTextColor
            case "warn": return Kirigami.Theme.neutralTextColor
            case "bad": return Kirigami.Theme.negativeTextColor
            default: return Kirigami.Theme.disabledTextColor
        }
    }

    // No explicit size here — same as KClaude's compact view, the panel
    // already gives an icon-only applet a sane default square size.
    Kirigami.Icon {
        anchors.fill: parent
        source: Plasmoid.icon
        isMask: true
        color: compact.statusColor
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: compact.toggleExpanded()
        PlasmaComponents.ToolTip.visible: containsMouse
        PlasmaComponents.ToolTip.text: i18n("OSBMonitor: %1", compact.overallStatus)
    }
}
