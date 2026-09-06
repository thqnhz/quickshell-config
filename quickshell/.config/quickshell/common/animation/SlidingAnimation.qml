import QtQuick
import qs.config

NumberAnimation {
    duration: Config.slidingAnimationDuration
    easing.type: Easing.OutCubic
}
