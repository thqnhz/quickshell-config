import QtQuick
import Quickshell
import qs.common
import qs.config

ZRow {
    ClickableText {
        id: btIcon
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClickedAction: function (event) {
            if (event.button === Qt.LeftButton)
                btPopup.visible = !btPopup.visible;
            else if (event.button === Qt.RightButton)
                Quickshell.execDetached(Config.bluetoothSettings);
        }
        text: BluetoothControl.icon()
    }

    BluetoothPopup {
        id: btPopup
        anchorItem: btIcon
    }

    Splitter {}
}
