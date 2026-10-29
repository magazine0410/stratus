import QtQuick
import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
        name: "Source and location"
        icon: "weather-clear"
        source: "configSources.qml"
    }

    ConfigCategory {
        name: "Appearance"
        icon: "configure"
        source: "configGeneral.qml"
    }
}
