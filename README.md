# Stratus

A weather applet for KDE Plasma 6. It shows the weather that is now on an animated scene, and a
forecast for 24 hours, 3 days or 7 days. It can be on the desktop, on a panel, or in the system
tray.

Data comes from [Open-Meteo](https://open-meteo.com/) and from the
[Finnish Meteorological Institute](https://en.ilmatieteenlaitos.fi/open-data) (FMI). With both
selected, FMI gives the 24-hour and 3-day forecasts and Open-Meteo gives the 7-day forecast and
the weather that is now.

## Install

```bash
git clone https://github.com/magazine0410/stratus.git
kpackagetool6 --type Plasma/Applet --install stratus
```

Later updates: `git pull`, then `kpackagetool6 --type Plasma/Applet --upgrade stratus`.

For development, a symbolic link keeps every file change live:

```bash
ln -s "$PWD/stratus" ~/.local/share/plasma/plasmoids/com.magazine.stratus
```

To put it in the system tray, restart the shell (`systemctl --user restart plasma-plasmashell`),
right-click the tray, open "Configure System Tray", and under "Entries" set "Stratus" to "Shown".

## Settings

- Source: Open-Meteo, FMI, or both. Location search uses the Open-Meteo geocoding API.
- Details: rain probability and wind speed.
- Animation: never, when the pointer is on the widget, or always. It controls the weather
  symbols and the background scene.
- Background: near-black or the Plasma theme.

## Licenses

- Stratus: GPL-3.0-or-later, see `LICENSE`.
- Weather symbols: [Meteocons](https://github.com/basmilius/meteocons) by Bas Milius, MIT,
  see `contents/icons/meteocons/`.
- Background scenes: from [KWeather](https://invent.kde.org/utilities/kweather) by Han Young and
  Devin Lin, GPL-2.0-or-later, see `contents/ui/backgrounds/`.
