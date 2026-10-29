/*
 * SPDX-FileCopyrightText: 2020 Han Young <hanyoung@protonmail.com>
 * SPDX-FileCopyrightText: 2020 Devin Lin <espidev@gmail.com>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */
import QtQuick

/* Falling snow: 80 circles on a canvas, drawn again every 16 ms while running.
   The flakes are half of the KWeather original size. */
Canvas {
    id: canvas
    property bool running: true
    property var particles: []

    renderStrategy: Canvas.Threaded
    onPaint: {
        var ctx = getContext("2d");
        ctx.clearRect(0, 0, width, height);
        for (var c = 0; c < particles.length; c++) {
            var p = particles[c];
            ctx.beginPath();
            ctx.arc(p.x, p.y + p.ys, p.l, 0, 2 * Math.PI, false);
            ctx.fillStyle = Qt.rgba(1, 1, 1, p.a);
            ctx.fill();
        }
        for (var b = 0; b < particles.length; b++) {
            var q = particles[b];
            q.y += q.ys;
            if (q.x < 1 || q.x > width || q.y > height) {
                q.x = Math.random() * width;
                q.y = -20;
            }
        }
    }
    Timer {
        interval: 16
        running: canvas.running
        repeat: true
        onTriggered: canvas.requestPaint()
    }

    Component.onCompleted: {
        var init = [];
        for (var a = 0; a < 80; a++) {
            init.push({
                x: Math.random() * width,
                y: Math.random() * height,
                l: 2.5 + Math.random() * 5,
                ys: Math.random(),
                a: 0.4 + Math.random() * 0.6
            });
        }
        particles = init;
    }
}
