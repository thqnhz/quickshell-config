import QtQuick
import "../common"
import "../modules"

ZRow {
    anchors.right: parent.right
    anchors.rightMargin: 8
    spacing: 8

    Tray {}

    Weather {}

    Cpu {}

    Memory {}

    Bluetooth {}

    Battery {}

    Network {}
}
