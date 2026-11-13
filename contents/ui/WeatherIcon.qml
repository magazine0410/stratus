import QtQuick
import org.kde.plasma.components as PC3

/* Weather symbol. "v" comes from Weather.vis() and gives the file name and the tool tip text.
   The symbols are animated SVG files (Meteocons, see ../icons/meteocons/README.md), made into
   QML files with svgtoqml (../icons/meteocons/qml/). VectorImage shows the same SVG files with
   the same look, but in Qt 6.11 it makes the process use more memory all the time while the
   animations run (about 0.6 MB per minute for each symbol, measured); the QML files do not. */
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

    Loader {
        id: image
        anchors.fill: parent
        source: icon.v ? Qt.resolvedUrl("../icons/meteocons/qml/" + icon.v.icon + ".qml") : ""
        /* The files are square (128 x 128) and scale themselves to their width and height. */
        onLoaded: {
            item.width = Qt.binding(() => image.width);
            item.height = Qt.binding(() => image.height);
            item.animations.loops = Animation.Infinite;
            item.animations.paused = Qt.binding(() => !icon.animating);
        }
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
