import QtQuick
import Quickshell.Services.UPower
import "../common"

ZRow {
    id: battery
    spacing: 8
    property int percent: Math.round((UPower.displayDevice.percentage ?? 0) * 100)
    property bool isLaptopBattery: UPower.displayDevice.isLaptopBattery

    ZText {
        visible: battery.isLaptopBattery && battery.percent < 100
        text: battery.percent
    }

    ZText {
        visible: battery.isLaptopBattery
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

    Splitter {
        visible: battery.isLaptopBattery
    }
}
