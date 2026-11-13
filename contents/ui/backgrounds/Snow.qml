/*
 * SPDX-FileCopyrightText: 2020 Han Young <hanyoung@protonmail.com>
 * SPDX-FileCopyrightText: 2020 Devin Lin <espidev@gmail.com>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */
import QtQuick

/* Falling snow: 80 circles, each moved by its own animation, thus no drawing code runs for each
   frame. The flakes are half of the KWeather original size.
   A Canvas that was painted again every 16 ms made plasmashell use more memory all the time
   (about 1 MB per minute, measured) and much CPU time; animated items do neither. */
Item {
    id: snow
    property bool running: true

    Repeater {
        model: 80

        Rectangle {
            id: flake
            /* The canvas moved a flake "ys" pixels each 16 ms. The small minimum gives each
               animation a finite duration: a flake crosses the scene in at most about 40 s. */
            readonly property real ys: Math.max(0.05, Math.random())
            readonly property real l: 2.5 + Math.random() * 5
            /* Where the flake is when the scene starts, as a part of the height. */
            readonly property real start: Math.random()

            /* The canvas drew a circle around (x, y) with the radius "l". */
            width: 2 * l
            height: width
            radius: l
            color: Qt.rgba(1, 1, 1, 0.4 + Math.random() * 0.6)
            x: Math.random() * snow.width - l
            y: -20 - l

            SequentialAnimation on y {
                id: fall
                running: snow.running && snow.height > 0
                NumberAnimation {
                    from: flake.start * snow.height - flake.l
                    to: snow.height - flake.l
                    duration: (1 - flake.start) * snow.height / flake.ys * 16
                }
                NumberAnimation {
                    from: -20 - flake.l
                    to: snow.height - flake.l
                    duration: (snow.height + 20) / flake.ys * 16
                    loops: Animation.Infinite
                }
            }

            /* An animation reads "to" and "duration" only when it starts. */
            Connections {
                target: snow
                function onHeightChanged() {
                    if (fall.running) fall.restart();
                }
            }
        }
    }
}
