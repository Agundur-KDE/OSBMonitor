import QtQuick
import QtQuick.Layouts
import "code/osbFetcher.js" as OSB
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root

    property string target: Plasmoid.configuration.targetProject
    property int refreshInterval: Plasmoid.configuration.refreshInterval
    property alias buildModel: buildModel

    implicitWidth: Kirigami.Units.gridUnit * 30
    implicitHeight: Kirigami.Units.gridUnit * 20
    clip: true
    preferredRepresentation: (width < 200 || height < 100) ? compactRepresentation : fullRepresentation
    Component.onCompleted: {
        console.log("interval: " + refreshInterval * 1000);
        console.log("TargetProject: " + target);
    }

    // Beobachterobjekt für Config
    Timer {
        id: intervalTimer

        running: true
        repeat: true
        triggeredOnStart: true
        interval: refreshInterval * 1000
        onTriggered: OSB.fetchBuildStatus('https://build.opensuse.org/project/monitor/' + target, OSB.parseHtml)
    }

    ListModel {
        id: buildModel
    }

    // Darstellungen binden das zentrale Modell
    fullRepresentation: FullRepresentation {
        id: full

        buildModel: root.buildModel
    }

    compactRepresentation: CompactRepresentation {
        id: compact

        buildModel: root.buildModel
    }

}