import QtQuick
import "code/osbFetcher.js" as OSB
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents

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

    // The actual logo (monitor + tiles) turns into an illegible blob at
    // panel-icon size (~22px) — a short text stamp reads far more clearly
    // that small, same idea as the digital clock widget.
    Text {
        anchors.centerIn: parent
        text: "OSB"
        color: compact.statusColor
        font.bold: true
        font.pixelSize: parent.height * 0.42
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
