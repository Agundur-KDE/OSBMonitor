import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root

    // Wechsel zwischen compact/full abhängig von der Größe
    preferredRepresentation: (width < 200 || height < 100) ? compactRepresentation : fullRepresentation

    fullRepresentation: FullRepresentation {
        focus: true
    }

    compactRepresentation: CompactRepresentation {
        focus: true
    }

}
