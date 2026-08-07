pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Networking
import Quickshell.Hyprland
import Quickshell.Bluetooth
import "common"
import "modules"

LazyLoader {
    loading: true

    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 20
        color: "#11111b"

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }

        // Left
        ZRow {
            anchors.left: parent.left
            anchors.leftMargin: 8

            WorkspaceNumber {}
        }

        // Middle
        ZText {
            anchors.centerIn: parent
            text: Qt.formatDateTime(clock.date, "hh:mm")
        }

        // Right
        ZRow {
            anchors.right: parent.right
            anchors.rightMargin: 8
            spacing: 8

            Bluetooth {}

            Battery {}

            Network {}
        }
    }
}
