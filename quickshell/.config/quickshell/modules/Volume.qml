import QtQuick
import qs.config
import qs.common

ZRow {
    visible: VolumeControl.ready

    ClickableText {
        id: volText
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClickedAction: function (event) {
            if (event.button === Qt.LeftButton)
                volumePopup.visible = !volumePopup.visible;
            else if (event.button === Qt.RightButton)
                VolumeControl.toggleMute();
        }
        onWheelAction: function (event) {
            const step = Config.volumeScrollStep;
            const delta = event.angleDelta.y > 0 ? step : -step;
            VolumeControl.step(Config.reverseScrolling ? delta : -delta);
        }
        text: VolumeControl.displayText()
        color: VolumeControl.color()

        Behavior on color {
            ColorAnimation {
                duration: Config.colorAnimationDuration
            }
        }
    }

    VolumePopup {
        id: volumePopup
        anchorItem: volText
    }

    Splitter {}
}
