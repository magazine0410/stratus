# Background scenes

The animated scenes behind the weather that is now come from KWeather, the weather application
of KDE: https://invent.kde.org/utilities/kweather, folder `src/qml/backgrounds/` and its
`components/` folder. Copyright 2020 Han Young and Devin Lin.

License: GPL-2.0-or-later. The SPDX headers stay in each file.

The scenes are drawn with Qt Quick only: a gradient, rectangles, and a canvas for the rain and
the snow. There are no image files.

## Changes from the originals

- `Scene.qml` replaces the twelve scene files and `DynamicForecastBackground.qml`: one table of
  colours and parts, selected by the category of the widget and by day or night.
- The sun, the clouds and the snowflakes are half of the original size, because this block is a
  few centimetres high and not a phone screen. With the original sizes, one cloud fills the block
  and a snowflake is as big as a letter.
- Each part has a `running` property. The movement stops when the popup is closed, thus a closed
  tray popup costs nothing.
- The rain has a number of drops and a speed: drizzle has 20 slow, thin drops; the other rain
  categories have the original 80.
- Clear day is a blue-to-yellow gradient; the original is flat amber.
- Partly cloudy day shows the sun with the clouds; the original has only the clouds.
- The sun uses looping animations instead of a restart at each turn, and unused imports are
  removed.
