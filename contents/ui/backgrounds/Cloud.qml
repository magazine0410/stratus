/*
 * SPDX-FileCopyrightText: 2020 Han Young <hanyoung@protonmail.com>
 * SPDX-FileCopyrightText: 2020 Devin Lin <espidev@gmail.com>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */
import QtQuick

/* One cloud: a soft circle that slowly changes its size and its place. */
Item {
    id: cloud
    anchors.fill: parent

    property bool running: true
    property double maxRadiusChange
    property double maxCoordChange
    property double minRadius
    property double minX
    property double minY
    property double radius: minRadius
    property double centerX: minX
    property double centerY: minY
    property color color

    NumberAnimation on radius {
        duration: 4000
        running: cloud.running
        easing.type: Easing.InOutQuad
        onFinished: {
            to = cloud.minRadius + Math.random() * cloud.maxRadiusChange;
            restart();
        }
    }
    NumberAnimation on centerX {
        duration: 2600
        running: cloud.running
        easing.type: Easing.InOutQuad
        onFinished: {
            to = cloud.minX + Math.random() * cloud.maxCoordChange;
            restart();
        }
    }
    NumberAnimation on centerY {
        duration: 3400
        running: cloud.running
        easing.type: Easing.InOutQuad
        onFinished: {
            to = cloud.minY + Math.random() * cloud.maxCoordChange;
            restart();
        }
    }

    Rectangle {
        radius: width / 2
        color: cloud.color
        width: cloud.radius * 2
        height: width
        x: cloud.centerX - width / 2
        y: cloud.centerY - width / 2
    }
}
