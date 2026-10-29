/*
 * SPDX-FileCopyrightText: 2020 Han Young <hanyoung@protonmail.com>
 * SPDX-FileCopyrightText: 2020 Devin Lin <espidev@gmail.com>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */
import QtQuick

/* Thirty stars that come and go, each at its own pace. */
Item {
    id: stars
    anchors.fill: parent

    property bool running: true
    property double starRadius: 1
    property double opacityModifier: 0

    NumberAnimation on opacityModifier {
        running: stars.running
        to: 10000
        duration: 10000
        onFinished: {
            to = (stars.opacityModifier === 0) ? 10000 : 0;
            restart();
        }
    }

    Repeater {
        model: 30
        Item {
            anchors.fill: stars
            property double starModifier: Math.max(1000, 5000 * Math.random())
            opacity: {
                var remainder = stars.opacityModifier % (2 * starModifier);
                if (remainder > starModifier) {
                    return (starModifier - (remainder % starModifier)) / starModifier;
                }
                return remainder / starModifier;
            }
            Rectangle {
                color: "#fff9c4"
                height: stars.starRadius * 2
                width: height
                radius: width / 2
                x: Math.random() * stars.width
                y: Math.random() * stars.height
            }
        }
    }
}
