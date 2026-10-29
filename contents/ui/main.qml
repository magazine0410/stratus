import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PC3
import org.kde.kirigami as Kirigami
import "weather.js" as Weather
import "backgrounds" as Bg

PlasmoidItem {
    id: root

    readonly property int mode24h: 0
    readonly property int mode3d: 1
    readonly property int mode7d: 2

    readonly property string source: Plasmoid.configuration.weatherSource
    readonly property bool sevenDayOk: source !== "fmi"
    readonly property int viewMode: Plasmoid.configuration.viewMode
    readonly property int effMode: (!sevenDayOk && viewMode === mode7d) ? mode3d : viewMode
    readonly property double lat: Plasmoid.configuration.locationLatitude
    readonly property double lon: Plasmoid.configuration.locationLongitude
    readonly property string locName: Plasmoid.configuration.locationName
    readonly property string locCountry: Plasmoid.configuration.locationCountry
    /* Some places have no country (for example on Svalbard), thus the comma is conditional. */
    readonly property string locText: locCountry !== "" ? locName + ", " + locCountry : locName
    readonly property bool showRainProbability: Plasmoid.configuration.showRainProbability
    readonly property bool showWind: Plasmoid.configuration.showWind
    /* "static", "hover" or "always". It changes no data, thus it is not in settingsKey. */
    readonly property string iconAnimation: Plasmoid.configuration.iconAnimation
    /* "theme" or "dark". A dark background gives more contrast to the rain drops. */
    readonly property bool darkBackground: Plasmoid.configuration.backgroundStyle === "dark"
    readonly property bool autoScrollHour: Plasmoid.configuration.autoScrollHour

    /* True when the applet is in the system tray. Plasma 6 gives no direct property; this is
       the test that the other tray weather applets use (CustomEmbedded = 129, Horizontal = 2).
       The tray shows the full representation in its popup only when preferredRepresentation
       is not set, thus that property depends on this. */
    readonly property bool inTray: Plasmoid.containment
        ? (Plasmoid.containment.containmentType === 129 && Plasmoid.formFactor === 2)
        : false

    /* The hour that is now. The clock timer keeps it correct, thus the highlight moves and the
       hourly view can follow. */
    property int nowHour: new Date().getHours()
    property string nowDate: Weather.todayKey()

    /* "Today", "Tomorrow" or "Mon 17.8.", for the header of the hourly view. */
    readonly property string hourlyDayLabel: {
        var d = Weather.dateFromKey(hourlyDate);
        var diff = Math.round((d.getTime() - Weather.dateFromKey(Weather.todayKey()).getTime())
                              / 86400000);
        if (diff === 0) return "Today";
        if (diff === 1) return "Tomorrow";
        return Weather.dayLabel(diff, d, false) + " " + Weather.dateLabel(d);
    }

    /* The weather that is now: { temp, cat, wind, windDeg, isDay }, or null before the first
       reply. Open-Meteo gives it for every source, like the base of the hourly view. */
    property var current: null

    property var rows: []
    property bool loading: false
    property string errorMsg: ""
    property string updatedText: ""
    property string sourceLabel: ""

    /* The view mode that "rows" belongs to. The layout and the sizes use this, not effMode.
       Thus the old data never gets the layout of the new view for a moment. */
    property int displayMode: -1

    /* The day of the hourly view, as "YYYY-MM-DD". A click on a day in the 3-day or 7-day view
       puts that date here. The 24 h button puts today here. */
    property string hourlyDate: Weather.todayKey()
    readonly property bool hourlyIsToday: hourlyDate === Weather.todayKey()

    /* All hours of all days: date key -> array of 24 rows. Open-Meteo gives every day in one
       reply, thus a click on another day usually needs no new request. */
    property var hourly: ({})

    /* Data of each view, thus a change of view is immediate. The keys are texts:
       "mode:1" for a day view, "hours" for the hourly data.
       clearCache() removes the data when the source, the location or the details change. */
    property var cache: ({})
    readonly property int cacheMaxAgeMs: 10 * 60 * 1000

    /* The keys that have a request on the way, thus one key never gets two requests. */
    property var pending: ({})

    /* Goes up at each change of the settings. A reply with an old number is thrown away,
       thus data of the previous location or source can not come on the screen too late. */
    property int generation: 0

    /* All settings that make the held data wrong, as one text. The configuration values come in
       one by one when the applet starts, thus a comparison with fetchedKey prevents a second
       fetch when the values did not really change. */
    readonly property string settingsKey: source + "|" + lat + "," + lon
        + "|" + showRainProbability + "|" + showWind
    property string fetchedKey: ""

    function clearCache() {
        cache = ({});
        pending = ({});
        generation++;
    }

    /* The cache key of a view mode. The hourly view holds all days under one key. */
    function keyOf(mode) {
        return mode === mode24h ? "hours" : "mode:" + mode;
    }

    /* Shows a view. It uses the data that is already there, and gets new data only when
       there is none or when it is old. */
    function showMode(mode) {
        var key = keyOf(mode);
        var c = cache[key];
        if (c) {
            if (mode === mode24h) {
                hourly = c.hourly;
                rows = hoursOf(hourlyDate);
            } else {
                rows = c.rows;
            }
            sourceLabel = c.label;
            updatedText = c.updated;
            displayMode = mode;
            errorMsg = "";
            loading = false;
            if (Date.now() - c.ms > cacheMaxAgeMs) {
                fetchMode(mode, true);
            }
        } else {
            fetchMode(mode, false);
        }
    }

    /* The 24 rows of one day. An unknown day gives an empty list. */
    function hoursOf(key) {
        return hourly[key] ? hourly[key] : [];
    }

    /* A click on a day in the 3-day or 7-day view. */
    function showHourlyDay(key) {
        hourlyDate = key;
        Plasmoid.configuration.viewMode = mode24h;
    }

    function refresh() {
        clearCache();
        fetchMode(effMode, false);
        fetchCurrent();
    }

    /* The weather that is now. It has no view, thus no cache: refresh() and the autoRefresh
       timer get it again together with the forecast. A failure keeps the old values. */
    function fetchCurrent() {
        if (pending["current"]) return;
        pending["current"] = true;
        var url = "https://api.open-meteo.com/v1/forecast?latitude=" + lat + "&longitude=" + lon
            + "&current=temperature_2m,weather_code,wind_speed_10m,wind_direction_10m,is_day"
            + "&timezone=auto&wind_speed_unit=ms";
        getUrl("current", generation, url, function(text) {
            pending["current"] = false;
            try {
                current = Weather.omCurrent(text);
            } catch (e) {
                /* The forecast is still complete; the block keeps the old values. */
            }
        }, function(msg) {
            pending["current"] = false;
        });
    }

    /* background = true keeps the old data on the screen while the new data comes. */
    function fetchMode(mode, background) {
        var key = keyOf(mode);
        if (pending[key]) return;
        pending[key] = true;
        fetchedKey = settingsKey;
        errorMsg = "";
        loading = !background;
        var g = generation;
        var opts = { rainProb: showRainProbability, wind: showWind, wide: mode !== mode7d };
        if (mode === mode24h) {
            fetchHourly(g, opts);
            return;
        }
        var useFmi = source === "fmi" || (source === "both" && mode !== mode7d);
        if (useFmi) {
            fetchFmi(mode, g, opts);
        } else {
            fetchOpenMeteo(mode, g, opts);
        }
    }

    /* The hourly view. Open-Meteo is always the base, because it gives every hour of all 7 days,
       also the hours of today that are already past. When FMI is selected, its hours are put on
       top of that, because FMI is the local model. FMI has no hours before the hour that is now
       and no days after about two days; those rows stay Open-Meteo. */
    function fetchHourly(g, opts) {
        var withFmi = source !== "openmeteo";
        var base = null;
        var over = null;
        var waiting = withFmi ? 2 : 1;

        function done() {
            waiting--;
            if (waiting > 0) return;
            if (!base) { fail("hours", "No forecast data received"); return; }
            var merged = over ? Weather.mergeHourly(base, over) : base;
            var label = over ? "FMI + Open-Meteo" : "Open-Meteo";
            finishHourly(merged, label);
        }

        var omUrl = "https://api.open-meteo.com/v1/forecast?latitude=" + lat + "&longitude=" + lon
            + "&hourly=temperature_2m,weather_code,precipitation_probability,wind_speed_10m"
            + "&forecast_days=7&timezone=auto&wind_speed_unit=ms";
        getUrl("hours", g, omUrl, function(text) {
            try {
                base = Weather.omHourly(text, opts);
            } catch (e) {
                base = null;
            }
            done();
        }, done);

        if (!withFmi) return;

        var fmiUrl = "https://opendata.fmi.fi/wfs?request=getFeature&storedquery_id="
            + "fmi::forecast::harmonie::surface::point::simple"
            + "&timestep=60&parameters=Temperature,WeatherSymbol3,WindSpeedMS"
            + "&latlon=" + lat + "," + lon;
        getUrl("hours", g, fmiUrl, function(text) {
            try {
                over = Weather.fmiHourly(Weather.parseFmiXml(text), opts);
            } catch (e) {
                over = null;   /* Open-Meteo alone is still a complete forecast. */
            }
            done();
        }, done);
    }

    function finishHourly(map, label) {
        pending["hours"] = false;
        var upd = new Date().toLocaleTimeString(Qt.locale(), "HH:mm");
        cache["hours"] = { hourly: map, label: label, updated: upd, ms: Date.now() };
        if (effMode !== mode24h) return;
        hourly = map;
        rows = hoursOf(hourlyDate);
        sourceLabel = label;
        updatedText = upd;
        displayMode = mode24h;
        loading = false;
        errorMsg = "";
    }

    /* onOk gets the reply text, onErr gets a message. Neither touches "pending": the caller
       decides when its work is complete, because the hourly view uses two requests. */
    function getUrl(key, g, url, onOk, onErr) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState !== XMLHttpRequest.DONE) return;
            if (g !== root.generation) return;   /* The settings changed; the reply is old. */
            if (xhr.status === 200) {
                onOk(xhr.responseText);
            } else {
                onErr("Data fetch failed (HTTP " + xhr.status + ")");
            }
        };
        xhr.open("GET", url);
        xhr.send();
    }

    /* A reply of a view that the user left is only put in the cache, not on the screen.
       A failed refresh in the background keeps the old data; only the update time gets old. */
    function fail(key, msg) {
        pending[key] = false;
        if (key !== keyOf(effMode)) return;
        loading = false;
        if (!cache[key]) errorMsg = msg;
    }

    function finish(mode, newRows, label) {
        var key = keyOf(mode);
        pending[key] = false;
        if (!newRows || newRows.length === 0) {
            fail(key, "No forecast data received");
            return;
        }
        var upd = new Date().toLocaleTimeString(Qt.locale(), "HH:mm");
        cache[key] = { rows: newRows, label: label, updated: upd, ms: Date.now() };
        if (mode !== effMode) return;
        rows = newRows;
        sourceLabel = label;
        updatedText = upd;
        displayMode = mode;
        loading = false;
        errorMsg = "";
    }

    function fetchOpenMeteo(mode, g, opts) {
        var url = "https://api.open-meteo.com/v1/forecast?latitude=" + lat + "&longitude=" + lon
            + "&daily=weather_code,temperature_2m_max,temperature_2m_min"
            + ",precipitation_probability_max,wind_speed_10m_max&forecast_days="
            + (mode === mode3d ? 3 : 7) + "&timezone=auto&wind_speed_unit=ms";
        getUrl(keyOf(mode), g, url, function(text) {
            try {
                finish(mode, Weather.omDaily(text, opts, opts.wide), "Open-Meteo");
            } catch (e) {
                fail(keyOf(mode), "Data parse failed: " + e);
            }
        }, function(msg) {
            fail(keyOf(mode), msg);
        });
    }

    function fetchFmi(mode, g, opts) {
        var url = "https://opendata.fmi.fi/wfs?request=getFeature&storedquery_id="
            + "fmi::forecast::edited::weather::scandinavia::point::simple"
            + "&parameters=Temperature,WeatherSymbol3,WindSpeedMS"
            + "&latlon=" + lat + "," + lon;
        getUrl(keyOf(mode), g, url, function(text) {
            try {
                var entries = Weather.parseFmiXml(text);
                finish(mode, Weather.fmiDaily(entries, mode === mode3d ? 3 : 7, opts, opts.wide), "FMI");
            } catch (e) {
                fail(keyOf(mode), "Data parse failed: " + e);
            }
        }, function(msg) {
            fail(keyOf(mode), msg);
        });
    }

    preferredRepresentation: inTray ? null : fullRepresentation

    /* The icon in the panel or the tray, and its tool tip, follow the weather that is now. */
    Plasmoid.icon: current ? Weather.themeIcon(current.cat, current.isDay) : "weather-clear"
    toolTipMainText: locText
    toolTipSubText: current
        ? current.temp + "  ·  " + Weather.vis(current.cat).name
            + (current.wind !== "" ? "  ·  " + current.wind : "")
        : ""

    fullRepresentation: Item {
        id: widget

        readonly property real s: Math.max(0.45, Math.min(3.0, Math.min(width / 380, height / 250)))
        /* The 7-day view has 7 columns, so it uses somewhat smaller elements.
           This follows displayMode, thus the data and its sizes always change together. */
        readonly property real d: (root.displayMode === root.mode7d) ? 0.8 : 1.0
        readonly property var modeModel: [
            { label: "24 h", value: root.mode24h },
            { label: "3 days", value: root.mode3d },
            { label: "7 days", value: root.mode7d }
        ]

        Layout.preferredWidth: 420
        Layout.preferredHeight: 380
        Layout.minimumWidth: 240
        Layout.minimumHeight: 220
        Layout.fillWidth: true
        Layout.fillHeight: true

        implicitWidth: 420
        implicitHeight: 380

        /* Own background. The Plasmoid type gives no background property to QML, thus this
           rectangle is drawn on top of the background of the Plasma theme. It is first in the
           file, thus it stays behind the contents. */
        Rectangle {
            anchors.fill: parent
            visible: root.darkBackground
            color: "#0B0B0D"
            radius: Kirigami.Units.cornerRadius
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 8 * widget.s
            spacing: 4 * widget.s

            /* The weather that is now, on an animated scene (see backgrounds/README.md). */
            Item {
                id: hero
                Layout.fillWidth: true
                Layout.preferredHeight: 96 * widget.s

                readonly property var cur: root.current
                readonly property real pad: 10 * widget.s

                Bg.Scene {
                    anchors.fill: parent
                    radius: 6 * widget.s
                    cat: hero.cur ? hero.cur.cat : "cloudy"
                    isDay: hero.cur ? hero.cur.isDay : true
                    /* The scene moves only while it can be seen: in the tray, that is while
                       the popup is open. "static" stops it, as it stops the symbols. */
                    running: root.iconAnimation !== "static" && (!root.inTray || root.expanded)
                }

                /* A light scrim keeps the white text readable on the yellow and the mist. */
                Rectangle {
                    anchors.fill: parent
                    radius: 6 * widget.s
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#30000000" }
                        GradientStop { position: 1.0; color: "#70000000" }
                    }
                }

                Text {
                    /* In the hourly view of another day, the day is named here. */
                    text: (root.displayMode === root.mode24h && !root.hourlyIsToday)
                        ? root.locText + "  ·  " + root.hourlyDayLabel
                        : root.locText
                    color: "white"
                    font.pixelSize: 15 * widget.s
                    font.bold: true
                    style: Text.Outline
                    styleColor: "#40000000"
                    elide: Text.ElideRight
                    anchors.left: parent.left
                    anchors.right: windBox.left
                    anchors.top: parent.top
                    anchors.margins: hero.pad
                    anchors.topMargin: 7 * widget.s
                }

                Text {
                    text: hero.cur ? hero.cur.temp : "—"
                    color: "white"
                    font.pixelSize: 32 * widget.s
                    font.bold: true
                    style: Text.Outline
                    styleColor: "#40000000"
                    anchors.left: parent.left
                    anchors.leftMargin: hero.pad
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 4 * widget.s
                }

                Text {
                    text: {
                        var t = root.sourceLabel;
                        if (root.updatedText !== "") t += "  ·  updated " + root.updatedText;
                        if (!root.sevenDayOk && root.viewMode === root.mode7d)
                            t += "  ·  7 days not available from FMI";
                        return t;
                    }
                    color: "#d0ffffff"
                    font.pixelSize: 10 * widget.s
                    elide: Text.ElideRight
                    anchors.left: parent.left
                    anchors.right: windBox.left
                    anchors.bottom: parent.bottom
                    anchors.margins: hero.pad
                    anchors.bottomMargin: 6 * widget.s
                    visible: text !== ""
                }

                /* The wind: an arrow that points where the wind goes, and the speed. */
                Column {
                    id: windBox
                    anchors.right: parent.right
                    anchors.rightMargin: hero.pad
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 0
                    visible: root.showWind && hero.cur !== null && hero.cur.wind !== ""
                    width: visible ? implicitWidth : 0

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "➤"
                        /* Open-Meteo gives where the wind comes from. */
                        rotation: hero.cur ? hero.cur.windDeg + 90 : 0
                        color: "white"
                        font.pixelSize: 22 * widget.s
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: hero.cur ? hero.cur.wind : ""
                        color: "white"
                        font.pixelSize: 12 * widget.s
                        style: Text.Outline
                        styleColor: "#40000000"
                    }
                }
            }

            /* The three views as tabs. The current tab follows effMode, also after a click
               changed it: the Binding puts the value back whenever effMode changes, while a
               plain binding would be broken by the click. */
            PC3.TabBar {
                id: tabBar
                Layout.fillWidth: true

                Binding {
                    target: tabBar
                    property: "currentIndex"
                    value: root.effMode
                }

                Repeater {
                    model: widget.modeModel

                    delegate: PC3.TabButton {
                        readonly property bool isCurrent: root.effMode === modelData.value
                        text: modelData.label
                        font.pixelSize: 12.5 * widget.s
                        font.bold: isCurrent
                        enabled: modelData.value !== root.mode7d || root.sevenDayOk
                        onClicked: {
                            /* The 24 h tab always goes back to today, also when the hourly
                               view already shows another day. */
                            if (modelData.value === root.mode24h) {
                                root.hourlyDate = Weather.todayKey();
                            }
                            if (!isCurrent) {
                                Plasmoid.configuration.viewMode = modelData.value;
                            }
                        }

                        PC3.ToolTip.visible: !enabled
                        PC3.ToolTip.text: "FMI does not give 7-day forecasts"
                        PC3.ToolTip.delay: 300
                    }
                }
            }

            Item {
                id: forecastArea
                Layout.fillWidth: true
                Layout.fillHeight: true

                readonly property bool stacked: root.displayMode === root.mode24h

                /* Hourly view: one row for each hour, 00:00 at the top to 23:00 at the bottom.
                   The list is longer than the widget, thus it scrolls. The ListView makes only
                   the rows that are visible, thus 24 animated symbols cost nothing. */
                PC3.ScrollView {
                    id: hourScroll
                    anchors.fill: parent
                    visible: forecastArea.stacked
                    contentWidth: availableWidth

                    readonly property real rowHeight: Math.max(34 * widget.s, forecastArea.height / 5)

                    ListView {
                        id: hourList
                        model: hourScroll.visible ? root.rows : []
                        clip: true
                        spacing: 2 * widget.s
                        boundsBehavior: Flickable.StopAtBounds

                        /* The hour that is now, in the day that is shown. -1 in another day. */
                        readonly property int nowIndex: (root.displayMode === root.mode24h
                            && root.hourlyIsToday) ? root.nowHour : -1

                        /* The hour that the view was last put at. -1 means the view is new or
                           shows another day; the next hour then goes to the top, and not only
                           into view. This separates "the view opens" from "the clock moved". */
                        property int lastNow: -1

                        function goToNow(mode) {
                            if (nowIndex >= 0 && count > nowIndex) positionViewAtIndex(nowIndex, mode);
                        }

                        function openAtNow() {
                            if (nowIndex < 0) { positionViewAtBeginning(); lastNow = -1; return; }
                            goToNow(ListView.Beginning);
                            lastNow = nowIndex;
                        }

                        /* The view opens at the hour that is now. */
                        onCountChanged: openAtNow()

                        /* Another day has the same number of rows, thus onCountChanged does not
                           come. Today opens at the hour that is now, another day at 00:00. */
                        Connections {
                            target: root
                            function onHourlyDateChanged() {
                                hourList.openAtNow();
                            }
                        }
                        onNowIndexChanged: {
                            if (nowIndex < 0) { lastNow = -1; return; }
                            if (lastNow < 0) {
                                openAtNow();          /* The view is opening. */
                            } else if (root.autoScrollHour) {
                                /* The clock reached the next hour. The row comes into view, but
                                   only if it is not visible already: Contain does nothing then. */
                                goToNow(ListView.Contain);
                                lastNow = nowIndex;
                            } else {
                                lastNow = nowIndex;
                            }
                        }

                        delegate: Rectangle {
                            id: hourRow
                            width: hourList.width
                            height: hourScroll.rowHeight
                            radius: 4 * widget.s

                            readonly property var v: Weather.vis(modelData.cat)
                            readonly property bool isNow: modelData.hour === hourList.nowIndex

                            /* Soft highlight of the hour that is now. */
                            color: isNow ? Qt.rgba(Kirigami.Theme.highlightColor.r,
                                                   Kirigami.Theme.highlightColor.g,
                                                   Kirigami.Theme.highlightColor.b, 0.22)
                                         : "transparent"

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 8 * widget.s
                                anchors.rightMargin: 8 * widget.s
                                spacing: 10 * widget.s

                                Text {
                                    text: modelData.top
                                    color: Kirigami.Theme.textColor
                                    font.pixelSize: 17 * widget.s
                                    font.bold: true
                                    Layout.preferredWidth: 58 * widget.s
                                }

                                WeatherIcon {
                                    v: hourRow.v
                                    animationMode: root.iconAnimation
                                    size: Math.min(38 * widget.s, hourScroll.rowHeight * 0.9)
                                    Layout.alignment: Qt.AlignVCenter
                                }

                                Text {
                                    text: modelData.temp
                                    color: Kirigami.Theme.textColor
                                    font.pixelSize: 22 * widget.s
                                    font.bold: true
                                    Layout.fillWidth: true
                                }

                                ColumnLayout {
                                    spacing: 0
                                    Layout.alignment: Qt.AlignVCenter

                                    Text {
                                        text: modelData.rainProb
                                        color: Kirigami.Theme.disabledTextColor
                                        font.pixelSize: 12.5 * widget.s
                                        visible: modelData.rainProb !== ""
                                        Layout.alignment: Qt.AlignRight
                                    }
                                    Text {
                                        text: modelData.wind
                                        color: Kirigami.Theme.disabledTextColor
                                        font.pixelSize: 12.5 * widget.s
                                        visible: modelData.wind !== ""
                                        Layout.alignment: Qt.AlignRight
                                    }
                                }
                            }
                        }
                    }
                }

                /* 3-day and 7-day views: one column for each day. */
                RowLayout {
                    id: dayView
                    anchors.fill: parent
                    visible: !forecastArea.stacked
                    spacing: 2 * widget.s

                    Repeater {
                        model: dayView.visible ? root.rows : []

                        delegate: Item {
                            id: dayCell
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            readonly property var v: Weather.vis(modelData.cat)

                            /* A click opens the hourly forecast of this day. */
                            Rectangle {
                                anchors.fill: parent
                                anchors.margins: 2 * widget.s
                                radius: 5 * widget.s
                                color: dayMouse.containsMouse
                                    ? Qt.rgba(Kirigami.Theme.highlightColor.r,
                                              Kirigami.Theme.highlightColor.g,
                                              Kirigami.Theme.highlightColor.b, 0.15)
                                    : "transparent"
                            }

                            MouseArea {
                                id: dayMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.showHourlyDay(modelData.date)
                            }

                            /* Height of the text lines, without the symbol.
                               The symbol then fills what is left. */
                            readonly property real textHeight: (15 + 11 + 23 + 15 + 12 + 12)
                                * 1.35 * widget.s * widget.d + 6 * 3 * widget.s * widget.d
                            readonly property real iconSize: Math.max(42 * widget.s * widget.d,
                                Math.min(dayCell.width * 0.85, dayCell.height - textHeight))

                            ColumnLayout {
                                anchors.centerIn: parent
                                spacing: 3 * widget.s * widget.d

                                ColumnLayout {
                                    spacing: 0
                                    Layout.alignment: Qt.AlignHCenter

                                    Text {
                                        text: modelData.top
                                        color: Kirigami.Theme.textColor
                                        font.pixelSize: 15 * widget.s * widget.d
                                        font.bold: true
                                        Layout.alignment: Qt.AlignHCenter
                                    }
                                    Text {
                                        text: modelData.sub
                                        color: Kirigami.Theme.disabledTextColor
                                        font.pixelSize: 11 * widget.s * widget.d
                                        visible: modelData.sub !== ""
                                        Layout.alignment: Qt.AlignHCenter
                                    }
                                }

                                WeatherIcon {
                                    v: dayCell.v
                                    animationMode: root.iconAnimation
                                    size: dayCell.iconSize
                                    Layout.alignment: Qt.AlignHCenter
                                }

                                Text {
                                    text: modelData.temp
                                    color: Kirigami.Theme.textColor
                                    font.pixelSize: 23 * widget.s * widget.d
                                    font.bold: true
                                    Layout.alignment: Qt.AlignHCenter
                                }
                                Text {
                                    text: modelData.tempMin
                                    color: Kirigami.Theme.disabledTextColor
                                    font.pixelSize: 15 * widget.s * widget.d
                                    visible: modelData.tempMin !== null
                                    Layout.alignment: Qt.AlignHCenter
                                }
                                Text {
                                    text: modelData.rainProb
                                    color: Kirigami.Theme.disabledTextColor
                                    font.pixelSize: 12 * widget.s * widget.d
                                    visible: modelData.rainProb !== ""
                                    Layout.alignment: Qt.AlignHCenter
                                }
                                Text {
                                    text: modelData.wind
                                    color: Kirigami.Theme.disabledTextColor
                                    font.pixelSize: 12 * widget.s * widget.d
                                    visible: modelData.wind !== ""
                                    Layout.alignment: Qt.AlignHCenter
                                }
                            }
                        }
                    }
                }
            }
        }

        PC3.BusyIndicator {
            anchors.centerIn: parent
            running: root.loading
            visible: root.loading
            implicitWidth: 32 * widget.s
            implicitHeight: 32 * widget.s
        }

        Rectangle {
            anchors.fill: parent
            color: Qt.rgba(0, 0, 0, 0.5)
            visible: root.errorMsg !== "" && !root.loading
            radius: 6 * widget.s

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 6 * widget.s

                Text {
                    text: root.errorMsg
                    color: "white"
                    font.pixelSize: 10 * widget.s
                    horizontalAlignment: Text.AlignHCenter
                    Layout.maximumWidth: widget.width * 0.8
                    wrapMode: Text.WordWrap
                }
                PC3.Button {
                    text: "Retry"
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: root.refresh()
                }
            }
        }
    }

    /* One minute is often enough to see a change of hour, and it also finds a change that a
       suspend or a change of the system clock made. */
    Timer {
        id: clock
        interval: 60 * 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            var d = new Date();
            root.nowHour = d.getHours();
            var key = Weather.dateKey(d);
            if (key !== root.nowDate) {
                /* A new day started. The days of the forecast moved, thus all data is old. */
                root.nowDate = key;
                if (root.hourlyDate < key) root.hourlyDate = key;
                root.refresh();
            }
        }
    }

    Timer {
        id: autoRefresh
        interval: 30 * 60 * 1000
        repeat: true
        triggeredOnStart: false
        /* Keeps the data on the screen while the new data comes. */
        onTriggered: {
            root.clearCache();
            root.fetchMode(root.effMode, true);
            root.fetchCurrent();
        }
    }

    /* Only for the configuration. One "Apply" can change some properties together, and
       the dialog sends them one by one. A change of view mode does not use this timer. */
    Timer {
        id: debounce
        interval: 400
        /* The test is here, and not only when the timer starts: the settings properties get
           their values before Component.onCompleted, thus the first fetch can come between. */
        onTriggered: {
            if (root.settingsKey === root.fetchedKey) return;
            root.refresh();
        }
    }

    /* Plasma 6 context-menu action. Plasmoid.setAction() is Plasma 5 and does not exist. */
    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: "Refresh"
            icon.name: "view-refresh"
            onTriggered: root.refresh()
        }
    ]

    Component.onCompleted: {
        showMode(effMode);
        fetchCurrent();
        autoRefresh.start();
    }

    /* A change of view is immediate: no timer, and no network wait when the data is there. */
    onEffModeChanged: {
        debounce.stop();
        showMode(effMode);
    }

    /* Another day in the hourly view. The hours of all days are in one reply, thus this
       normally needs no request. */
    onHourlyDateChanged: {
        if (effMode !== mode24h) return;
        if (cache["hours"]) {
            rows = hoursOf(hourlyDate);
            displayMode = mode24h;
        } else {
            showMode(mode24h);
        }
    }

    /* A change here makes all held data wrong, thus the cache goes away and the data
       is fetched again. */
    onSettingsKeyChanged: {
        if (settingsKey === fetchedKey) return;
        debounce.restart();
    }
}
