// Meteocons by Bas Milius, MIT License (see ../LICENSE). Generated from ../thunder.svg by svgtoqml; do not edit, see ../README.md.
// Generated from SVG file thunder.svg
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
        objectName: "thunderstorms"
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
                        PathSvg { path: "M 90.3887 63.0856 C 92.684 53.8819 87.741 44.1357 79.0087 40.4822 C 70.2654 36.8242 59.8278 40.1375 54.8373 48.2115 C 50.5364 45.625 44.9753 45.7781 40.824 48.5991 C 36.6833 51.4128 34.4998 56.5143 35.35 61.4539 C 28.3927 62.7685 23.3935 69.3393 24.0616 76.4076 C 24.7298 83.4776 30.872 89.0018 37.9535 89 C 55.6067 89 73.3061 89 90.9768 89 C 98.0447 89 104 83.1189 104 76.0281 C 104 68.7015 97.6776 62.7674 90.3887 63.0856 " }
                    }
                }
            }
        }
        Shape {
            preferredRendererType: Shape.CurveRenderer
            objectName: "Lightning"
            id: _qt_node6
            transformOrigin: Item.TopLeft
            ShapePath {
                id: _qt_node7_fill_stroke
                objectName: "svg_path:LightningBolt"
                strokeColor: "transparent"
                fillColor: "#fff6a823"
                fillRule: ShapePath.WindingFill
                PathSvg { path: "M 60.0003 68 L 52 90.9092 L 60.0003 90.9092 L 55.9995 110 L 76 83.2728 L 63.9996 83.2728 L 71.9999 68 L 60.0003 68 " }
            }
        }
    }
}
