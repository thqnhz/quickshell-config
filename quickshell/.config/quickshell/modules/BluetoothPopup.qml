import QtQuick
import Quickshell
import Quickshell.Bluetooth
import qs.config
import qs.common

PopupWindow {
    id: popup
    required property Item anchorItem

    implicitWidth: Config.bluetoothPopupWidth
    implicitHeight: contentColumn.implicitHeight + Config.rowSpacing * 2
    color: "transparent"
    grabFocus: true

    anchor {
        item: popup.anchorItem
        rect.y: popup.anchorItem.height + Config.rowSpacing / 2
        rect.x: -Config.rowSpacing / 2
    }

    Rectangle {
        id: fill
        anchors.fill: parent
        color: Config.mantle
        border.width: 1
        border.color: Config.overlay2

        Column {
            id: contentColumn
            anchors.centerIn: parent
            width: parent.width - Config.rowSpacing * 2
            spacing: Config.rowSpacing

            ClickableText {
                acceptedButtons: Qt.LeftButton
                onClickedAction: function (event) {
                    BluetoothControl.toggleAdapter();
                }
                anchors.horizontalCenter: parent.horizontalCenter
                text: (BluetoothControl.adapterEnabled ? "󰂯" : "󰂲") + " Bluetooth"
                color: BluetoothControl.adapterEnabled ? Config.sapphire : Config.red
            }

            Rectangle {
                width: parent.width
                height: 1
                color: Config.overlay2
            }

            Repeater {
                model: BluetoothControl.hasAdapter ? Bluetooth.defaultAdapter.devices : []

                delegate: ClickableText {
                    required property var modelData

                    text: (modelData.connected ? "󰂱 " : "󰂲 ") + modelData.name
                    color: modelData.connected ? Config.sapphire : Config.overlay0
                    horizontalAlignment: Text.AlignHCenter

                    acceptedButtons: Qt.LeftButton
                    onClickedAction: function (event) {
                        modelData.connected = !modelData.connected;
                    }
                }
            }

            ZText {
                visible: BluetoothControl.hasAdapter && Bluetooth.defaultAdapter.devices.count === 0
                text: "No paired devices"
                color: Config.overlay0
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
