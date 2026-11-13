// Meteocons by Bas Milius, MIT License (see ../LICENSE). Generated from ../sleet.svg by svgtoqml; do not edit, see ../README.md.
// Generated from SVG file sleet.svg
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
        objectName: "sleet"
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
                objectName: "Snowflakes"
                id: _qt_node7
                transformOrigin: Item.TopLeft
                Shape {
                    objectName: "Snowflake1"
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
                        objectName: "svg_path:Snowflake1"
                        strokeColor: "transparent"
                        fillColor: "#ff86c3db"
                        fillRule: ShapePath.WindingFill
                        PathSvg { path: "M 52.5781 90.366 L 51.3735 89.6775 C 51.4794 89.2326 51.4786 88.7687 51.3708 88.3241 L 52.5781 87.6345 C 52.6738 87.5805 52.7577 87.5079 52.8252 87.421 C 52.8926 87.3342 52.9423 87.2347 52.9711 87.1284 C 52.9998 87.0221 53.0071 86.9112 52.9926 86.802 C 52.9782 86.6928 52.9422 86.5876 52.8868 86.4926 C 52.7732 86.2998 52.5886 86.1597 52.3728 86.1025 C 52.157 86.0452 51.9276 86.0754 51.7339 86.1866 L 50.5278 86.8763 C 50.1931 86.5586 49.7868 86.3264 49.3437 86.1995 L 49.3437 84.8202 C 49.3368 84.6003 49.245 84.3918 49.0875 84.2387 C 48.93 84.0856 48.7192 84 48.4998 84 C 48.2805 84 48.0699 84.0856 47.9124 84.2387 C 47.7548 84.3918 47.6628 84.6003 47.656 84.8202 L 47.656 86.1995 C 47.214 86.3289 46.8081 86.5598 46.4706 86.874 L 45.2662 86.1853 C 45.0724 86.0742 44.8428 86.044 44.627 86.1013 C 44.4113 86.1585 44.2267 86.2986 44.113 86.4913 C 44.0576 86.5864 44.0217 86.6916 44.0072 86.8007 C 43.9928 86.9099 44 87.0209 44.0288 87.1271 C 44.0575 87.2334 44.1072 87.3329 44.1747 87.4198 C 44.2421 87.5067 44.326 87.5792 44.4217 87.6332 L 45.6264 88.3216 C 45.5204 88.7666 45.5213 89.2305 45.629 89.675 L 44.4217 90.3647 C 44.326 90.4187 44.2421 90.4912 44.1747 90.5781 C 44.1072 90.665 44.0575 90.7645 44.0288 90.8708 C 44 90.9771 43.9928 91.088 44.0072 91.1972 C 44.0217 91.3063 44.0576 91.4115 44.113 91.5066 C 44.2267 91.6992 44.4113 91.8392 44.627 91.8965 C 44.8428 91.9537 45.0724 91.9236 45.2662 91.8126 L 46.4721 91.1229 C 46.8063 91.4409 47.2128 91.6726 47.6562 91.7979 L 47.6562 93.1798 C 47.6631 93.3997 47.755 93.6082 47.9126 93.7613 C 48.0701 93.9144 48.2807 94 48.5 94 C 48.7194 94 48.9302 93.9144 49.0877 93.7613 C 49.2452 93.6082 49.337 93.3997 49.3439 93.1798 L 49.3439 91.7975 C 49.7853 91.6683 50.1907 91.4378 50.5278 91.1242 L 51.7341 91.8138 C 51.9278 91.9248 52.1573 91.955 52.373 91.8977 C 52.5888 91.8405 52.7733 91.7005 52.887 91.5079 C 52.9424 91.4128 52.9784 91.3076 52.9928 91.1984 C 53.0073 91.0892 52.9998 90.9783 52.9711 90.872 C 52.9423 90.7657 52.8929 90.6662 52.8254 90.5793 C 52.7579 90.4925 52.6738 90.4199 52.5781 90.366 M 47.8664 90.0861 C 47.7229 90.005 47.5968 89.8961 47.4956 89.7657 C 47.3944 89.6353 47.3202 89.486 47.2771 89.3266 C 47.2339 89.1671 47.2228 89.0007 47.2443 88.8369 C 47.2658 88.6731 47.3197 88.5152 47.4026 88.3724 C 47.5735 88.084 47.8503 87.8743 48.1736 87.7883 C 48.497 87.7023 48.8411 87.747 49.1321 87.9126 C 49.2756 87.9938 49.4016 88.1027 49.5028 88.2331 C 49.604 88.3635 49.6782 88.5127 49.7214 88.6722 C 49.7645 88.8316 49.7757 88.9981 49.7541 89.1619 C 49.7326 89.3257 49.6787 89.4836 49.5958 89.6263 C 49.425 89.9149 49.1482 90.1247 48.8248 90.2108 C 48.5014 90.2969 48.1574 90.2523 47.8664 90.0867 L 47.8664 90.0861 " }
                    }
                }
                Shape {
                    objectName: "Snowflake2"
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
                            PauseAnimation { duration: 700 }
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
                        objectName: "svg_path:Snowflake2"
                        strokeColor: "transparent"
                        fillColor: "#ff86c3db"
                        fillRule: ShapePath.WindingFill
                        PathSvg { path: "M 67.5781 90.366 L 66.3735 89.6775 C 66.4794 89.2326 66.4786 88.7687 66.3708 88.3241 L 67.5781 87.6345 C 67.6738 87.5805 67.7577 87.5079 67.8252 87.421 C 67.8926 87.3342 67.9423 87.2347 67.9711 87.1284 C 67.9998 87.0221 68.0071 86.9112 67.9926 86.802 C 67.9782 86.6928 67.9422 86.5876 67.8868 86.4926 C 67.7732 86.2998 67.5886 86.1597 67.3728 86.1025 C 67.157 86.0452 66.9276 86.0754 66.7339 86.1866 L 65.5278 86.8763 C 65.1931 86.5586 64.7868 86.3264 64.3437 86.1995 L 64.3437 84.8202 C 64.3368 84.6003 64.245 84.3918 64.0875 84.2387 C 63.93 84.0856 63.7192 84 63.4998 84 C 63.2805 84 63.0699 84.0856 62.9124 84.2387 C 62.7548 84.3918 62.6628 84.6003 62.656 84.8202 L 62.656 86.1995 C 62.214 86.3289 61.8081 86.5598 61.4706 86.874 L 60.2662 86.1853 C 60.0724 86.0742 59.8428 86.044 59.627 86.1013 C 59.4113 86.1585 59.2267 86.2986 59.113 86.4913 C 59.0576 86.5864 59.0217 86.6916 59.0072 86.8007 C 58.9928 86.9099 59 87.0209 59.0288 87.1271 C 59.0575 87.2334 59.1072 87.3329 59.1747 87.4198 C 59.2421 87.5067 59.326 87.5792 59.4217 87.6332 L 60.6264 88.3216 C 60.5204 88.7666 60.5213 89.2305 60.629 89.675 L 59.4217 90.3647 C 59.326 90.4187 59.2421 90.4912 59.1747 90.5781 C 59.1072 90.665 59.0575 90.7645 59.0288 90.8708 C 59 90.9771 58.9928 91.088 59.0072 91.1972 C 59.0217 91.3063 59.0576 91.4115 59.113 91.5066 C 59.2267 91.6992 59.4113 91.8392 59.627 91.8965 C 59.8428 91.9537 60.0724 91.9236 60.2662 91.8126 L 61.4721 91.1229 C 61.8063 91.4409 62.2128 91.6726 62.6562 91.7979 L 62.6562 93.1798 C 62.6631 93.3997 62.755 93.6082 62.9126 93.7613 C 63.0701 93.9144 63.2807 94 63.5 94 C 63.7194 94 63.9302 93.9144 64.0877 93.7613 C 64.2452 93.6082 64.337 93.3997 64.3439 93.1798 L 64.3439 91.7975 C 64.7853 91.6683 65.1907 91.4378 65.5278 91.1242 L 66.7341 91.8138 C 66.9278 91.9248 67.1573 91.955 67.373 91.8977 C 67.5888 91.8405 67.7733 91.7005 67.887 91.5079 C 67.9424 91.4128 67.9784 91.3076 67.9928 91.1984 C 68.0073 91.0892 67.9998 90.9783 67.9711 90.872 C 67.9423 90.7657 67.8929 90.6662 67.8254 90.5793 C 67.7579 90.4925 67.6738 90.4199 67.5781 90.366 M 62.8664 90.0861 C 62.7229 90.005 62.5968 89.8961 62.4956 89.7657 C 62.3944 89.6353 62.3202 89.486 62.2771 89.3266 C 62.2339 89.1671 62.2228 89.0007 62.2443 88.8369 C 62.2658 88.6731 62.3197 88.5152 62.4026 88.3724 C 62.5735 88.084 62.8503 87.8743 63.1736 87.7883 C 63.497 87.7023 63.8411 87.747 64.1321 87.9126 C 64.2756 87.9938 64.4016 88.1027 64.5028 88.2331 C 64.604 88.3635 64.6782 88.5127 64.7214 88.6722 C 64.7645 88.8316 64.7757 88.9981 64.7541 89.1619 C 64.7326 89.3257 64.6787 89.4836 64.5958 89.6263 C 64.425 89.9149 64.1482 90.1247 63.8248 90.2108 C 63.5014 90.2969 63.1574 90.2523 62.8664 90.0867 L 62.8664 90.0861 " }
                    }
                }
                Shape {
                    objectName: "Snowflake3"
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
                            PauseAnimation { duration: 1200 }
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
                        objectName: "svg_path:Snowflake3"
                        strokeColor: "transparent"
                        fillColor: "#ff86c3db"
                        fillRule: ShapePath.WindingFill
                        PathSvg { path: "M 82.5781 90.366 L 81.3735 89.6775 C 81.4794 89.2326 81.4786 88.7687 81.3708 88.3241 L 82.5781 87.6345 C 82.6738 87.5805 82.7577 87.5079 82.8252 87.421 C 82.8926 87.3342 82.9423 87.2347 82.9711 87.1284 C 82.9998 87.0221 83.0071 86.9112 82.9926 86.802 C 82.9782 86.6928 82.9422 86.5876 82.8868 86.4926 C 82.7732 86.2998 82.5886 86.1597 82.3728 86.1025 C 82.157 86.0452 81.9276 86.0754 81.7339 86.1866 L 80.5278 86.8763 C 80.1931 86.5586 79.7868 86.3264 79.3437 86.1995 L 79.3437 84.8202 C 79.3368 84.6003 79.245 84.3918 79.0875 84.2387 C 78.93 84.0856 78.7192 84 78.4998 84 C 78.2805 84 78.0699 84.0856 77.9124 84.2387 C 77.7548 84.3918 77.6628 84.6003 77.656 84.8202 L 77.656 86.1995 C 77.214 86.3289 76.8081 86.5598 76.4706 86.874 L 75.2662 86.1853 C 75.0724 86.0742 74.8428 86.044 74.627 86.1013 C 74.4113 86.1585 74.2267 86.2986 74.113 86.4913 C 74.0576 86.5864 74.0217 86.6916 74.0072 86.8007 C 73.9928 86.9099 74 87.0209 74.0288 87.1271 C 74.0575 87.2334 74.1072 87.3329 74.1747 87.4198 C 74.2421 87.5067 74.326 87.5792 74.4217 87.6332 L 75.6264 88.3216 C 75.5204 88.7666 75.5213 89.2305 75.629 89.675 L 74.4217 90.3647 C 74.326 90.4187 74.2421 90.4912 74.1747 90.5781 C 74.1072 90.665 74.0575 90.7645 74.0288 90.8708 C 74 90.9771 73.9928 91.088 74.0072 91.1972 C 74.0217 91.3063 74.0576 91.4115 74.113 91.5066 C 74.2267 91.6992 74.4113 91.8392 74.627 91.8965 C 74.8428 91.9537 75.0724 91.9236 75.2662 91.8126 L 76.4721 91.1229 C 76.8063 91.4409 77.2128 91.6726 77.6562 91.7979 L 77.6562 93.1798 C 77.6631 93.3997 77.755 93.6082 77.9126 93.7613 C 78.0701 93.9144 78.2807 94 78.5 94 C 78.7194 94 78.9302 93.9144 79.0877 93.7613 C 79.2452 93.6082 79.337 93.3997 79.3439 93.1798 L 79.3439 91.7975 C 79.7853 91.6683 80.1907 91.4378 80.5278 91.1242 L 81.7341 91.8138 C 81.9278 91.9248 82.1573 91.955 82.373 91.8977 C 82.5888 91.8405 82.7733 91.7005 82.887 91.5079 C 82.9424 91.4128 82.9784 91.3076 82.9928 91.1984 C 83.0073 91.0892 82.9998 90.9783 82.9711 90.872 C 82.9423 90.7657 82.8929 90.6662 82.8254 90.5793 C 82.7579 90.4925 82.6738 90.4199 82.5781 90.366 M 77.8664 90.0861 C 77.7229 90.005 77.5968 89.8961 77.4956 89.7657 C 77.3944 89.6353 77.3202 89.486 77.2771 89.3266 C 77.2339 89.1671 77.2228 89.0007 77.2443 88.8369 C 77.2658 88.6731 77.3197 88.5152 77.4026 88.3724 C 77.5735 88.084 77.8503 87.8743 78.1736 87.7883 C 78.497 87.7023 78.8411 87.747 79.1321 87.9126 C 79.2756 87.9938 79.4016 88.1027 79.5028 88.2331 C 79.604 88.3635 79.6782 88.5127 79.7214 88.6722 C 79.7645 88.8316 79.7757 88.9981 79.7541 89.1619 C 79.7326 89.3257 79.6787 89.4836 79.5958 89.6263 C 79.425 89.9149 79.1482 90.1247 78.8248 90.2108 C 78.5014 90.2969 78.1574 90.2523 77.8664 90.0867 L 77.8664 90.0861 " }
                    }
                }
            }
            Item { // Structure node
                objectName: "Raindrops"
                id: _qt_node11
                transformOrigin: Item.TopLeft
                Shape {
                    objectName: "Raindrop1"
                    id: _qt_node12
                    transformOrigin: Item.TopLeft
                    transform: TransformGroup {
                        id: _qt_node12_transform_base_group
                        TransformGroup {
                            id: _qt_node12_transform_group_0
                            Translate { id: _qt_node12_transform_0_0 }
                        }
                    }
                    Connections { target: _qt_node0.animations; function onRestart() {_qt_node12_transform_animation.restart() } }
                    ParallelAnimation {
                        id:_qt_node12_transform_animation
                        loops: _qt_node0.animations.loops
                        paused: _qt_node0.animations.paused
                        running: true
                        onLoopsChanged: { if (running) { restart() } }
                        SequentialAnimation {
                            loops: Animation.Infinite
                            ScriptAction {
                                script: _qt_node12_transform_base_group.activateOverride(_qt_node12_transform_group_0)
                            }
                            ParallelAnimation {
                                SequentialAnimation {
                                    ParallelAnimation {
                                        ScriptAction {
                                            script:_qt_node12_transform_0_0.x = 0
                                        }
                                        ScriptAction {
                                            script:_qt_node12_transform_0_0.y = 0
                                        }
                                    }
                                    ParallelAnimation {
                                        PropertyAnimation {
                                            duration: 1000
                                            target: _qt_node12_transform_0_0
                                            property: "x"
                                            to: 0
                                        }
                                        PropertyAnimation {
                                            duration: 1000
                                            target: _qt_node12_transform_0_0
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
                        id: _qt_node12_fill_stroke
                        objectName: "svg_path:Raindrop1"
                        strokeColor: "#ff3d8bff"
                        strokeWidth: 4
                        capStyle: ShapePath.RoundCap
                        joinStyle: ShapePath.MiterJoin
                        miterLimit: 4
                        fillColor: "#00000000"
                        fillRule: ShapePath.WindingFill
                        PathSvg { path: "M 52 88 L 52 91 " }
                    }
                }
                Shape {
                    objectName: "Raindrop2"
                    id: _qt_node13
                    transformOrigin: Item.TopLeft
                    transform: TransformGroup {
                        id: _qt_node13_transform_base_group
                        TransformGroup {
                            id: _qt_node13_transform_group_0
                            Translate { id: _qt_node13_transform_0_0 }
                        }
                    }
                    Connections { target: _qt_node0.animations; function onRestart() {_qt_node13_transform_animation.restart() } }
                    ParallelAnimation {
                        id:_qt_node13_transform_animation
                        loops: _qt_node0.animations.loops
                        paused: _qt_node0.animations.paused
                        running: true
                        onLoopsChanged: { if (running) { restart() } }
                        SequentialAnimation {
                            PauseAnimation { duration: 400 }
                            loops: Animation.Infinite
                            ScriptAction {
                                script: _qt_node13_transform_base_group.activateOverride(_qt_node13_transform_group_0)
                            }
                            ParallelAnimation {
                                SequentialAnimation {
                                    ParallelAnimation {
                                        ScriptAction {
                                            script:_qt_node13_transform_0_0.x = 0
                                        }
                                        ScriptAction {
                                            script:_qt_node13_transform_0_0.y = 0
                                        }
                                    }
                                    ParallelAnimation {
                                        PropertyAnimation {
                                            duration: 1000
                                            target: _qt_node13_transform_0_0
                                            property: "x"
                                            to: 0
                                        }
                                        PropertyAnimation {
                                            duration: 1000
                                            target: _qt_node13_transform_0_0
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
                        id: _qt_node13_fill_stroke
                        objectName: "svg_path:Raindrop2"
                        strokeColor: "#ff3d8bff"
                        strokeWidth: 4
                        capStyle: ShapePath.RoundCap
                        joinStyle: ShapePath.MiterJoin
                        miterLimit: 4
                        fillColor: "#00000000"
                        fillRule: ShapePath.WindingFill
                        PathSvg { path: "M 64 88 L 64 91 " }
                    }
                }
                Shape {
                    objectName: "Raindrop3"
                    id: _qt_node14
                    transformOrigin: Item.TopLeft
                    transform: TransformGroup {
                        id: _qt_node14_transform_base_group
                        TransformGroup {
                            id: _qt_node14_transform_group_0
                            Translate { id: _qt_node14_transform_0_0 }
                        }
                    }
                    Connections { target: _qt_node0.animations; function onRestart() {_qt_node14_transform_animation.restart() } }
                    ParallelAnimation {
                        id:_qt_node14_transform_animation
                        loops: _qt_node0.animations.loops
                        paused: _qt_node0.animations.paused
                        running: true
                        onLoopsChanged: { if (running) { restart() } }
                        SequentialAnimation {
                            PauseAnimation { duration: 800 }
                            loops: Animation.Infinite
                            ScriptAction {
                                script: _qt_node14_transform_base_group.activateOverride(_qt_node14_transform_group_0)
                            }
                            ParallelAnimation {
                                SequentialAnimation {
                                    ParallelAnimation {
                                        ScriptAction {
                                            script:_qt_node14_transform_0_0.x = 0
                                        }
                                        ScriptAction {
                                            script:_qt_node14_transform_0_0.y = 0
                                        }
                                    }
                                    ParallelAnimation {
                                        PropertyAnimation {
                                            duration: 1000
                                            target: _qt_node14_transform_0_0
                                            property: "x"
                                            to: 0
                                        }
                                        PropertyAnimation {
                                            duration: 1000
                                            target: _qt_node14_transform_0_0
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
                        id: _qt_node14_fill_stroke
                        objectName: "svg_path:Raindrop3"
                        strokeColor: "#ff3d8bff"
                        strokeWidth: 4
                        capStyle: ShapePath.RoundCap
                        joinStyle: ShapePath.MiterJoin
                        miterLimit: 4
                        fillColor: "#00000000"
                        fillRule: ShapePath.WindingFill
                        PathSvg { path: "M 76 88 L 76 91 " }
                    }
                }
            }
        }
    }
}
