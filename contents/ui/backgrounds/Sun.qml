/*
 * SPDX-FileCopyrightText: 2020 Han Young <hanyoung@protonmail.com>
 * SPDX-FileCopyrightText: 2020 Devin Lin <espidev@gmail.com>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */
import QtQuick

/* The sun: three sets of rotating squares at the top right.
   The sizes are half of the KWeather original. */
Item {
    id: sun
    anchors.fill: parent

    property bool running: true
    property double unitSize: width / 100
    property double innerRotation: 0
    property double outerRotation: 0
    property double outerOuterRotation: 0

    NumberAnimation on innerRotation {
        from: 0; to: 360; duration: 20000
        loops: Animation.Infinite
        running: sun.running
    }
    NumberAnimation on outerRotation {
        from: 0; to: 360; duration: 15000
        loops: Animation.Infinite
        running: sun.running
    }
    NumberAnimation on outerOuterRotation {
        from: 0; to: 360; duration: 12000
        loops: Animation.Infinite
        running: sun.running
    }

    Repeater {
        model: 6
        Rectangle {
            width: sun.unitSize * 60
            height: width
            color: "#ffa000"
            opacity: 0.4
            rotation: sun.outerOuterRotation + index * (90 / 6)
            x: sun.width - sun.unitSize * 10 - width / 2
            y: sun.unitSize * 10 - height / 2
            antialiasing: true
        }
    }
    Repeater {
        model: 5
        Rectangle {
            width: sun.unitSize * 30
            height: width
            color: "#ff8f00"
            opacity: 0.5
            rotation: sun.outerRotation + index * (90 / 5)
            x: sun.width - sun.unitSize * 10 - width / 2
            y: sun.unitSize * 10 - height / 2
            antialiasing: true
        }
    }
    Repeater {
        model: 3
        Rectangle {
            width: sun.unitSize * 15
            height: width
            color: "#ff6f00"
            opacity: 0.5
            rotation: sun.innerRotation + index * (90 / 3)
            x: sun.width - sun.unitSize * 10 - width / 2
            y: sun.unitSize * 10 - height / 2
            antialiasing: true
        }
    }
}
