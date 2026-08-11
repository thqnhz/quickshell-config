pragma Singleton
import QtQuick
import Quickshell

Singleton {
    readonly property string hour: Qt.formatDateTime(clock.date, "hh")
    readonly property string minute: Qt.formatDateTime(clock.date, "mm")
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
