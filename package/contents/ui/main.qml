import QtQuick
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root

    property string overallStatus: {
        for (let i = 0; i < buildModel.count; ++i) if (buildModel.get(i).status !== "succeeded") {
            return "failed";
        }
        return "succeeded";
    }

    implicitWidth: Kirigami.Units.gridUnit * 30
    implicitHeight: Kirigami.Units.gridUnit * 25
    clip: true
    // Wechsel zwischen compact/full abhängig von der Größe
    preferredRepresentation: (width < 200 || height < 100) ? compactRepresentation : fullRepresentation
    Component.onCompleted: {
        // Temp-Daten; später durch deine API-Logik ersetzen
        buildModel.clear();
        buildModel.append({
            "name": plasmoid.configuration.TargetProject + "/pkg1",
            "status": "succeeded"
        });
        buildModel.append({
            "name": plasmoid.configuration.TargetProject + "/pkg2",
            "status": "failed"
        });
    }

    ListModel {
        id: buildModel
    }

    fullRepresentation: FullRepresentation {
        focus: true
    }

    compactRepresentation: CompactRepresentation {
        focus: true
    }

}
