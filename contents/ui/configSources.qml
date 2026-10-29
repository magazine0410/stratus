import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

QQC2.ScrollView {
    id: sourcesPage

    property string cfg_weatherSource
    property string cfg_locationName
    property string cfg_locationCountry
    property double cfg_locationLatitude
    property double cfg_locationLongitude

    property var results: []

    ColumnLayout {
        width: Math.max(sourcesPage.width - Kirigami.Units.largeSpacing * 2, implicitWidth)
        spacing: Kirigami.Units.smallSpacing

        Kirigami.Heading {
            level: 2
            text: "Weather source"
        }

        QQC2.ComboBox {
            id: sourceCombo
            Layout.fillWidth: true
            textRole: "text"
            valueRole: "value"
            model: [
                { value: "openmeteo", text: "Open-Meteo" },
                { value: "fmi", text: "Ilmatieteen laitos (FMI)" },
                { value: "both", text: "Both (FMI: 24 h and 3 days, Open-Meteo: 7 days)" }
            ]
            Component.onCompleted: currentIndex = indexOfValue(cfg_weatherSource)
            onActivated: cfg_weatherSource = currentValue
        }

        QQC2.Label {
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            color: Kirigami.Theme.disabledTextColor
            visible: cfg_weatherSource === "fmi"
            text: "Note: FMI open data does not give 7-day forecasts. The 7-day view is not available when only FMI is selected. Select \"Both\" to get 7-day forecasts from Open-Meteo."
        }

        Kirigami.Separator {
            Layout.fillWidth: true
            Layout.topMargin: Kirigami.Units.smallSpacing
            Layout.bottomMargin: Kirigami.Units.smallSpacing
        }

        Kirigami.Heading {
            level: 2
            text: "Location"
        }

        QQC2.Label {
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            text: "Current location: " + cfg_locationName
                + (cfg_locationCountry !== "" ? ", " + cfg_locationCountry : "")
                + " (" + cfg_locationLatitude + ", " + cfg_locationLongitude + ")"
        }

        RowLayout {
            Layout.fillWidth: true

            QQC2.TextField {
                id: searchField
                Layout.fillWidth: true
                placeholderText: "Type a place name..."
                onAccepted: doSearch()
            }

            QQC2.Button {
                text: "Search"
                enabled: searchField.text.length > 1 && !searchBusyIndicator.visible
                onClicked: doSearch()
            }
        }

        QQC2.BusyIndicator {
            id: searchBusyIndicator
            visible: false
            running: visible
            implicitWidth: Kirigami.Units.iconSizes.small
            implicitHeight: Kirigami.Units.iconSizes.small
            Layout.alignment: Qt.AlignHCenter
        }

        QQC2.Label {
            id: searchStatus
            visible: false
            color: Kirigami.Theme.disabledTextColor
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }

        ListView {
            id: resultList
            Layout.fillWidth: true
            Layout.preferredHeight: Math.min(count, 6) * 34 + 6
            visible: count > 0
            clip: true
            model: sourcesPage.results

            delegate: QQC2.ItemDelegate {
                width: ListView.view.width
                height: 34

                contentItem: ColumnLayout {
                    spacing: 0
                    Text {
                        text: modelData.name + (modelData.admin1 ? ", " + modelData.admin1 : "") + ", " + modelData.country
                        color: Kirigami.Theme.textColor
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                    Text {
                        text: modelData.latitude.toFixed(3) + ", " + modelData.longitude.toFixed(3)
                        color: Kirigami.Theme.disabledTextColor
                        font.pixelSize: Kirigami.Theme.smallFont.pixelSize
                    }
                }

                onClicked: {
                    cfg_locationName = modelData.name;
                    /* Some places have no country in the search reply. */
                    cfg_locationCountry = modelData.country ? modelData.country : "";
                    cfg_locationLatitude = modelData.latitude;
                    cfg_locationLongitude = modelData.longitude;
                    searchStatus.text = "Location set to " + modelData.name
                        + (modelData.country ? ", " + modelData.country : "") + ".";
                    searchStatus.visible = true;
                }
            }
        }
    }

    function doSearch() {
        searchBusyIndicator.visible = true;
        searchStatus.visible = false;
        resultList.visible = false;
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState !== XMLHttpRequest.DONE) return;
            searchBusyIndicator.visible = false;
            if (xhr.status !== 200) {
                searchStatus.text = "Search failed (HTTP " + xhr.status + ")";
                searchStatus.visible = true;
                return;
            }
            try {
                var j = JSON.parse(xhr.responseText);
                if (!j.results || j.results.length === 0) {
                    results = [];
                    searchStatus.text = "No places found.";
                    searchStatus.visible = true;
                    return;
                }
                results = j.results;
                resultList.visible = true;
            } catch (e) {
                searchStatus.text = "Search reply could not be read.";
                searchStatus.visible = true;
            }
        };
        xhr.open("GET", "https://geocoding-api.open-meteo.com/v1/search?name="
            + encodeURIComponent(searchField.text) + "&count=10&language=en&format=json");
        xhr.send();
    }
}
