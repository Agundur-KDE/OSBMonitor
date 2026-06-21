import QtQuick
import QtQuick.Layouts
import "code/osbFetcher.js" as OSB
import org.kde.kirigami as Kirigami
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
                overallStatus = OSB.summarizeWorstStatusFromModel(buildModel);
            } else {
                console.log("OSBMonitor: " + data["stderr"]);
                overallStatus = "error";
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
        onTriggered: executable.connectSource("osc api /build/" + target + "/_result")
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
