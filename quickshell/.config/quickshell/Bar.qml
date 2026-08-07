pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Networking
import Quickshell.Hyprland
import Quickshell.Bluetooth
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
            text: "#" + (Hyprland.focusedWorkspace?.id ?? "")
        }

        // Clock
        ZText {
            anchors.centerIn: parent
            text: Qt.formatDateTime(clock.date, "hh:mm")
        }

        // Right
        Row {
            id: barRight
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 8
            spacing: 8

            // Bluetooth
            readonly property bool btEnabled: Bluetooth.defaultAdapter.enabled
            ZText {
                visible: barRight.btEnabled
                text: {
                    Bluetooth.defaultAdapter.devices?.values[0]?.connected ? "󰂱" : "󰂯";
                }
            }

            Splitter {
                visible: barRight.btEnabled
            }

            // Battery
            ZText {
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
                        90: "󰂂",
                        100: "󰁹"
                    };
                    return map[level] || "󰂃";
                }
            }

            Splitter {
                visible: UPower.displayDevice.isLaptopBattery
            }

            // Network
            ZText {
                text: {
                    let netDevice = null;
                    for (let d of Networking.devices.values)
                        if (d.connected && (d.type === DeviceType.Wifi || d.type === DeviceType.Wired))
                            netDevice = d;
                    if (!netDevice?.connected)
                        return "󰤭";
                    if (netDevice.type === DeviceType.Wired)
                        return "󰈀";
                    let active = netDevice.networks?.values?.find(n => n.connected);
                    if (!active)
                        return "";
                    let s = active.signalStrength;
                    if (s > 0.75)
                        return "󰤨";
                    if (s > 0.5)
                        return "󰤥";
                    if (s > 0.25)
                        return "󰤢";
                    return "󰤟";
                }
            }
        }
    }
}
