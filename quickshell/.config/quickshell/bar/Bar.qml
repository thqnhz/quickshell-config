import QtQuick
import Quickshell
import qs.config

LazyLoader {
    loading: true

    PanelWindow {
        id: bar
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: Config.barHeight
        color: "transparent"

        Item {
            id: content
            anchors.fill: parent

            property real slideY: -Config.barHeight
            opacity: 0

            transform: Translate {
                y: content.slideY
            }
            Behavior on slideY {
                NumberAnimation {
                    duration: Config.barAppearAnimationDuration
                    easing.type: Easing.OutCubic
                }
            }
            Component.onCompleted: {
                slideY = 0;
                opacity = 1;
            }

            Rectangle {
                anchors.fill: parent
                color: Config.crust
            }

            BarLeft {}
            BarCenter {}
            BarRight {}
        }
    }
}
