import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: generalPage

    property alias cfg_showRainProbability: rainBox.checked
    property alias cfg_showWind: windBox.checked
    property string cfg_iconAnimation
    property string cfg_backgroundStyle
    property alias cfg_autoScrollHour: autoScrollBox.checked

    QQC2.CheckBox {
        id: rainBox
        Kirigami.FormData.label: "Details"
        text: "Show rain probability"
    }

    QQC2.CheckBox {
        id: windBox
        text: "Show wind speed"
    }

    QQC2.CheckBox {
        id: autoScrollBox
        Kirigami.FormData.label: "Hourly view"
        text: "Move to the current hour automatically"
    }

    QQC2.ComboBox {
        id: animationCombo
        Kirigami.FormData.label: "Animation"
        textRole: "text"
        valueRole: "value"
        model: [
            { value: "static", text: "Do not animate" },
            { value: "hover", text: "Animate when the pointer is on the widget" },
            { value: "always", text: "Animate always" }
        ]
        Component.onCompleted: currentIndex = indexOfValue(generalPage.cfg_iconAnimation)
        onActivated: generalPage.cfg_iconAnimation = currentValue
    }

    QQC2.Label {
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        color: Kirigami.Theme.disabledTextColor
        text: "Symbols and a background that move all the time use more power."
        visible: generalPage.cfg_iconAnimation === "always"
    }

    QQC2.ComboBox {
        id: backgroundCombo
        Kirigami.FormData.label: "Background"
        textRole: "text"
        valueRole: "value"
        model: [
            { value: "dark", text: "Near-black" },
            { value: "theme", text: "Plasma theme" }
        ]
        Component.onCompleted: currentIndex = indexOfValue(generalPage.cfg_backgroundStyle)
        onActivated: generalPage.cfg_backgroundStyle = currentValue
    }

    QQC2.Label {
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        color: Kirigami.Theme.disabledTextColor
        text: "A near-black background gives more contrast to the rain and snow in the symbols."
        visible: generalPage.cfg_backgroundStyle === "dark"
    }
}
