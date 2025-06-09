import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.ksvg as KSvg
import org.kde.plasma.components as PC3
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.private.kicker as Kicker

PlasmoidItem {
    id: root

    preferredRepresentation: fullRepresentation
    switchWidth: fullRepresentationItem ? fullRepresentationItem.Layout.minimumWidth : Kirigami.Units.iconSizes.small * 10
    switchHeight: fullRepresentationItem ? fullRepresentationItem.Layout.minimumHeight : Kirigami.Units.iconSizes.small * 10

    fullRepresentation: FullRepresentation {
        focus: true
    }

    compactRepresentation: MouseArea {
        id: compactRoot

        DropArea {
            id: compactDragArea

            anchors.fill: parent

            RowLayout {
                id: iconLabelRow

                anchors.fill: parent
                spacing: 0

                PC3.Label {
                    anchors.centerIn: parent
                    text: "Compact"
                }

            }

        }

    }

}
