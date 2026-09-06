pragma Singleton
import QtQuick
import Quickshell

Singleton {
    readonly property string hour: Qt.formatDateTime(clock.date, "hh")
    readonly property string minute: Qt.formatDateTime(clock.date, "mm")
    readonly property string fullDate: Qt.formatDateTime(clock.date, "ddd dd/MM/yyyy")  // No American MM/DD/YYYY sorry

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
