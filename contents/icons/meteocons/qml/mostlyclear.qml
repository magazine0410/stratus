// Meteocons by Bas Milius, MIT License (see ../LICENSE). Generated from ../mostlyclear.svg by svgtoqml; do not edit, see ../README.md.
// Generated from SVG file mostlyclear.svg
import QtQuick
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
import QtQuick.Shapes
import QtQuick.Effects

Item {
    implicitWidth: 128
    implicitHeight: 128
    component AnimationsInfo : QtObject
    {
        property bool paused: false
        property int loops: 1
        signal restart()
    }
    property AnimationsInfo animations : AnimationsInfo {}
    transform: [
        Scale { xScale: width / 128; yScale: height / 128 }
    ]
    id: _qt_node0
    transformOrigin: Item.TopLeft
    Item { // Structure node
        objectName: "clear-day"
        id: _qt_node1
        transformOrigin: Item.TopLeft
        Item { // Structure node
            objectName: "Sun"
            id: _qt_node2
            transformOrigin: Item.TopLeft
            Shape {
                objectName: "Core"
                id: _qt_node3
                transformOrigin: Item.TopLeft
                preferredRendererType: Shape.CurveRenderer
                ShapePath {
                    id: _qt_node3_fill_stroke
                    objectName: "svg_path:Core"
                    strokeColor: "transparent"
                    fillColor: "#fff8af18"
                    fillRule: ShapePath.WindingFill
                    PathSvg { path: "M 84 63.9999 C 84 75.0456 75.0457 83.9999 64 83.9999 C 52.9543 83.9999 44 75.0456 44 63.9999 C 44 52.9542 52.9543 43.9999 64 43.9999 C 75.0457 43.9999 84 52.9542 84 63.9999 " }
                }
            }
            Shape {
                preferredRendererType: Shape.CurveRenderer
                objectName: "Rays"
                id: _qt_node4
                transformOrigin: Item.TopLeft
                transform: TransformGroup {
                    id: _qt_node4_transform_base_group
                    TransformGroup {
                        id: _qt_node4_transform_group_0
                        Rotation { id: _qt_node4_transform_0_0 }
                    }
                }
                Connections { target: _qt_node0.animations; function onRestart() {_qt_node4_transform_animation.restart() } }
                ParallelAnimation {
                    id:_qt_node4_transform_animation
                    loops: _qt_node0.animations.loops
                    paused: _qt_node0.animations.paused
                    running: true
                    onLoopsChanged: { if (running) { restart() } }
                    SequentialAnimation {
                        loops: Animation.Infinite
                        ScriptAction {
                            script: _qt_node4_transform_base_group.activateOverride(_qt_node4_transform_group_0)
                        }
                        ParallelAnimation {
                            SequentialAnimation {
                                ParallelAnimation {
                                    ScriptAction {
                                        script:_qt_node4_transform_0_0.origin = Qt.vector3d(64, 64, 0)
                                    }
                                    ScriptAction {
                                        script:_qt_node4_transform_0_0.angle = 0
                                    }
                                }
                                ParallelAnimation {
                                    PropertyAnimation {
                                        duration: 6000
                                        target: _qt_node4_transform_0_0
                                        property: "origin"
                                        to: Qt.vector3d(64, 64, 0)
                                    }
                                    PropertyAnimation {
                                        duration: 6000
                                        target: _qt_node4_transform_0_0
                                        property: "angle"
                                        to: 360
                                    }
                                }
                            }
                        }
                    }
                }
                ShapePath {
                    id: _qt_node5_fill_stroke
                    strokeColor: "transparent"
                    fillColor: "#fff8af18"
                    fillRule: ShapePath.WindingFill
                    PathSvg { path: "M 61 19 C 61 17.3431 62.3431 16 64 16 C 65.6568 16 67 17.3431 67 19 L 67 33 C 67 34.6569 65.6568 36 64 36 C 62.3431 36 61 34.6569 61 33 L 61 19 " }
                }
                ShapePath {
                    id: _qt_node6_fill_stroke
                    strokeColor: "transparent"
                    fillColor: "#fff8af18"
                    fillRule: ShapePath.WindingFill
                    PathSvg { path: "M 93.6985 30.0589 C 94.87 28.8873 96.7696 28.8873 97.9411 30.0589 C 99.1127 31.2304 99.1127 33.1299 97.9411 34.3015 L 88.0416 44.201 C 86.8701 45.3726 84.9706 45.3726 83.799 44.201 C 82.6274 43.0294 82.6274 41.1299 83.799 39.9584 L 93.6985 30.0589 " }
                }
                ShapePath {
                    id: _qt_node7_fill_stroke
                    strokeColor: "transparent"
                    fillColor: "#fff8af18"
                    fillRule: ShapePath.WindingFill
                    PathSvg { path: "M 109 61 C 110.657 61 112 62.3432 112 64 C 112 65.6569 110.657 67 109 67 L 95 67 C 93.3431 67 92 65.6569 92 64 C 92 62.3432 93.3431 61 95 61 L 109 61 " }
                }
                ShapePath {
                    id: _qt_node8_fill_stroke
                    strokeColor: "transparent"
                    fillColor: "#fff8af18"
                    fillRule: ShapePath.WindingFill
                    PathSvg { path: "M 97.9411 93.6985 C 99.1127 94.8701 99.1127 96.7696 97.9411 97.9411 C 96.7696 99.1127 94.8701 99.1127 93.6985 97.9411 L 83.799 88.0416 C 82.6274 86.8701 82.6274 84.9706 83.799 83.799 C 84.9706 82.6274 86.8701 82.6274 88.0416 83.799 L 97.9411 93.6985 " }
                }
                ShapePath {
                    id: _qt_node9_fill_stroke
                    strokeColor: "transparent"
                    fillColor: "#fff8af18"
                    fillRule: ShapePath.WindingFill
                    PathSvg { path: "M 61 95 C 61 93.3431 62.3431 92 64 92 C 65.6568 92 67 93.3431 67 95 L 67 109 C 67 110.657 65.6568 112 64 112 C 62.3431 112 61 110.657 61 109 L 61 95 " }
                }
                ShapePath {
                    id: _qt_node10_fill_stroke
                    strokeColor: "transparent"
                    fillColor: "#fff8af18"
                    fillRule: ShapePath.WindingFill
                    PathSvg { path: "M 39.9584 83.799 C 41.1299 82.6274 43.0294 82.6274 44.201 83.799 C 45.3726 84.9706 45.3726 86.8701 44.201 88.0416 L 34.3015 97.9411 C 33.1299 99.1127 31.2304 99.1127 30.0589 97.9411 C 28.8873 96.7696 28.8873 94.87 30.0589 93.6985 L 39.9584 83.799 " }
                }
                ShapePath {
                    id: _qt_node11_fill_stroke
                    strokeColor: "transparent"
                    fillColor: "#fff8af18"
                    fillRule: ShapePath.WindingFill
                    PathSvg { path: "M 33 61 C 34.6569 61 36 62.3431 36 64 C 36 65.6568 34.6569 67 33 67 L 19 67 C 17.3431 67 16 65.6568 16 64 C 16 62.3431 17.3431 61 19 61 L 33 61 " }
                }
                ShapePath {
                    id: _qt_node12_fill_stroke
                    strokeColor: "transparent"
                    fillColor: "#fff8af18"
                    fillRule: ShapePath.WindingFill
                    PathSvg { path: "M 44.201 39.9584 C 45.3726 41.1299 45.3726 43.0294 44.201 44.201 C 43.0294 45.3726 41.1299 45.3726 39.9584 44.201 L 30.0589 34.3015 C 28.8873 33.1299 28.8873 31.2305 30.0589 30.0589 C 31.2305 28.8873 33.1299 28.8873 34.3015 30.0589 L 44.201 39.9584 " }
                }
            }
        }
    }
}
