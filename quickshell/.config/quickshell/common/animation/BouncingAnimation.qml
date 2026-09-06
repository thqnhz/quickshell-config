import QtQuick
import qs.config

NumberAnimation {
    duration: Config.numberAnimationDuration
    easing.type: Easing.OutBack
}
