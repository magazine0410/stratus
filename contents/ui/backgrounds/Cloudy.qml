/*
 * SPDX-FileCopyrightText: 2020 Han Young <hanyoung@protonmail.com>
 * SPDX-FileCopyrightText: 2020 Devin Lin <espidev@gmail.com>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */
import QtQuick

/* Seven clouds. The radii are half of the KWeather original. */
Item {
    id: clouds
    anchors.fill: parent
    opacity: 0.65

    property bool running: true
    property color cloudColor: "white"
    property double unitSize: width / 100
    property double heightUnitSize: height / 100

    Cloud {
        running: clouds.running
        opacity: 0.2
        color: clouds.cloudColor
        maxRadiusChange: clouds.unitSize * 3
        maxCoordChange: clouds.unitSize * 6
        minRadius: clouds.unitSize * 20
        minX: clouds.unitSize * 10
        minY: clouds.heightUnitSize * -3
    }
    Cloud {
        running: clouds.running
        opacity: 0.3
        color: clouds.cloudColor
        maxRadiusChange: clouds.unitSize * 2
        maxCoordChange: clouds.unitSize * 5
        minRadius: clouds.unitSize * 20
        minX: clouds.unitSize * 40
        minY: clouds.heightUnitSize * 20
    }
    Cloud {
        running: clouds.running
        opacity: 0.2
        color: clouds.cloudColor
        maxRadiusChange: clouds.unitSize * 3
        maxCoordChange: clouds.unitSize * 2
        minRadius: clouds.unitSize * 11
        minX: clouds.unitSize * 85
        minY: clouds.heightUnitSize * 7
    }
    Cloud {
        running: clouds.running
        opacity: 0.2
        color: clouds.cloudColor
        maxRadiusChange: clouds.unitSize * 2
        maxCoordChange: clouds.unitSize * 6
        minRadius: clouds.unitSize * 20
        minX: clouds.unitSize * 110
        minY: clouds.heightUnitSize * -6
    }
    Cloud {
        running: clouds.running
        opacity: 0.5
        color: clouds.cloudColor
        maxRadiusChange: clouds.unitSize * 3
        maxCoordChange: clouds.unitSize * 2
        minRadius: clouds.unitSize * 16
        minX: clouds.unitSize * 32
        minY: clouds.heightUnitSize * 6
    }
    Cloud {
        running: clouds.running
        opacity: 0.6
        color: clouds.cloudColor
        maxRadiusChange: clouds.unitSize * 3
        maxCoordChange: clouds.unitSize * 6
        minRadius: clouds.unitSize * 12
        minX: clouds.unitSize * 48
        minY: clouds.heightUnitSize * 10
    }
    Cloud {
        running: clouds.running
        opacity: 0.5
        color: clouds.cloudColor
        maxRadiusChange: clouds.unitSize * 5
        maxCoordChange: clouds.unitSize * 2
        minRadius: clouds.unitSize * 13
        minX: clouds.unitSize * 90
        minY: clouds.heightUnitSize * 17
    }
}
