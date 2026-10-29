.pragma library

/*
 * Stratus - data helpers.
 * Converts Open-Meteo (JSON, WMO weather codes) and FMI WFS (XML, smart symbol codes)
 * into one row format used by the widget.
 */

var WD = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

/* Category -> symbol file (see ../icons/meteocons/) and name.
   "icon" is the file name without ".svg". */
var VIS = {
    "clear":        { icon: "clear",        name: "Clear" },
    "mostlyclear":  { icon: "mostlyclear",  name: "Mostly clear" },
    "partly":       { icon: "partly",       name: "Partly cloudy" },
    "cloudy":       { icon: "cloudy",       name: "Cloudy" },
    "mostlycloudy": { icon: "mostlycloudy", name: "Mostly cloudy" },
    "overcast":     { icon: "overcast",     name: "Overcast" },
    "fog":          { icon: "fog",          name: "Fog" },
    "drizzle":      { icon: "drizzle",      name: "Drizzle" },
    "showers":      { icon: "showers",      name: "Rain showers" },
    "rain":         { icon: "rain",         name: "Rain" },
    "heavyrain":    { icon: "heavyrain",    name: "Heavy rain" },
    "sleet":        { icon: "sleet",        name: "Sleet" },
    "freezing":     { icon: "freezing",     name: "Freezing precipitation" },
    "snow":         { icon: "snow",         name: "Snow" },
    "thunder":      { icon: "thunder",      name: "Thunderstorm" }
};

function vis(cat) {
    return VIS[cat] || VIS["cloudy"];
}

/* WMO weather codes (Open-Meteo). */
function wmoCat(c) {
    c = Math.round(c);
    if (c === 0) return "clear";
    if (c === 1) return "mostlyclear";
    if (c === 2) return "partly";
    if (c === 3) return "overcast";
    if (c === 45 || c === 48) return "fog";
    if (c >= 51 && c <= 55) return "drizzle";
    if (c === 56 || c === 57) return "freezing";
    if (c === 61 || c === 63) return "rain";
    if (c === 65) return "heavyrain";
    if (c === 66 || c === 67) return "freezing";
    if (c >= 71 && c <= 77) return "snow";
    if (c >= 80 && c <= 82) return "showers";
    if (c === 85 || c === 86) return "snow";
    if (c >= 95) return "thunder";
    return "cloudy";
}

/* FMI WeatherSymbol3 (smart symbol codes, no day/night variants). */
function fmiCat(c) {
    c = Math.round(c);
    if (c === 1) return "clear";
    if (c === 2) return "mostlyclear";
    if (c === 3 || c === 5 || c === 8) return "cloudy";
    if (c === 4) return "partly";
    if (c === 6) return "mostlycloudy";
    if (c === 7) return "overcast";
    if (c === 9 || c === 10) return "fog";
    if (c === 11) return "drizzle";
    if (c === 14 || c === 17) return "freezing";
    if (c === 21 || c === 24 || c === 27) return "showers";
    if (c >= 31 && c <= 36) return "rain";
    if (c >= 37 && c <= 39) return (c === 37) ? "rain" : "heavyrain";
    if (c >= 41 && c <= 49) return "sleet";
    if (c >= 51 && c <= 59) return "snow";
    if (c >= 61 && c <= 67) return "showers";
    if (c >= 71 && c <= 77) return "thunder";
    return "cloudy";
}

function deg(v) {
    if (v === null || v === undefined || isNaN(v)) return "—";
    return Math.round(v) + "°";
}

/* "YYYY-MM-DD" in local time. It is the key of a day in the hourly data and in the cache. */
function dateKey(date) {
    var m = date.getMonth() + 1;
    var d = date.getDate();
    return date.getFullYear() + "-" + (m < 10 ? "0" : "") + m + "-" + (d < 10 ? "0" : "") + d;
}

function todayKey() {
    return dateKey(new Date());
}

/* The date of "YYYY-MM-DD" at 12:00, thus a summer time change can not move it to another day. */
function dateFromKey(key) {
    return new Date(key + "T12:00");
}

function hourLabel(h) {
    return (h < 10 ? "0" : "") + h + ":00";
}

function dayLabel(i, date, wide) {
    if (wide && i === 0) return "Today";
    if (wide && i === 1) return "Tomorrow";
    return WD[date.getDay()];
}

function dateLabel(date) {
    return date.getDate() + "." + (date.getMonth() + 1) + ".";
}

/* One hour of the hourly view. "hour" (0-23) and "date" let the view find the hour that is now.
   "src" says which service gave the values; the hourly view can mix them. */
function hourRow(hour, key, temp, cat, prob, wind, src, opts) {
    return {
        top: hourLabel(hour),
        sub: "",
        hour: hour,
        date: key,
        src: src,
        temp: deg(temp),
        tempMin: null,
        cat: cat,
        rainProb: (opts.rainProb && prob !== null && prob !== undefined && !isNaN(prob)) ? Math.round(prob) + " %" : "",
        wind: (opts.wind && wind !== null && wind !== undefined && !isNaN(wind)) ? Math.round(wind) + " m/s" : ""
    };
}

/* A row without values. It keeps the list at 24 rows when no service has that hour. */
function emptyHourRow(hour, key) {
    return {
        top: hourLabel(hour), sub: "", hour: hour, date: key, src: "",
        temp: "—", tempMin: null, cat: "cloudy", rainProb: "", wind: ""
    };
}

/* Takes the hours of "over" (the better service) where they exist, and the hours of "base"
   everywhere else. Both are maps of date key -> array of 24 rows or null.
   This fills the hours that FMI does not have (the hours of today that are past). */
function mergeHourly(base, over) {
    var out = {};
    var key;
    for (key in base) out[key] = base[key].slice();
    for (key in over) {
        if (!out[key]) out[key] = over[key].slice();
        else {
            for (var h = 0; h < 24; h++) {
                if (over[key][h]) out[key][h] = over[key][h];
            }
        }
    }
    /* No hole stays in a day that is shown. */
    for (key in out) {
        for (var i = 0; i < 24; i++) {
            if (!out[key][i]) out[key][i] = emptyHourRow(i, key);
        }
    }
    return out;
}

function dayRow(i, date, tmax, tmin, cat, prob, wind, opts, wide) {
    var p = null, w = null;
    if (prob !== null && prob !== undefined && !isNaN(prob)) p = Math.round(prob) + " %";
    if (wind !== null && wind !== undefined && !isNaN(wind)) w = Math.round(wind) + " m/s";
    return {
        top: dayLabel(i, date, wide),
        sub: dateLabel(date),
        /* A click on a day opens the hourly view of this date. */
        date: dateKey(date),
        temp: deg(tmax),
        tempMin: deg(tmin),
        cat: cat,
        rainProb: (opts.rainProb && p !== null) ? p : "",
        wind: (opts.wind ? w : "")
    };
}

/* ---------- FMI WFS XML ---------- */

function parseFmiXml(text) {
    var out = [];
    var re = /<BsWfs:Time>([^<]+)<\/BsWfs:Time>\s*<BsWfs:ParameterName>([^<]+)<\/BsWfs:ParameterName>\s*<BsWfs:ParameterValue>([^<]+)<\/BsWfs:ParameterValue>/g;
    var m;
    while ((m = re.exec(text)) !== null) {
        var v = parseFloat(m[3]);
        if (isNaN(v)) continue;
        out.push({ ms: new Date(m[1]).getTime(), name: m[2], value: v });
    }
    return out;
}

function fmiByTime(entries) {
    var map = {};
    for (var i = 0; i < entries.length; i++) {
        var e = entries[i];
        if (!map[e.ms]) map[e.ms] = {};
        map[e.ms][e.name] = e.value;
    }
    return map;
}

/* Hourly data of FMI, as a map of date key -> array of 24 rows. An hour that FMI does not have
   stays null; mergeHourly() then takes that hour from Open-Meteo. FMI gives about 49 hours, and
   it starts at the hour that is now, thus the past hours of today are always null here. */
function fmiHourly(entries, opts) {
    var byTime = fmiByTime(entries);
    var out = {};
    for (var ms in byTime) {
        var d = new Date(Number(ms));
        if (d.getMinutes() !== 0) continue;
        var key = dateKey(d);
        if (!out[key]) {
            out[key] = [];
            for (var i = 0; i < 24; i++) out[key].push(null);
        }
        var v = byTime[ms];
        if (v["Temperature"] === undefined) continue;
        out[key][d.getHours()] = hourRow(
            d.getHours(),
            key,
            v["Temperature"],
            (v["WeatherSymbol3"] !== undefined) ? fmiCat(v["WeatherSymbol3"]) : "cloudy",
            null,
            v["WindSpeedMS"],
            "FMI",
            opts
        );
    }
    return out;
}

/* Day view: group hourly values by local date. Symbol from nearest to 13:00. */
function fmiDaily(entries, maxDays, opts, wide) {
    var days = {};
    var order = [];
    for (var i = 0; i < entries.length; i++) {
        var e = entries[i];
        var d = new Date(e.ms);
        var key = d.getFullYear() * 10000 + (d.getMonth() + 1) * 100 + d.getDate();
        if (!days[key]) {
            days[key] = { date: d, tmin: NaN, tmax: NaN, sym: NaN, symRank: Infinity,
                          wMax: NaN };
            order.push(key);
        }
        var day = days[key];
        if (e.name === "Temperature") {
            if (isNaN(day.tmin) || e.value < day.tmin) day.tmin = e.value;
            if (isNaN(day.tmax) || e.value > day.tmax) day.tmax = e.value;
        } else if (e.name === "WeatherSymbol3") {
            var rank = Math.abs(d.getHours() - 13);
            if (rank < day.symRank) { day.symRank = rank; day.sym = e.value; }
        } else if (e.name === "WindSpeedMS") {
            if (isNaN(day.wMax) || e.value > day.wMax) day.wMax = e.value;
        }
    }
    order.sort(function(a, b) { return a - b; });
    var rows = [];
    var today = new Date();
    var todayKey = today.getFullYear() * 10000 + (today.getMonth() + 1) * 100 + today.getDate();
    var idx = 0;
    for (var j = 0; j < order.length && rows.length < maxDays; j++) {
        var dd = days[order[j]];
        if (order[j] < todayKey) continue;
        rows.push(dayRow(
            idx,
            dd.date,
            dd.tmax,
            dd.tmin,
            isNaN(dd.sym) ? "cloudy" : fmiCat(dd.sym),
            null,
            dd.wMax,
            opts,
            wide
        ));
        idx++;
    }
    return rows;
}

/* ---------- Open-Meteo JSON ---------- */

/* Hourly data of Open-Meteo, as a map of date key -> array of 24 rows.
   One reply holds every day, thus a click on a day needs no new request.
   The times are local ("2026-08-16T07:00"), because the request uses timezone=auto. */
function omHourly(json, opts) {
    var j = JSON.parse(json);
    var h = j.hourly;
    var out = {};
    for (var i = 0; i < h.time.length; i++) {
        var t = h.time[i];
        var key = t.slice(0, 10);
        var hour = parseInt(t.slice(11, 13), 10);
        if (!out[key]) {
            out[key] = [];
            for (var k = 0; k < 24; k++) out[key].push(null);
        }
        out[key][hour] = hourRow(
            hour,
            key,
            h.temperature_2m[i],
            wmoCat(h.weather_code[i]),
            h.precipitation_probability ? h.precipitation_probability[i] : null,
            h.wind_speed_10m[i],
            "Open-Meteo",
            opts
        );
    }
    return out;
}

function omDaily(json, opts, wide) {
    var j = JSON.parse(json);
    var d = j.daily;
    var rows = [];
    for (var i = 0; i < d.time.length; i++) {
        var date = new Date(d.time[i] + "T12:00");
        rows.push(dayRow(
            i,
            date,
            d.temperature_2m_max[i],
            d.temperature_2m_min[i],
            wmoCat(d.weather_code[i]),
            d.precipitation_probability_max ? d.precipitation_probability_max[i] : null,
            d.wind_speed_10m_max[i],
            opts,
            wide
        ));
    }
    return rows;
}

/* ---------- The weather that is now ---------- */

/* The "current" block of Open-Meteo -> { temp, cat, wind, windDeg, isDay }.
   "temp" and "wind" are formatted like the rows. "windDeg" is where the wind comes from. */
function omCurrent(json) {
    var c = JSON.parse(json).current;
    var w = c.wind_speed_10m;
    return {
        temp: deg(c.temperature_2m),
        cat: wmoCat(c.weather_code),
        wind: (w !== null && w !== undefined && !isNaN(w)) ? Math.round(w) + " m/s" : "",
        windDeg: c.wind_direction_10m,
        isDay: c.is_day === 1
    };
}

/* Category -> icon-theme name for the panel and the tray, by day and by night (Breeze). */
var THEME_ICON = {
    "clear":        ["weather-clear",                 "weather-clear-night"],
    "mostlyclear":  ["weather-few-clouds",            "weather-few-clouds-night"],
    "partly":       ["weather-few-clouds",            "weather-few-clouds-night"],
    "cloudy":       ["weather-clouds",                "weather-clouds-night"],
    "mostlycloudy": ["weather-clouds",                "weather-clouds-night"],
    "overcast":     ["weather-many-clouds",           "weather-many-clouds"],
    "fog":          ["weather-fog",                   "weather-fog"],
    "drizzle":      ["weather-showers-scattered-day", "weather-showers-scattered-night"],
    "showers":      ["weather-showers-day",           "weather-showers-night"],
    "rain":         ["weather-showers",               "weather-showers"],
    "heavyrain":    ["weather-showers",               "weather-showers"],
    "sleet":        ["weather-snow-rain",             "weather-snow-rain"],
    "freezing":     ["weather-freezing-rain",         "weather-freezing-rain"],
    "snow":         ["weather-snow",                  "weather-snow"],
    "thunder":      ["weather-storm-day",             "weather-storm-night"]
};

function themeIcon(cat, isDay) {
    var pair = THEME_ICON[cat] || THEME_ICON["cloudy"];
    return isDay ? pair[0] : pair[1];
}
