import QtQuick
import qs.common

ZRow {
    ClickableText {
        id: powerText
        acceptedButtons: Qt.LeftButton
        onClickedAction: function (event) {
            powerPopup.visible = !powerPopup.visible;
        }
        text: "󰐥"
    }

    PowerPopup {
        id: powerPopup
        anchorItem: powerText
    }
}
