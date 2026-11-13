/*
 * SPDX-FileCopyrightText: 2020 Han Young <hanyoung@protonmail.com>
 * SPDX-FileCopyrightText: 2020 Devin Lin <espidev@gmail.com>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */
import QtQuick

/* Falling rain: short streaks, each moved by its own animation, thus no drawing code runs for
   each frame. "drops" is the number of streaks and "speed" their pace; a slow drop is also a
   short and thin streak. Drizzle uses few, slow drops.
   A Canvas that was painted again every 16 ms made plasmashell use more memory all the time
   (about 1 MB per minute, measured) and much CPU time; animated items do neither. */
Item {
    id: rain
    property bool running: true
    property int drops: 80
    property real speed: 1.0

    /* The Repeater makes new drops when "drops" changes, also when the category changes from
       drizzle to rain while the scene is on the screen. */
    Repeater {
        model: rain.drops

        Rectangle {
            id: drop
            /* The canvas moved a drop "ys" pixels each 16 ms and drew it "l * ys" long. */
            readonly property real ys: (Math.random() * 10 + 10) * rain.speed
            readonly property real l: 2 + Math.random() * 4
            /* Where the drop is when the scene starts, as a part of the height. */
            readonly property real start: Math.random()

            width: 2 + rain.speed
            height: l * ys + width
            radius: width / 2
            color: Qt.rgba(1, 1, 1, 0.5)
            x: Math.random() * rain.width
            y: -20

            /* First from the start place to the bottom, then from above the top to the bottom
               again and again, at the pace of the canvas version. */
            SequentialAnimation on y {
                id: fall
                running: rain.running && rain.height > 0
                NumberAnimation {
                    from: drop.start * rain.height
                    to: rain.height
                    duration: (1 - drop.start) * rain.height / drop.ys * 16
                }
                NumberAnimation {
                    from: -20
                    to: rain.height
                    duration: (rain.height + 20) / drop.ys * 16
                    loops: Animation.Infinite
                }
            }

            /* An animation reads "to" and "duration" only when it starts. */
            Connections {
                target: rain
                function onHeightChanged() {
                    if (fall.running) fall.restart();
                }
            }
        }
    }
}
