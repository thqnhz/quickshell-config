import QtQuick
import Quickshell
import Quickshell.Io
import "../common"

ZRow {
    id: weather
    spacing: 8

    property string temp: "--"
    property int wCode: 113

    Component.onCompleted: fetchWeather()

    function fetchWeather() {
        fetcher.running = true;
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
                    weather.wCode = parseInt(data.wCode) || 113;
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
        text: weather.temp
    }

    ZText {
        text: {
            if (weather.wCode === 113)
                return "󰖙"; // Sunny
            if (weather.wCode === 116)
                return "󰖕"; // Partly Cloudy
            if (weather.wCode === 119 || weather.wCode === 122)
                return "󰖐"; // Cloudy
            if (weather.wCode === 143 || weather.wCode === 248 || weather.wCode === 260)
                return "󰖑"; // Fog
            if (weather.wCode >= 176 && weather.wCode <= 185)
                return "󰖗"; // Rain Patches
            if (weather.wCode === 200 || weather.wCode === 386 || weather.wCode === 389 || weather.wCode === 392)
                return "󰖓"; // Thunderstorm
            if (weather.wCode >= 227 && weather.wCode <= 395)
                return ""; // Snow
            if (weather.wCode >= 263 && weather.wCode <= 377)
                return "󰖖"; // Rain
            return "󰖐"; // Default to cloud
        }
    }

    Splitter {}
}
