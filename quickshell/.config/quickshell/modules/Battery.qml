import QtQuick
import Quickshell.Services.UPower
import qs.config
import "../common"

ZRow {
    id: battery
    property int percent: Math.round((UPower.displayDevice.percentage ?? 0) * 100)
    property int level: Math.floor(battery.percent / 10) * 10
    visible: UPower.displayDevice.isLaptopBattery

    function toIcon() {
        let map = {
            10: "󰁺",
            20: "󰁻",
            30: "󰁼",
            40: "󰁽",
            50: "󰁾",
            60: "󰁿",
            70: "󰂀",
            80: "󰂁",
            90: "󰂂",
            100: "󰁹"
        };
        return map[battery.level] || "󰂃";
    }

    ZText {
        visible: Config.hidePercentageWhenFull && battery.percent < 100
        text: battery.percent
    }

    ZText {
        text: battery.toIcon()
        color: battery.percent <= Config.batteryThreshold ? Config.red : Config.text
    }

    Splitter {}
}
