# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A KDE Plasma 6 applet (plasmoid) written in QML, with no build step and no test suite. The applet
shows the weather that is now on an animated scene, and a forecast for 24 hours, 3 days or 7 days.
It can be on the desktop, on a panel, or in the system tray.

The folder is installed with a symbolic link:
`~/.local/share/plasma/plasmoids/com.magazine.weatherreporting` -> this folder.
Thus each file change is immediately live. Do not copy the files to the plasmoids folder.

## Commands

Preview the applet in a window (the fastest way to see a change):

```bash
plasmawindowed com.magazine.weatherreporting
```

**Run-time QML messages do not go to the stderr of that command. They go to the journal.** Thus
`plasmawindowed ... 2>&1` looks clean even when the QML fails. Always read the journal:

```bash
journalctl --user --since "-2min" | grep -i plasmawindowed
```

Check the syntax and the types statically (the binary is at `/usr/lib64/qt6/bin/qmllint`):

```bash
qmllint -I /usr/lib64/qt6/qml contents/ui/*.qml contents/config/config.qml
```

`unqualified` warnings are expected and are not defects: they come from the use of the `root` and
`widget` ids in `Repeater` delegates, and from the `cfg_` properties in the configuration pages.
Give attention to `missing-property` warnings — they find calls to members that do not exist, which
`plasmawindowed` shows only as a run-time `TypeError` in the journal.

`plasmoidviewer` (package `plasma-sdk`) can show the applet in different form factors.

Make a screenshot of the preview window (Wayland session):

```bash
spectacle -b -n -f -o /tmp/shot.png
```

Use `-f` (the full screen). With `-a` (the active window) the tool usually gets the wrong window,
because the preview window does not have the focus.

To measure the behaviour (cache hits, number of requests, order of the events), put temporary
`console.warn("...")` lines in the functions and a temporary `Timer` that writes to
`Plasmoid.configuration.viewMode`, start `plasmawindowed`, then read the journal. Keep a copy of
the file first, and put it back after the test.

Show the applet metadata as the package system reads it:

```bash
kpackagetool6 --type Plasma/Applet --show com.magazine.weatherreporting
```

An applet on the panel does not reload `metadata.json` or `main.xml` changes. Restart the shell:

```bash
systemctl --user restart plasma-plasmashell
```

To test a different start view or location without the configuration dialog, change the `<default>`
values in `contents/config/main.xml`, start `plasmawindowed`, then put the file back.

## Architecture

### Data flow

`main.qml` (the `PlasmoidItem` root) does all network work and holds the state; `weather.js` is a
`.pragma library` with pure functions and does no I/O.

1. `showMode(mode)` is the entry point. When `cache[mode]` holds data, it goes on the screen
   immediately, and a new fetch starts only when the data is older than `cacheMaxAgeMs`.
2. `fetchMode(mode, background)` selects the source and the URL from the **mode parameter**, never
   from `effMode`.
3. `getUrl()` (XMLHttpRequest) gets the reply; failures go to `fail()`.
4. The reply text goes to a `weather.js` function, which returns an array of rows.
5. `finish()` always puts the rows in `cache[mode]`, but on the screen only when the user did not
   go to another view in the meantime.

Four rules keep this correct. Break one, and the defects come back:

- **The mode goes through the calls as a parameter.** The user can change the view while a reply is
  on the way. A function that reads `effMode` after the reply puts the data in the wrong view.
- **`displayMode`, not `effMode`, controls the layout** (`widget.d` and `forecastArea.stacked`). It
  changes together with `rows`. When the layout follows `effMode`, the old data gets the new
  layout for a moment, and the user sees the sizes and the positions jump.
- **`pending[mode]`** stops a second request for a mode that already has one on the way.
- **`generation`** goes up in `clearCache()`. `getUrl()` throws away a reply with an old number,
  thus data of the previous location or source can not come on the screen too late.

The tab bar's `currentIndex` is set with a `Binding` element to `effMode`, because a click writes
`currentIndex` and would break a plain binding.

A change of view mode calls `showMode()` directly — it must stay immediate. Only the settings use
the 400 ms `debounce` timer, because one "Apply" sends its properties one by one. The timer tests
`settingsKey === fetchedKey` **when it fires**, because the configuration properties get their
values before `Component.onCompleted`; without that test the applet fetches everything twice at the
start. Put each new configuration property that changes the data into `settingsKey`.

### The weather that is now

`fetchCurrent()` gets the `current` block of Open-Meteo (temperature, weather code, wind speed and
direction, `is_day`) for every source, like the base of the hourly view. `Weather.omCurrent()`
makes `{ temp, cat, wind, windDeg, isDay }`, and `root.current` holds it (null before the first
reply). It has no view and no cache: `refresh()` and the `autoRefresh` timer call `fetchCurrent()`
together with the forecast, and `pending["current"]` stops a second request. The tray icon
(`Plasmoid.icon`, `Weather.themeIcon()`) and the tool tip follow it.

The block at the top of the widget (`hero` in `main.qml`) shows it on an animated scene:
`backgrounds/Scene.qml` chooses the gradient and the parts (sun, stars, clouds, rain, snow) from
`cat` and `isDay`. The parts come from KWeather, GPL-2.0-or-later; `backgrounds/README.md` lists
the changes. There are no image files. The scene has a `running` property: it is false when
`iconAnimation` is `static`, and in the tray while the popup is closed (`root.expanded`), thus a
closed popup costs nothing. The rain and the snow repaint a canvas every 16 ms while running.

### The hourly view

The 24 h view is a scrollable list of the 24 hours of **one day** (`hourlyDate`, a `"YYYY-MM-DD"`
key). A click on a day in the 3-day or 7-day view calls `showHourlyDay()` with that day's key; the
"24 h" button always goes back to today.

`hourly` holds **all days at once**: date key -> array of 24 rows, under the single cache key
`"hours"`. One Open-Meteo reply (`forecast_days=7&hourly=...`, 168 steps, ~7 kB) covers every day,
thus a click on another day needs no request.

**Open-Meteo is always the base layer, also when the source is FMI.** FMI starts at the hour that is
now and reaches about 49 hours, thus it has no hours earlier in today and no days after tomorrow.
`Weather.mergeHourly(base, over)` puts the FMI hours on top of the Open-Meteo hours, hour by hour.
Measured at 19:25: today = 20 Open-Meteo + 4 FMI, tomorrow = 24 FMI, day 3 = 22 FMI + 2 Open-Meteo,
days 4-7 = Open-Meteo. Each day always has 24 rows. The header then says "FMI + Open-Meteo".

Two things in the list are easy to break:

- **`positionViewAtIndex` needs the correct reason.** The view must open with the hour that is now
  at the **top** (`ListView.Beginning`), but a change of the clock must only bring that hour into
  view (`ListView.Contain`), and do nothing when it is visible already. `lastNow` separates the two:
  it is -1 when the view opens or changes day, and holds the hour after that. Without this, the
  `nowIndexChanged` handler runs after `countChanged` and the view opens at the wrong place.
- **A `MouseArea` over a day must not be blocked.** `WeatherIcon.qml` has a `MouseArea` for the
  tool tip and the hover animation with `acceptedButtons: Qt.NoButton`. Without that, a click on the
  symbol does not reach the day below it, and the day does not open.

### The row contract

All views show one array of identical row objects, whichever source and view mode made them.
`hourRow()` and `dayRow()` in `weather.js` are the only makers of these objects:

```
{ top, sub, temp, tempMin, cat, rainProb, wind }
hour rows add:  hour (0-23), date ("YYYY-MM-DD"), src ("FMI" or "Open-Meteo")
day rows add:   date ("YYYY-MM-DD", the day that a click opens)
```

`top` is the time or the day name, `sub` is the date (empty for hours), `tempMin` is `null` for
hours, and `rainProb` and `wind` are already-formatted strings that are empty when the user hides
them or the source does not give the value. `cat` is a category key; `Weather.vis(cat)` changes it
into the tile color, the glyph and the name. Keep new data behind this contract, or both views and
both sources must change.

### Two sources, two formats

- Open-Meteo: JSON, WMO weather codes -> `wmoCat()`. It gives rain probability and 7 days.
- FMI: WFS XML, parsed with a regular expression in `parseFmiXml()`, smart symbol codes ->
  `fmiCat()`. It gives no rain probability and no 7-day forecast.

Because FMI has no 7-day data, `sevenDayOk` is false when the source is FMI only, and `effMode`
falls back from `mode7d` to `mode3d`. Use `effMode` for data and layout, and `viewMode` only to
show what the user selected. With `weatherSource: "both"`, FMI gives the 24-hour and 3-day data and
Open-Meteo gives the 7-day data.

FMI hourly data starts at the present hour. Thus the fixed 06:00/12:00/18:00/24:00 slots of the
24-hour view are empty (`—`) when that time is in the past today.

### Views and sizes

`fullRepresentation` holds the current-conditions block, a `PC3.TabBar` with the three views, then
one `Item` (`forecastArea`) with two layouts:
`stackedView` (a vertical row for each time, for the 24-hour view) and `dayView` (a column for each
day). Only one is visible; the hidden one gets an empty model, to prevent unnecessary delegates.

All sizes are multiples of `widget.s`, a scale factor from the applet size
(`min(width / 380, height / 250)`, limited to 0.45–3.0). The `widget.d` factor makes the 7-day view
smaller, because it has 7 columns. Use these factors for each new size; do not write pixel
constants.

The weather tile is `WeatherIcon.qml`. It sets only `implicitWidth`/`implicitHeight`, so that its
parent layout can size it. Its `size` is calculated from the space that is free after the text
(`stackedView.rowHeight`, `dayCell.iconSize`) — do not bind the size to the height of a parent
layout, because that makes a binding loop.

### System tray

`metadata.json` has `X-Plasma-NotificationArea` and `X-Plasma-NotificationAreaCategory`, thus the
tray lists the applet in its "Entries" settings. The shell must be restarted after a change there.

`root.inTray` is `Plasmoid.containment.containmentType === 129 && Plasmoid.formFactor === 2`
(CustomEmbedded, Horizontal). Plasma 6 gives no direct property; Weather Widget Plus and the
Wunderground applet use the same test. Two things depend on it:

- **`preferredRepresentation` is null in the tray.** The tray puts an applet's full
  representation in its popup only when the applet has no preferred representation (see
  `PlasmoidPopupsContainer.qml` in plasma-workspace). With `fullRepresentation` forced, the
  popup stays empty and the forecast is squeezed into the icon slot.
- **The tray decides the popup size.** It binds the width and the height of the full
  representation to its own stack view, at least 24 x 24 grid units (about 430 px), with a
  heading above. `Layout.preferredWidth/Height` are ignored there; `widget.s` handles the shape.

The icon in the tray is `Plasmoid.icon`, drawn by the default compact representation.

### Plasma 6 API

This is a Plasma 6 applet. Plasma 5 examples on the web do not always apply. Known differences that
already caused defects here:

- `Plasmoid.setAction()` and the `action_<name>()` functions do not exist. Use
  `Plasmoid.contextualActions: [ PlasmaCore.Action { ... } ]` (`import org.kde.plasma.core as
  PlasmaCore`).
- The fonts are on `Kirigami.Theme` (`Kirigami.Theme.smallFont`), not on `Kirigami.Units`.

A failure of this kind stops the rest of the JavaScript block. When `Component.onCompleted` stops,
the applet can still look correct, because the `debounce` timer starts the first fetch when the
configuration properties change. But the 30-minute `autoRefresh` timer then never starts.

### Weather symbols

The symbols are animated SVG files in `contents/icons/meteocons/` (Meteocons, MIT). Each file has
the name of a **widget category**, not the Meteocons name; `VIS` in `weather.js` gives the file name
and the tool tip text for each category. `WeatherIcon.qml` shows them with `QtQuick.VectorImage`
and controls the movement with the `iconAnimation` setting (`static`, `hover`, `always`).

What Qt 6.11 does and does not do with animated SVG — all measured with `qml` and frame grabs,
not read from documentation:

| Feature | Works |
|---|---|
| `animateTransform` (translate, rotate, scale) | **yes** |
| `<animate attributeName="opacity">` (SMIL) | **no** |
| `@keyframes` opacity in CSS (shorthand or longhand) | **no** |
| `<mask>` | **no** — a masked element does not come on the screen at all |

Therefore the files got two changes when they came into this folder (see the README there):
`opacity="0"` is removed from each element that animates its opacity (without this, only the first
raindrop of each icon is visible), and the masks are removed (without this, the sun of
`partly`, `mostlyclear` and others does not come on the screen).

**Test each new symbol file** before you use it: put it in the grid test (see the README) and look
at it. A file with a mask or with a fade animation looks correct in a browser and wrong in Qt.

### Configuration

Three parts must agree:

1. `contents/config/main.xml` — the key, the type and the default value.
2. A page in `contents/ui/` with a `cfg_<key>` property (`configSources.qml` for the source and the
   location, `configGeneral.qml` for the details).
3. `contents/config/config.qml` — the `ConfigCategory` that shows the page. Its `source` path is
   relative to `contents/ui/`.

Without part 3 the dialog shows only the standard "Keyboard Shortcuts" and "About" pages.

`configSources.qml` also does a location search with the Open-Meteo geocoding API. It writes the
name, the latitude and the longitude together, thus these three keys always agree.
