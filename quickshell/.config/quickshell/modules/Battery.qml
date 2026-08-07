import QtQuick
import Quickshell.Services.UPower
import "../common"

ZRow {
    spacing: 8
    property var percent: null

    ZText {
        visible: UPower.displayDevice.isLaptopBattery && parent.percent < 100
        text: parent.percent
    }

    ZText {
        visible: UPower.displayDevice.isLaptopBattery
        text: {
            parent.percent = Math.round((UPower.displayDevice.percentage ?? 0) * 100);
            let level = Math.floor(parent.percent / 10) * 10;
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
