import QtQuick

/* The animated scene behind the weather that is now. The parts and the colours come from
   KWeather (see README.md); the scene is chosen from the category of the widget and from
   day or night, thus no new data format is needed. */
Rectangle {
    id: scene

    property string cat: "cloudy"
    property bool isDay: true
    /* False stops all movement, for example while the tray popup is closed. */
    property bool running: true

    readonly property var s: sceneOf(cat, isDay)

    /* { top, bottom, sun, stars, clouds (a colour), rain ({ drops, speed }), snow } */
    function sceneOf(cat, day) {
        var nightTop = "#455a64", nightBottom = "#263238";
        var rain = { drops: 80, speed: 1.0 };
        var drizzle = { drops: 20, speed: 0.5 };
        switch (cat) {
        case "clear":
        case "mostlyclear":
            return day ? { top: "#2196f3", bottom: "#ffc107", sun: true }
                       : { top: nightTop, bottom: nightBottom, stars: true };
        case "partly":
        case "mostlycloudy":
            return day ? { top: "#00bcd4", bottom: "#24a3de", sun: true, clouds: "#e0f7fa" }
                       : { top: nightTop, bottom: nightBottom, stars: true, clouds: "#b0bec5" };
        case "cloudy":
        case "overcast":
            return day ? { top: "#00bcd4", bottom: "#24a3de", clouds: "#e0f7fa" }
                       : { top: nightTop, bottom: nightBottom, clouds: "#b0bec5" };
        case "fog":
            return { top: "#c2c5cb", bottom: "#5b606b", clouds: "#dae0ec" };
        case "snow":
            return day ? { top: "#35d9ed", bottom: "#24a3de", snow: true }
                       : { top: nightTop, bottom: nightBottom, snow: true };
        case "drizzle":
            return day ? { top: "#369ccb", bottom: "#1A83B3", clouds: "white", rain: drizzle }
                       : { top: nightTop, bottom: nightBottom, clouds: "#b0bec5", rain: drizzle };
        default:
            /* showers, rain, heavyrain, sleet, freezing, thunder */
            return day ? { top: "#369ccb", bottom: "#1A83B3", clouds: "white", rain: rain }
                       : { top: nightTop, bottom: nightBottom, clouds: "#b0bec5", rain: rain };
        }
    }

    clip: true
    gradient: Gradient {
        GradientStop { position: 0.0; color: scene.s.top }
        GradientStop { position: 1.0; color: scene.s.bottom }
    }

    /* A part that the scene does not have is not made at all. */
    Loader {
        anchors.fill: parent
        active: scene.s.sun === true
        sourceComponent: Sun { running: scene.running }
    }
    Loader {
        anchors.fill: parent
        active: scene.s.stars === true
        sourceComponent: Stars { running: scene.running }
    }
    Loader {
        anchors.fill: parent
        active: scene.s.clouds !== undefined
        sourceComponent: Cloudy { running: scene.running; cloudColor: scene.s.clouds }
    }
    Loader {
        anchors.fill: parent
        active: scene.s.rain !== undefined
        sourceComponent: Rain {
            running: scene.running
            drops: scene.s.rain.drops
            speed: scene.s.rain.speed
        }
    }
    Loader {
        anchors.fill: parent
        active: scene.s.snow === true
        sourceComponent: Snow { running: scene.running }
    }
}
