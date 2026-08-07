import QtQuick
import "../common"
import "../modules"

ZRow {
    anchors.right: parent.right
    anchors.rightMargin: 8
    spacing: 8

    Bluetooth {}

    Battery {}

    Network {}
}
