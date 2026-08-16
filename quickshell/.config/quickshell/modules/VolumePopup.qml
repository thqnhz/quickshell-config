import QtQuick
import Quickshell
import qs.config
import qs.common

PopupWindow {
    id: popup
    required property Item anchorItem

    implicitWidth: Config.volumePopupWidth
    implicitHeight: Config.volumePopupHeight
    color: "transparent"
    grabFocus: true

    anchor {
        item: popup.anchorItem
        rect.y: popup.anchorItem.height + Config.rowSpacing / 2
        rect.x: -Config.rowSpacing / 2 // Just to nudge it a bit so it center
    }

    Rectangle {
        anchors.fill: parent
        color: Config.mantle
        border.width: 1
        border.color: Config.overlay2

        Column {
            anchors.centerIn: parent
            spacing: Config.rowSpacing

            ClickableText {
                acceptedButtons: Qt.LeftButton
                onClickedAction: function (event) {
                    VolumeControl.toggleMute();
                }
                anchors.horizontalCenter: parent.horizontalCenter
                text: VolumeControl.icon()
                color: VolumeControl.muted ? Config.red : Config.sapphire
                font.pixelSize: Config.fontSizePopup
            }

            Rectangle {
                id: track
                width: Config.volumePopupLevelWidth
                height: Config.volumePopupLevelHeight
                color: Config.overlay0
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: fill
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    implicitWidth: parent.width
                    implicitHeight: parent.height * Math.min(1, VolumeControl.volume / 1.5)
                    color: Config.sapphire
                }

                MouseArea {
                    anchors.fill: parent

                    function setFromMouse(mouse) {
                        const t = Math.max(0, Math.min(1, 1 - mouse.y / height));
                        VolumeControl.setVolume(t * 1.5);
                    }
                    onPressed: mouse => setFromMouse(mouse)
                    onPositionChanged: mouse => {
                        if (pressed)
                            setFromMouse(mouse);
                    }
                    onWheel: event => {
                        const step = Config.volumeScrollStep;
                        const delta = event.angleDelta.y > 0 ? step : -step;
                        VolumeControl.step(Config.reverseScrolling ? delta : -delta);
                    }
                }
            }

            ZText {
                anchors.horizontalCenter: parent.horizontalCenter
                text: VolumeControl.volPct + "%"
            }
        }
    }
}
