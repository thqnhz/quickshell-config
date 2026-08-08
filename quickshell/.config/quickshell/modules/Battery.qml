import QtQuick
import Quickshell.Services.UPower
import "../common"

ZRow {
    id: battery
    spacing: 8
    property int percent: Math.round((UPower.displayDevice.percentage ?? 0) * 100)
    visible: UPower.displayDevice.isLaptopBattery

    ZText {
        visible: battery.percent < 100
        text: battery.percent
    }

    ZText {
        text: {
            let level = Math.floor(battery.percent / 10) * 10;
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
            return map[level] || "󰂃";
        }
    }

    Splitter {}
}
