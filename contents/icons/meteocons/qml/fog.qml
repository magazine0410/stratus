// Meteocons by Bas Milius, MIT License (see ../LICENSE). Generated from ../fog.svg by svgtoqml; do not edit, see ../README.md.
// Generated from SVG file fog.svg
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
        objectName: "fog"
        id: _qt_node1
        transformOrigin: Item.TopLeft
        Item { // Structure node
            objectName: "Sky"
            id: _qt_node2
            transformOrigin: Item.TopLeft
            Item { // Structure node
                objectName: "Clouds"
                id: _qt_node3
                transformOrigin: Item.TopLeft
                transform: TransformGroup {
                    id: _qt_node3_transform_base_group
                    TransformGroup {
                        id: _qt_node3_transform_group_0
                        Translate { id: _qt_node3_transform_0_0 }
                    }
                }
                Connections { target: _qt_node0.animations; function onRestart() {_qt_node3_transform_animation.restart() } }
                ParallelAnimation {
                    id:_qt_node3_transform_animation
                    loops: _qt_node0.animations.loops
                    paused: _qt_node0.animations.paused
                    running: true
                    onLoopsChanged: { if (running) { restart() } }
                    SequentialAnimation {
                        loops: Animation.Infinite
                        ScriptAction {
                            script: _qt_node3_transform_base_group.activateOverride(_qt_node3_transform_group_0)
                        }
                        ParallelAnimation {
                            SequentialAnimation {
                                ParallelAnimation {
                                    ScriptAction {
                                        script:_qt_node3_transform_0_0.x = 0
                                    }
                                    ScriptAction {
                                        script:_qt_node3_transform_0_0.y = 0
                                    }
                                }
                                ParallelAnimation {
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node3_transform_0_0
                                        property: "x"
                                        to: 0
                                    }
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node3_transform_0_0
                                        property: "y"
                                        to: -3
                                    }
                                }
                                ParallelAnimation {
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node3_transform_0_0
                                        property: "x"
                                        to: 0
                                    }
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node3_transform_0_0
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
                    id: _qt_node4
                    transformOrigin: Item.TopLeft
                    ShapePath {
                        id: _qt_node5_fill_stroke
                        objectName: "svg_path:Cloud_2"
                        strokeColor: "transparent"
                        fillColor: "#fff3f7fe"
                        fillRule: ShapePath.WindingFill
                        PathSvg { path: "M 90.3886 63.0856 C 92.6838 53.8819 87.7408 44.1357 79.0085 40.4822 C 70.2653 36.8242 59.8277 40.1375 54.8372 48.2115 C 50.5363 45.625 44.9752 45.7781 40.8239 48.5991 C 36.6832 51.4128 34.4996 56.5143 35.3499 61.4539 C 28.3926 62.7685 23.3934 69.3393 24.0614 76.4076 C 24.7297 83.4776 30.8718 89.0018 37.9534 89 C 55.6066 89 73.306 89 90.9767 89 C 98.0446 89 104 83.1189 104 76.0281 C 104 68.7015 97.6775 62.7674 90.3886 63.0856 " }
                    }
                }
            }
        }
        Item { // Structure node
            objectName: "Precipitation"
            id: _qt_node6
            transformOrigin: Item.TopLeft
            Shape {
                objectName: "Line2"
                id: _qt_node7
                transformOrigin: Item.TopLeft
                transform: TransformGroup {
                    id: _qt_node7_transform_base_group
                    TransformGroup {
                        id: _qt_node7_transform_group_0
                        Translate { id: _qt_node7_transform_0_0 }
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
                                        script:_qt_node7_transform_0_0.x = 0
                                    }
                                    ScriptAction {
                                        script:_qt_node7_transform_0_0.y = 0
                                    }
                                }
                                ParallelAnimation {
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node7_transform_0_0
                                        property: "x"
                                        to: 3
                                    }
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node7_transform_0_0
                                        property: "y"
                                        to: 0
                                    }
                                }
                                ParallelAnimation {
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node7_transform_0_0
                                        property: "x"
                                        to: 0
                                    }
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node7_transform_0_0
                                        property: "y"
                                        to: 0
                                    }
                                }
                            }
                        }
                    }
                }
                preferredRendererType: Shape.CurveRenderer
                ShapePath {
                    id: _qt_node7_fill_stroke
                    objectName: "svg_path:Line2"
                    strokeColor: "#ffe2e8f0"
                    strokeWidth: 3
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.MiterJoin
                    miterLimit: 10
                    fillColor: "#00000000"
                    fillRule: ShapePath.WindingFill
                    PathSvg { path: "M 40 95 L 88 95 " }
                }
            }
            Shape {
                objectName: "Line1"
                id: _qt_node8
                transformOrigin: Item.TopLeft
                transform: TransformGroup {
                    id: _qt_node8_transform_base_group
                    TransformGroup {
                        id: _qt_node8_transform_group_0
                        Translate { id: _qt_node8_transform_0_0 }
                    }
                }
                Connections { target: _qt_node0.animations; function onRestart() {_qt_node8_transform_animation.restart() } }
                ParallelAnimation {
                    id:_qt_node8_transform_animation
                    loops: _qt_node0.animations.loops
                    paused: _qt_node0.animations.paused
                    running: true
                    onLoopsChanged: { if (running) { restart() } }
                    SequentialAnimation {
                        PauseAnimation { duration: 200 }
                        loops: Animation.Infinite
                        ScriptAction {
                            script: _qt_node8_transform_base_group.activateOverride(_qt_node8_transform_group_0)
                        }
                        ParallelAnimation {
                            SequentialAnimation {
                                ParallelAnimation {
                                    ScriptAction {
                                        script:_qt_node8_transform_0_0.x = 0
                                    }
                                    ScriptAction {
                                        script:_qt_node8_transform_0_0.y = 0
                                    }
                                }
                                ParallelAnimation {
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node8_transform_0_0
                                        property: "x"
                                        to: 3
                                    }
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node8_transform_0_0
                                        property: "y"
                                        to: 0
                                    }
                                }
                                ParallelAnimation {
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node8_transform_0_0
                                        property: "x"
                                        to: 0
                                    }
                                    PropertyAnimation {
                                        duration: 1500
                                        target: _qt_node8_transform_0_0
                                        property: "y"
                                        to: 0
                                    }
                                }
                            }
                        }
                    }
                }
                preferredRendererType: Shape.CurveRenderer
                ShapePath {
                    id: _qt_node8_fill_stroke
                    objectName: "svg_path:Line1"
                    strokeColor: "#ffe2e8f0"
                    strokeWidth: 3
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.MiterJoin
                    miterLimit: 10
                    fillColor: "#00000000"
                    fillRule: ShapePath.WindingFill
                    PathSvg { path: "M 40 103 L 88 103 " }
                }
            }
        }
    }
}
