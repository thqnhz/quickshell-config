import QtQuick
import Quickshell.Services.UPower
import "../common"

ZRow {
    spacing: 8
    ZText {
        visible: UPower.displayDevice.isLaptopBattery
        text: {
            let percent = Math.round((UPower.displayDevice.percentage ?? 0) * 100);
            let level = Math.floor(percent / 10) * 10;
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
        visible: UPower.displayDevice.isLaptopBattery
    }
}
