import QtQuick
import QtQuick.Layouts
import "code/osbFetcher.js" as OSB
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    // alles geschieht im JS selbst (siehe oben)

    id: root

    // zentrales Datenmodell
    property ListModel buildModel
    property var tableHeaders: []

    // Funktion zum Datenholen
    function reload(projectName) {
        const url = "https://build.opensuse.org/project/monitor/" + projectName;
        console.log(url);
        console.log("📡 Fetching build status for:", projectName);
        OSB.fetchBuildStatus(url, function(result) {
        });
    }

    implicitWidth: Kirigami.Units.gridUnit * 30
    implicitHeight: Kirigami.Units.gridUnit * 20
    clip: true
    preferredRepresentation: (width < 200 || height < 100) ? compactRepresentation : fullRepresentation

    // Beobachterobjekt für Config
    QtObject {
        id: observer

        property string currentProject: "Application:Astrophotography"

        function update() {
            if (root.configuration && root.configuration.TargetProject && root.configuration.TargetProject.length > 0) {
                currentProject = root.configuration.TargetProject;
                console.log("✅ Config loaded:", currentProject);
            } else {
                console.log("⚠️ TargetProject not set – fallback used.");
                currentProject = "Application:Astrophotography";
            }
        }

        Component.onCompleted: update()
    }

    // Timer zum Refresh
    Timer {
        id: refreshTimer

        interval: 30000
        repeat: true
        running: false
        onTriggered: reload(observer.currentProject)
    }

    // Verzögerter Start, wenn config geladen
    Timer {
        interval: 300
        running: true
        repeat: false
        onTriggered: {
            observer.update();
            reload(observer.currentProject);
            refreshTimer.start();
        }
    }

    buildModel: ListModel {
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