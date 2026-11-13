// Meteocons by Bas Milius, MIT License (see ../LICENSE). Generated from ../overcast.svg by svgtoqml; do not edit, see ../README.md.
// Generated from SVG file overcast.svg
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
        objectName: "overcast"
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
                Item { // Structure node
                    objectName: "Maskgroup"
                    id: _qt_node4
                    transformOrigin: Item.TopLeft
                    transform: TransformGroup {
                        id: _qt_node4_transform_base_group
                        TransformGroup {
                            id: _qt_node4_transform_group_0
                            Translate { id: _qt_node4_transform_0_0 }
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
                                            script:_qt_node4_transform_0_0.x = 0
                                        }
                                        ScriptAction {
                                            script:_qt_node4_transform_0_0.y = 0
                                        }
                                    }
                                    ParallelAnimation {
                                        PropertyAnimation {
                                            duration: 1500
                                            target: _qt_node4_transform_0_0
                                            property: "x"
                                            to: 0
                                        }
                                        PropertyAnimation {
                                            duration: 1500
                                            target: _qt_node4_transform_0_0
                                            property: "y"
                                            to: -3
                                        }
                                    }
                                    ParallelAnimation {
                                        PropertyAnimation {
                                            duration: 1500
                                            target: _qt_node4_transform_0_0
                                            property: "x"
                                            to: 0
                                        }
                                        PropertyAnimation {
                                            duration: 1500
                                            target: _qt_node4_transform_0_0
                                            property: "y"
                                            to: 0
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Item { // Structure node
                        id: _qt_node5
                        transformOrigin: Item.TopLeft
                        Shape {
                            preferredRendererType: Shape.CurveRenderer
                            objectName: "SecondaryCloud"
                            id: _qt_node6
                            transformOrigin: Item.TopLeft
                            transform: TransformGroup {
                                id: _qt_node6_transform_base_group
                                TransformGroup {
                                    id: _qt_node6_transform_group_0
                                    Translate { id: _qt_node6_transform_0_0 }
                                }
                            }
                            Connections { target: _qt_node0.animations; function onRestart() {_qt_node6_transform_animation.restart() } }
                            ParallelAnimation {
                                id:_qt_node6_transform_animation
                                loops: _qt_node0.animations.loops
                                paused: _qt_node0.animations.paused
                                running: true
                                onLoopsChanged: { if (running) { restart() } }
                                SequentialAnimation {
                                    loops: Animation.Infinite
                                    ScriptAction {
                                        script: _qt_node6_transform_base_group.activateOverride(_qt_node6_transform_group_0)
                                    }
                                    ParallelAnimation {
                                        SequentialAnimation {
                                            ParallelAnimation {
                                                ScriptAction {
                                                    script:_qt_node6_transform_0_0.x = 0
                                                }
                                                ScriptAction {
                                                    script:_qt_node6_transform_0_0.y = -3
                                                }
                                            }
                                            ParallelAnimation {
                                                PropertyAnimation {
                                                    duration: 1500
                                                    target: _qt_node6_transform_0_0
                                                    property: "x"
                                                    to: 0
                                                }
                                                PropertyAnimation {
                                                    duration: 1500
                                                    target: _qt_node6_transform_0_0
                                                    property: "y"
                                                    to: 0
                                                }
                                            }
                                            ParallelAnimation {
                                                PropertyAnimation {
                                                    duration: 1500
                                                    target: _qt_node6_transform_0_0
                                                    property: "x"
                                                    to: 0
                                                }
                                                PropertyAnimation {
                                                    duration: 1500
                                                    target: _qt_node6_transform_0_0
                                                    property: "y"
                                                    to: -3
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            ShapePath {
                                id: _qt_node7_fill_stroke
                                objectName: "svg_path:Cloud"
                                strokeColor: "transparent"
                                fillColor: "#ffb0bccd"
                                fillRule: ShapePath.WindingFill
                                PathSvg { path: "M 101.194 55.5621 C 102.367 51.05 99.7602 46.4225 95.5043 44.7133 C 91.1919 42.9813 85.9612 44.4743 83.4186 48.423 C 81.2648 47.1797 78.496 47.2496 76.4119 48.609 C 74.3808 49.934 73.2434 52.372 73.675 54.7789 C 70.2998 55.3911 67.6874 58.4688 68.0307 61.9561 C 68.3748 65.4511 71.5394 68.0008 74.9767 68 C 83.8126 68 92.6514 67.9925 101.488 68 C 104.911 68 108 65.2849 108 61.774 C 108 58.1428 104.721 55.4142 101.194 55.5621 " }
                            }
                        }
                    }
                }
                Shape {
                    preferredRendererType: Shape.CurveRenderer
                    objectName: "Cloud_2"
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
                                            duration: 1500
                                            target: _qt_node8_transform_0_0
                                            property: "x"
                                            to: 0
                                        }
                                        PropertyAnimation {
                                            duration: 1500
                                            target: _qt_node8_transform_0_0
                                            property: "y"
                                            to: -3
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
                    ShapePath {
                        id: _qt_node9_fill_stroke
                        objectName: "svg_path:Cloud_3"
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
