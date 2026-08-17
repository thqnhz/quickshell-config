pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    // -----Text-----
    readonly property string fontFamily: "CaskaydiaCove Nerd Font Propo"
    readonly property int fontSize: 14
    readonly property int fontSizePopup: 20
    readonly property int fontWeight: 600

    // -----Bar-----
    readonly property int barHeight: 20

    // -----Splitter-----
    readonly property int splitterHeight: 12
    readonly property int splitterWidth: 1

    // -----Row-----
    readonly property int rowSpacing: 8

    // -----Timers-----
    readonly property int every5s: 5000
    readonly property int every10m: 600000

    // -----Animations-----
    readonly property int barAppearAnimationDuration: 800
    readonly property int colorAnimationDuration: 500
    readonly property int numberAnimationDuration: 300

    // -----Memory-----
    readonly property int ramUsageThreshold: 80

    // -----Battery-----
    readonly property bool hidePercentageWhenFull: true
    readonly property int batteryThreshold: 10

    // -----Cpu-----
    readonly property int cpuTempThreshold0: 40
    readonly property int cpuTempThreshold1: 50
    readonly property int cpuTempThreshold2: 60

    // -----Weather-----
    readonly property int coldThreshold: 20 // 20C is cold af here
    readonly property int hotThreshold: 35 // 35C is quite hot

    // -----Volume-----
    readonly property int volumeThreshold0: 80
    readonly property int volumeThreshold1: 100
    readonly property int volumeThreshold2: 120
    readonly property real volumeScrollStep: 0.05
    readonly property int volumePopupWidth: 40
    readonly property int volumePopupHeight: 160
    readonly property int volumePopupLevelWidth: 8
    readonly property int volumePopupLevelHeight: 100

    // -----Power-----
    readonly property int powerPopupWidth: 44
    readonly property int powerPopupHeight: 160
    readonly property int powerConfirmMinDelay: 300
    readonly property int powerConfirmTimeout: 3000
    readonly property string powerConfirmIcon: "󰄬"

    // -----Commands-----
    readonly property var bluetoothSettings: ["kcmshell6", "kcm_bluetooth"]
    readonly property var networkSettings: ["kcmshell6", "kcm_networkmanagement"]
    readonly property var sleepCommand: ["bash", "-c", "systemctl suspend || loginctl suspend"]
    readonly property var lockCommand: ["hyprlock"]
    readonly property var logoutCommand: ["hyprctl", "dispatch", "hl.dsp.exit()"]
    readonly property var shutdownCommand: ["systemctl", "poweroff"]
    readonly property var restartCommand: ["systemctl", "reboot"]

    // -----Scrolling-----
    readonly property bool reverseScrolling: true // Make it false for trackpad behavior

    // Predefined Palette (Catppuccin Mocha)
    readonly property color crust: "#11111b"
    readonly property color mantle: "#181825"
    readonly property color overlay0: "#6c7086"
    readonly property color overlay2: "#585b70"
    readonly property color text: "#cdd6f4"
    readonly property color red: "#f38ba8"
    readonly property color sapphire: "#74c7ec"
    readonly property color teal: "#94e2d5"
    readonly property color peach: "#fab387"
    readonly property color yellow: "#f9e2af"
}
