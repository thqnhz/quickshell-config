pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.UPower
import "common"

LazyLoader {
    loading: true

    PanelWindow {
        id: bar
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

        // Workspace number
        ZText {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 8
            text: "#" + Hyprland.focusedWorkspace?.id ?? ""
        }

        // Clock
        ZText {
            anchors.centerIn: parent
            text: Qt.formatDateTime(clock.date, "hh:mm")
        }

        // Battery
        ZText {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 8
            visible: UPower.displayDevice.isLaptopBattery
            text: {
                let percent = Math.round((UPower.displayDevice.percentage ?? 0) * 100);
                let level = Math.floor(percent / 10) * 10;
                let map = {
                    10: "󰁺",
                    20: "󰁻",
                    30: "󰁼",
                    40: "󰁽",
                    50: "󰁾",
                    60: "󰁿",
                    70: "󰂀",
                    80: "󰂁",
                    90: "󰂂"
                };
                if (level < 10)
                    return "󰂃";
                else if (level === 100)
                    return "󰁹";
                else
                    return map[level];
            }
        }
    }
}
