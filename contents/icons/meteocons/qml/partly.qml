// Meteocons by Bas Milius, MIT License (see ../LICENSE). Generated from ../partly.svg by svgtoqml; do not edit, see ../README.md.
// Generated from SVG file partly.svg
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
        objectName: "partly-cloudy-day"
        id: _qt_node1
        transformOrigin: Item.TopLeft
        Item { // Structure node
            objectName: "Sky"
            id: _qt_node2
            transformOrigin: Item.TopLeft
            Item { // Structure node
                objectName: "Maskgroup"
                id: _qt_node3
                transformOrigin: Item.TopLeft
                Item { // Structure node
                    id: _qt_node4
                    transformOrigin: Item.TopLeft
                    Item { // Structure node
                        objectName: "Sun"
                        id: _qt_node5
                        transformOrigin: Item.TopLeft
                        Shape {
                            objectName: "Core"
                            id: _qt_node6
                            transformOrigin: Item.TopLeft
                            preferredRendererType: Shape.CurveRenderer
                            ShapePath {
                                id: _qt_node6_fill_stroke
                                objectName: "svg_path:Core"
                                strokeColor: "transparent"
                                fillColor: "#fff8af18"
                                fillRule: ShapePath.WindingFill
                                PathSvg { path: "M 48 51 C 48 55.9706 43.9706 60 39 60 C 34.0294 60 30 55.9706 30 51 C 30 46.0294 34.0294 42 39 42 C 43.9706 42 48 46.0294 48 51 " }
                            }
                        }
                        Shape {
                            preferredRendererType: Shape.CurveRenderer
                            objectName: "Rays"
                            id: _qt_node7
                            transformOrigin: Item.TopLeft
                            transform: TransformGroup {
                                id: _qt_node7_transform_base_group
                                TransformGroup {
                                    id: _qt_node7_transform_group_0
                                    Rotation { id: _qt_node7_transform_0_0 }
                                }
                            }
                            Connections { target: _qt_node0.animations; function onRestart() {_qt_node7_transform_animation.restart() } }
                            ParallelAnimation {
                                id:_qt_node7_transform_animation
                                loops: _qt_node0.animations.loops
                                paused: _qt_node0.animations.paused
                                running: true
                                onLoopsChanged: { if (running) { restart() } }
                                SequentialAnimation {
                                    loops: Animation.Infinite
                                    ScriptAction {
                                        script: _qt_node7_transform_base_group.activateOverride(_qt_node7_transform_group_0)
                                    }
                                    ParallelAnimation {
                                        SequentialAnimation {
                                            ParallelAnimation {
                                                ScriptAction {
                                                    script:_qt_node7_transform_0_0.origin = Qt.vector3d(39, 51, 0)
                                                }
                                                ScriptAction {
                                                    script:_qt_node7_transform_0_0.angle = 0
                                                }
                                            }
                                            ParallelAnimation {
                                                PropertyAnimation {
                                                    duration: 6000
                                                    target: _qt_node7_transform_0_0
                                                    property: "origin"
                                                    to: Qt.vector3d(39, 51, 0)
                                                }
                                                PropertyAnimation {
                                                    duration: 6000
                                                    target: _qt_node7_transform_0_0
                                                    property: "angle"
                                                    to: 360
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            ShapePath {
                                id: _qt_node8_fill_stroke
                                strokeColor: "transparent"
                                fillColor: "#fff8af18"
                                fillRule: ShapePath.WindingFill
                                PathSvg { path: "M 37.6875 31.3125 C 37.6875 30.5876 38.2751 30 39 30 C 39.7249 30 40.3125 30.5876 40.3125 31.3125 L 40.3125 37.4375 C 40.3125 38.1624 39.7249 38.75 39 38.75 C 38.2751 38.75 37.6875 38.1624 37.6875 37.4375 L 37.6875 31.3125 " }
                            }
                            ShapePath {
                                id: _qt_node9_fill_stroke
                                strokeColor: "transparent"
                                fillColor: "#fff8af18"
                                fillRule: ShapePath.WindingFill
                                PathSvg { path: "M 51.9931 36.1508 C 52.5056 35.6382 53.3367 35.6382 53.8492 36.1508 C 54.3618 36.6633 54.3618 37.4943 53.8492 38.0069 L 49.5182 42.3379 C 49.0056 42.8505 48.1746 42.8505 47.6621 42.3379 C 47.1495 41.8254 47.1495 40.9944 47.6621 40.4818 L 51.9931 36.1508 " }
                            }
                            ShapePath {
                                id: _qt_node10_fill_stroke
                                strokeColor: "transparent"
                                fillColor: "#fff8af18"
                                fillRule: ShapePath.WindingFill
                                PathSvg { path: "M 58.6875 49.6875 C 59.4124 49.6875 60 50.2751 60 51 C 60 51.7249 59.4124 52.3125 58.6875 52.3125 L 52.5625 52.3125 C 51.8376 52.3125 51.25 51.7249 51.25 51 C 51.25 50.2751 51.8376 49.6875 52.5625 49.6875 L 58.6875 49.6875 " }
                            }
                            ShapePath {
                                id: _qt_node11_fill_stroke
                                strokeColor: "transparent"
                                fillColor: "#fff8af18"
                                fillRule: ShapePath.WindingFill
                                PathSvg { path: "M 53.8492 63.9931 C 54.3618 64.5057 54.3618 65.3367 53.8492 65.8492 C 53.3367 66.3618 52.5056 66.3618 51.9931 65.8492 L 47.6621 61.5182 C 47.1495 61.0057 47.1495 60.1746 47.6621 59.6621 C 48.1746 59.1495 49.0057 59.1495 49.5182 59.6621 L 53.8492 63.9931 " }
                            }
                            ShapePath {
                                id: _qt_node12_fill_stroke
                                strokeColor: "transparent"
                                fillColor: "#fff8af18"
                                fillRule: ShapePath.WindingFill
                                PathSvg { path: "M 37.6875 64.5625 C 37.6875 63.8376 38.2751 63.25 39 63.25 C 39.7249 63.25 40.3125 63.8376 40.3125 64.5625 L 40.3125 70.6875 C 40.3125 71.4124 39.7249 72 39 72 C 38.2751 72 37.6875 71.4124 37.6875 70.6875 L 37.6875 64.5625 " }
                            }
                            ShapePath {
                                id: _qt_node13_fill_stroke
                                strokeColor: "transparent"
                                fillColor: "#fff8af18"
                                fillRule: ShapePath.WindingFill
                                PathSvg { path: "M 28.4818 59.6621 C 28.9943 59.1495 29.8254 59.1495 30.3379 59.6621 C 30.8505 60.1746 30.8505 61.0056 30.3379 61.5182 L 26.0069 65.8492 C 25.4943 66.3618 24.6633 66.3618 24.1508 65.8492 C 23.6382 65.3367 23.6382 64.5056 24.1508 63.9931 L 28.4818 59.6621 " }
                            }
                            ShapePath {
                                id: _qt_node14_fill_stroke
                                strokeColor: "transparent"
                                fillColor: "#fff8af18"
                                fillRule: ShapePath.WindingFill
                                PathSvg { path: "M 25.4375 49.6875 C 26.1624 49.6875 26.75 50.2751 26.75 51 C 26.75 51.7249 26.1624 52.3125 25.4375 52.3125 L 19.3125 52.3125 C 18.5876 52.3125 18 51.7249 18 51 C 18 50.2751 18.5876 49.6875 19.3125 49.6875 L 25.4375 49.6875 " }
                            }
                            ShapePath {
                                id: _qt_node15_fill_stroke
                                strokeColor: "transparent"
                                fillColor: "#fff8af18"
                                fillRule: ShapePath.WindingFill
                                PathSvg { path: "M 30.3379 40.4818 C 30.8505 40.9944 30.8505 41.8254 30.3379 42.3379 C 29.8254 42.8505 28.9944 42.8505 28.4818 42.3379 L 24.1508 38.0069 C 23.6382 37.4944 23.6382 36.6633 24.1508 36.1508 C 24.6633 35.6382 25.4944 35.6382 26.0069 36.1508 L 30.3379 40.4818 " }
                            }
                        }
                    }
                }
            }
            Item { // Structure node
                objectName: "Clouds"
                id: _qt_node16
                transformOrigin: Item.TopLeft
                transform: TransformGroup {
                    id: _qt_node16_transform_base_group
                    TransformGroup {
                        id: _qt_node16_transform_group_0
                        Translate { id: _qt_node16_transform_0_0 }
                    }
                }
                Connections { target: _qt_node0.animations; function onRestart() {_qt_node16_transform_animation.restart() } }
                ParallelAnimation {
                    id:_qt_node16_transform_animation
                    loops: _qt_node0.animations.loops
                    paused: _qt_node0.animations.paused
                    running: true
                    onLoopsChanged: { if (running) { restart() } }
                    SequentialAnimation {
                        loops: Animation.Infinite
                        ScriptAction {
                            script: _qt_node16_transform_base_group.activateOverride(_qt_node16_transform_group_0)
                        }
                        ParallelAnimation {
                            SequentialAnimation {
                                ParallelAnimation {
                                    ScriptAction {
                                        script:_qt_node16_transform_0_0.x = 0
                                    }
                                    ScriptAction {
                                        script:_qt_node16_transform_0_0.y = 0
                                    }
                                }
                                ParallelAnimation {
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node16_transform_0_0
                                        property: "x"
                                        to: 0
                                    }
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node16_transform_0_0
                                        property: "y"
                                        to: -3
                                    }
                                }
                                ParallelAnimation {
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node16_transform_0_0
                                        property: "x"
                                        to: 0
                                    }
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node16_transform_0_0
                                        property: "y"
                                        to: 0
                                    }
                                }
                            }
                        }
                    }
                }
                Shape {
                    preferredRendererType: Shape.CurveRenderer
                    objectName: "Cloud"
                    id: _qt_node17
                    transformOrigin: Item.TopLeft
                    ShapePath {
                        id: _qt_node18_fill_stroke
                        objectName: "svg_path:Cloud_2"
                        strokeColor: "transparent"
                        fillColor: "#fff3f7fe"
                        fillRule: ShapePath.WindingFill
                        PathSvg { path: "M 90.3886 63.0856 C 92.6838 53.8819 87.7408 44.1357 79.0085 40.4822 C 70.2653 36.8242 59.8277 40.1375 54.8372 48.2115 C 50.5363 45.625 44.9752 45.7781 40.8239 48.5991 C 36.6832 51.4128 34.4996 56.5143 35.3499 61.4539 C 28.3926 62.7685 23.3934 69.3393 24.0614 76.4076 C 24.7297 83.4776 30.8718 89.0018 37.9534 89 C 55.6066 89 73.306 89 90.9767 89 C 98.0446 89 104 83.1189 104 76.0281 C 104 68.7015 97.6775 62.7674 90.3886 63.0856 " }
                    }
                }
            }
        }
    }
}
