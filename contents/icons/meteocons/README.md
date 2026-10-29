# Meteocons (Flat style)

Weather symbols from Meteocons by Bas Milius: https://github.com/basmilius/meteocons
Raindrop colour changed from #0A5AD4 to #3D8BFF for contrast on a dark background.

License: MIT. See LICENSE. Taken from the npm package @meteocons/svg 0.1.0, style "flat".

Each file has the name of a weather category of this widget (see VIS in ../../ui/weather.js),
and not the original Meteocons name. The files come from these icons:

    clear        <- clear-day             mostlyclear  <- clear-day
    partly       <- partly-cloudy-day     cloudy       <- cloudy
    mostlycloudy <- overcast-day          overcast     <- overcast
    fog          <- fog                   drizzle      <- drizzle
    showers      <- partly-cloudy-day-rain  rain       <- rain
    heavyrain    <- extreme-rain          sleet        <- sleet
    freezing     <- hail                  snow         <- snow
    thunder      <- thunderstorms

## One change to the files

Qt 6.11 animates SVG transforms, but it does not animate opacity, in SMIL or in CSS keyframes
(measured, not supposed). In the original files the second and third raindrop or snowflake have
`opacity="0"` and become visible only through an opacity animation. In Qt they thus stay invisible,
and only one drop falls.

Therefore `opacity="0"` is removed from each element that animates its opacity. All drops are then
visible and fall with their own delay. The `<animate attributeName="opacity">` elements are still
in the files: they do nothing now, but they will work if Qt gets support later.
