// Meteocons by Bas Milius, MIT License (see ../LICENSE). Generated from ../freezing.svg by svgtoqml; do not edit, see ../README.md.
// Generated from SVG file freezing.svg
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
        objectName: "hail"
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
            Item { // Structure node
                objectName: "Iceballs"
                id: _qt_node7
                transformOrigin: Item.TopLeft
                Shape {
                    objectName: "IceBall1"
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
                                            duration: 1000
                                            target: _qt_node8_transform_0_0
                                            property: "x"
                                            to: 0
                                        }
                                        PropertyAnimation {
                                            duration: 1000
                                            target: _qt_node8_transform_0_0
                                            property: "y"
                                            to: 20
                                        }
                                    }
                                }
                            }
                        }
                    }
                    preferredRendererType: Shape.CurveRenderer
                    ShapePath {
                        id: _qt_node8_fill_stroke
                        objectName: "svg_path:IceBall1"
                        strokeColor: "transparent"
                        fillColor: "#ff86c3db"
                        fillRule: ShapePath.WindingFill
                        PathSvg { path: "M 52 86 C 51.4067 86 50.8266 86.1759 50.3333 86.5056 C 49.8399 86.8352 49.4554 87.3038 49.2283 87.852 C 49.0013 88.4001 48.9419 89.0033 49.0577 89.5853 C 49.1734 90.1672 49.4591 90.7018 49.8787 91.1213 C 50.2983 91.5409 50.8329 91.8266 51.4148 91.9424 C 51.9968 92.0581 52.5998 91.9987 53.148 91.7716 C 53.6961 91.5446 54.1647 91.1601 54.4944 90.6667 C 54.824 90.1734 55 89.5933 55 89 C 55 88.2044 54.6839 87.4413 54.1213 86.8787 C 53.5587 86.3161 52.7957 86 52 86 " }
                    }
                }
                Shape {
                    objectName: "IceBall2"
                    id: _qt_node9
                    transformOrigin: Item.TopLeft
                    transform: TransformGroup {
                        id: _qt_node9_transform_base_group
                        TransformGroup {
                            id: _qt_node9_transform_group_0
                            Translate { id: _qt_node9_transform_0_0 }
                        }
                    }
                    Connections { target: _qt_node0.animations; function onRestart() {_qt_node9_transform_animation.restart() } }
                    ParallelAnimation {
                        id:_qt_node9_transform_animation
                        loops: _qt_node0.animations.loops
                        paused: _qt_node0.animations.paused
                        running: true
                        onLoopsChanged: { if (running) { restart() } }
                        SequentialAnimation {
                            PauseAnimation { duration: 300 }
                            loops: Animation.Infinite
                            ScriptAction {
                                script: _qt_node9_transform_base_group.activateOverride(_qt_node9_transform_group_0)
                            }
                            ParallelAnimation {
                                SequentialAnimation {
                                    ParallelAnimation {
                                        ScriptAction {
                                            script:_qt_node9_transform_0_0.x = 0
                                        }
                                        ScriptAction {
                                            script:_qt_node9_transform_0_0.y = 0
                                        }
                                    }
                                    ParallelAnimation {
                                        PropertyAnimation {
                                            duration: 1000
                                            target: _qt_node9_transform_0_0
                                            property: "x"
                                            to: 0
                                        }
                                        PropertyAnimation {
                                            duration: 1000
                                            target: _qt_node9_transform_0_0
                                            property: "y"
                                            to: 20
                                        }
                                    }
                                }
                            }
                        }
                    }
                    preferredRendererType: Shape.CurveRenderer
                    ShapePath {
                        id: _qt_node9_fill_stroke
                        objectName: "svg_path:IceBall2"
                        strokeColor: "transparent"
                        fillColor: "#ff86c3db"
                        fillRule: ShapePath.WindingFill
                        PathSvg { path: "M 64 86 C 63.4067 86 62.8266 86.1759 62.3333 86.5056 C 61.8399 86.8352 61.4554 87.3038 61.2283 87.852 C 61.0013 88.4001 60.9419 89.0033 61.0577 89.5853 C 61.1734 90.1672 61.4591 90.7018 61.8787 91.1213 C 62.2983 91.5409 62.8329 91.8266 63.4148 91.9424 C 63.9968 92.0581 64.5998 91.9987 65.148 91.7716 C 65.6961 91.5446 66.1647 91.1601 66.4944 90.6667 C 66.824 90.1734 67 89.5933 67 89 C 67 88.2044 66.6839 87.4413 66.1213 86.8787 C 65.5587 86.3161 64.7957 86 64 86 " }
                    }
                }
                Shape {
                    objectName: "IceBall3"
                    id: _qt_node10
                    transformOrigin: Item.TopLeft
                    transform: TransformGroup {
                        id: _qt_node10_transform_base_group
                        TransformGroup {
                            id: _qt_node10_transform_group_0
                            Translate { id: _qt_node10_transform_0_0 }
                        }
                    }
                    Connections { target: _qt_node0.animations; function onRestart() {_qt_node10_transform_animation.restart() } }
                    ParallelAnimation {
                        id:_qt_node10_transform_animation
                        loops: _qt_node0.animations.loops
                        paused: _qt_node0.animations.paused
                        running: true
                        onLoopsChanged: { if (running) { restart() } }
                        SequentialAnimation {
                            PauseAnimation { duration: 600 }
                            loops: Animation.Infinite
                            ScriptAction {
                                script: _qt_node10_transform_base_group.activateOverride(_qt_node10_transform_group_0)
                            }
                            ParallelAnimation {
                                SequentialAnimation {
                                    ParallelAnimation {
                                        ScriptAction {
                                            script:_qt_node10_transform_0_0.x = 0
                                        }
                                        ScriptAction {
                                            script:_qt_node10_transform_0_0.y = 0
                                        }
                                    }
                                    ParallelAnimation {
                                        PropertyAnimation {
                                            duration: 1000
                                            target: _qt_node10_transform_0_0
                                            property: "x"
                                            to: 0
                                        }
                                        PropertyAnimation {
                                            duration: 1000
                                            target: _qt_node10_transform_0_0
                                            property: "y"
                                            to: 20
                                        }
                                    }
                                }
                            }
                        }
                    }
                    preferredRendererType: Shape.CurveRenderer
                    ShapePath {
                        id: _qt_node10_fill_stroke
                        objectName: "svg_path:IceBall3"
                        strokeColor: "transparent"
                        fillColor: "#ff86c3db"
                        fillRule: ShapePath.WindingFill
                        PathSvg { path: "M 76 86 C 75.4067 86 74.8266 86.1759 74.3333 86.5056 C 73.8399 86.8352 73.4554 87.3038 73.2283 87.852 C 73.0013 88.4001 72.9419 89.0033 73.0577 89.5853 C 73.1734 90.1672 73.4591 90.7018 73.8787 91.1213 C 74.2983 91.5409 74.8329 91.8266 75.4148 91.9424 C 75.9968 92.0581 76.5998 91.9987 77.148 91.7716 C 77.6961 91.5446 78.1647 91.1601 78.4944 90.6667 C 78.824 90.1734 79 89.5933 79 89 C 79 88.2044 78.6839 87.4413 78.1213 86.8787 C 77.5587 86.3161 76.7957 86 76 86 " }
                    }
                }
            }
        }
    }
}
