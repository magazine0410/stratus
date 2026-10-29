/*
 * SPDX-FileCopyrightText: 2020 Han Young <hanyoung@protonmail.com>
 * SPDX-FileCopyrightText: 2020 Devin Lin <espidev@gmail.com>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */
import QtQuick

/* Falling rain: short lines on a canvas, drawn again every 16 ms while running.
   "drops" is the number of lines and "speed" their pace; a slow drop is also a short and
   thin streak. Drizzle uses few, slow drops. */
Canvas {
    id: canvas
    property bool running: true
    property int drops: 80
    property real speed: 1.0
    property var particles: []

    renderStrategy: Canvas.Threaded
    onPaint: {
        var ctx = getContext("2d");
        ctx.strokeStyle = 'rgba(255,255,255,0.5)';
        ctx.lineWidth = 2 + speed;
        ctx.lineCap = 'round';
        ctx.clearRect(0, 0, width, height);
        for (var c = 0; c < particles.length; c++) {
            var p = particles[c];
            ctx.beginPath();
            ctx.moveTo(p.x, p.y);
            ctx.lineTo(p.x, p.y + p.l * p.ys);
            ctx.stroke();
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

    /* New drops, also when the category changes from drizzle to rain while the scene is
       on the screen: the Loader keeps this item and only changes "drops". */
    function reset() {
        var init = [];
        for (var a = 0; a < drops; a++) {
            init.push({
                x: Math.random() * width,
                y: Math.random() * height,
                l: 2 + Math.random() * 4,
                ys: (Math.random() * 10 + 10) * speed
            });
        }
        particles = init;
    }

    Component.onCompleted: reset()
    onDropsChanged: reset()
    onSpeedChanged: reset()
}
