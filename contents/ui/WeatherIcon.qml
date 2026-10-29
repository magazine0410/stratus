import QtQuick
import QtQuick.VectorImage
import org.kde.plasma.components as PC3

/* Weather symbol. "v" comes from Weather.vis() and gives the file name and the tool tip text.
   The symbols are animated SVG files (Meteocons, see ../icons/meteocons/README.md).
   Qt 6.10 and later turn the SVG transform animations into Qt Quick animations. */
Item {
    id: icon

    property var v
    property real size: 32

    /* "static", "hover" or "always". */
    property string animationMode: "hover"

    readonly property bool animating: animationMode === "always"
        || (animationMode === "hover" && ma.containsMouse)

    implicitWidth: size
    implicitHeight: size

    VectorImage {
        id: image
        anchors.fill: parent
        source: icon.v ? Qt.resolvedUrl("../icons/meteocons/" + icon.v.icon + ".svg") : ""
        preferredRendererType: VectorImage.CurveRenderer
        fillMode: VectorImage.PreserveAspectFit
        animations.loops: Animation.Infinite
        animations.paused: !icon.animating
    }

    PC3.ToolTip.visible: ma.containsMouse && icon.v
    PC3.ToolTip.text: icon.v ? icon.v.name : ""
    PC3.ToolTip.delay: 300

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        /* Only the pointer position is wanted, for the tool tip and the animation. Clicks go
           through to what is under the symbol: in a day view that is the day, which opens
           the hourly forecast. */
        acceptedButtons: Qt.NoButton
    }
}
