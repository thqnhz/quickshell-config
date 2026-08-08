import QtQuick
import Quickshell.Io
import "../common"

ZRow {
    id: weather

    property string temp: "--"
    property string icon: "󰖐"

    Component.onCompleted: fetchWeather()

    function fetchWeather() {
        fetcher.running = true;
    }

    function toNerdfont(wCode) {
        if (wCode === 113)
            return "󰖙"; // Sunny
        if (wCode === 116)
            return "󰖕"; // Partly Cloudy
        if (wCode === 119 || wCode === 122)
            return "󰖐"; // Cloudy
        if (wCode === 143 || wCode === 248 || wCode === 260)
            return "󰖑"; // Fog
        if (wCode >= 176 && wCode <= 185)
            return "󰖗"; // Rain Patches
        if (wCode === 200 || wCode === 386 || wCode === 389 || wCode === 392)
            return "󰖓"; // Thunderstorm
        if (wCode >= 263 && wCode <= 377)
            return "󰖖"; // Rain
        if (wCode >= 227 && wCode <= 395)
            return ""; // Snow
        return "󰖐"; // Default to cloud
    }

    Process {
        id: fetcher
        command: ["bash", "-c", "curl -s 'wttr.in?format=j2' | jq '.current_condition[0] | {temp: .temp_C, wCode: .weatherCode}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                if (text.length === 0)
                    return;
                try {
                    const data = JSON.parse(text);
                    weather.temp = data.temp;
                    weather.icon = weather.toNerdfont(parseInt(data.wCode) || 113);
                } catch (e) {
                    console.error("[Weather]", e.message);
                }
            }
        }
    }

    Timer {
        running: true
        repeat: true
        interval: 600000
        triggeredOnStart: true
        onTriggered: weather.fetchWeather()
    }

    ZText {
        text: weather.temp + " " + weather.icon
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            onClicked: event => {
                if (event.button === Qt.RightButton)
                    weather.fetchWeather();
            }
        }
    }

    Splitter {}
}
