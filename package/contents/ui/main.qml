import QtQuick
import QtQuick.Layouts
import "code/osbFetcher.js" as OSB
import org.kde.kirigami as Kirigami
import org.kde.notification as Notification
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.plasma5support as Plasma5Support

PlasmoidItem {
    id: root

    property string target: Plasmoid.configuration.targetProject
    property int refreshInterval: Plasmoid.configuration.refreshInterval
    property alias buildModel: buildModel
    property var overallStatus: target ? "searching ..." : "not configured"
    // "" = no poll result seen yet -> suppress the notification on startup,
    // there's no real "change" to report until we have a first baseline.
    property string previousStatus: ""

    function reportStatus(newStatus) {
        if (previousStatus !== "" && newStatus !== previousStatus) {
            statusNotification.text = i18n("%1 → %2", previousStatus, newStatus)
            statusNotification.sendEvent()
        }
        previousStatus = newStatus
        overallStatus = newStatus
    }

    Notification.Notification {
        id: statusNotification
        componentName: "plasma_workspace"
        title: i18n("OSBMonitor: %1", root.target)
        iconName: Plasmoid.icon
    }

    // target is a free-text Settings field, interpolated straight into a
    // shell command below — quote it so a project name with shell
    // metacharacters can't break or inject into the command.
    function shellQuote(text) {
        return "'" + String(text).replace(/'/g, "'\\''") + "'";
    }

    implicitWidth: Kirigami.Units.gridUnit * 30
    implicitHeight: Kirigami.Units.gridUnit * 20
    clip: true
    preferredRepresentation: (width < 200 || height < 100) ? compactRepresentation : fullRepresentation

    Plasma5Support.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []

        onNewData: (sourceName, data) => {
            if (data["stdout"]) {
                OSB.parseXml(data["stdout"]);
                reportStatus(OSB.summarizeWorstStatusFromModel(buildModel));
            } else {
                console.log("OSBMonitor: " + data["stderr"]);
                reportStatus("error");
            }
            disconnectSource(sourceName);
        }
    }

    Timer {
        id: intervalTimer
        running: target !== ""
        repeat: true
        triggeredOnStart: true
        interval: refreshInterval * 1000
        onTriggered: executable.connectSource("osc api /build/" + shellQuote(target) + "/_result")
    }

    ListModel {
        id: buildModel
    }

    fullRepresentation: FullRepresentation {
        buildModel: root.buildModel
    }

    compactRepresentation: CompactRepresentation {
        overallStatus: root.overallStatus
    }
}
