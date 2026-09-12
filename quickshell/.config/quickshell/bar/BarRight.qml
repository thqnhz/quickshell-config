import QtQuick
import qs.common
import qs.modules

ZRow {
    anchors.right: parent.right
    anchors.rightMargin: 8
    spacing: 8

    Tray {}

    Weather {}

    Cpu {}

    Memory {}

    Volume {}

    Bluetooth {}

    Battery {}

    Network {}

    Power {}
}
