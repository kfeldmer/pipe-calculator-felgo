import Felgo
import QtQuick
import QtQuick.Controls 2.0

App {
    id: app
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"

    property real outerDiameter
    property real wallThickness
    property real innerDiameter
    property string selectedUnit: "mm"
    property real originalOuterDiameter
    property real originalWallThickness
    property string innerDiameterString

    onInitTheme: {
        //katronic red
        Theme.navigationBar.backgroundColor = "#C1121C"
        Theme.appButton.backgroundColor = "#C1121C"
    }


    Navigation {

        NavigationItem {
            title: "Katronic"
            iconType: IconType.heart

            NavigationStack {

                AppPage {
                    title: qsTr("Pipe Calculator")

                    Column {
                        spacing: dp(10)
                        x: dp(50)
                        y: dp(10)

                        Text {
                            text: qsTr("Outer Diameter")
                            font.pixelSize: app.sp(15)
                        }

                        Row {
                            spacing: dp(5)

                            AppTextField {
                                id: outerDiameterInput
                                placeholderText: "0"
                                maximumLength: 10
                                height: dp(30)
                                width: dp(110)
                            }

                            Text {
                                text: selectedUnit
                                padding: dp(10)
                                font.pixelSize: app.sp(15)
                            }
                        }

                        Text {
                            text: qsTr("Wall Thickness")
                            font.pixelSize: app.sp(15)
                        }

                        Row {
                            spacing: dp(5)

                            AppTextField {
                                id: wallThicknessInput
                                placeholderText: "0"
                                maximumLength: 10
                                height: dp(30)
                                width: dp(110)
                            }

                            Text {
                                text: selectedUnit
                                padding: dp(10)
                                font.pixelSize: app.sp(15)
                            }
                        }

                        AppButton {
                            height: dp(30)
                            width: dp(100)
                            text: "Calculate"
                            onClicked: calculateInnerDiameter(outerDiameterInput, wallThicknessInput, innerDiameterText)
                        }

                        Text {
                            padding: dp(5)
                            id: innerDiameterText
                            font.pixelSize: app.sp(15)
                            font.bold: true
                        }

                    }

                    ComboBox {
                        x: dp(200)
                        y: dp(80)
                        height: dp(35)
                        width: dp(120)
                        id: unitComboBox
                        model: ["mm", "cm", "m", "inch"]
                        currentIndex: ["mm", "cm", "m", "inch"].indexOf(selectedUnit)
                        font.pixelSize: app.sp(15)

                        onCurrentIndexChanged: {
                            selectedUnit = model[currentIndex]
                            updateFields(outerDiameterInput, wallThicknessInput, innerDiameterText)
                        }
                    }

                    AppImage {
                        x: dp(40)
                        y: dp(210)

                        fillMode: Image.PreserveAspectFit
                    //    source: "data:image/png;base64,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"
                        source: "../assets/images/PipeDimensions.png"
                        height: dp(230)
                        width: dp(230)
                    }

                 /*   MultiResolutionImage {
                        x: dp(10)
                        y: dp(170)
                        fillMode: Image.PreserveAspectFit

                        source: Qt.resolvedUrl("../assets/images/PipeDimensions.png")
                        sourceSize.width: 1488
                        sourceSize.height: 780
                        height: dp(250)
                        width: dp(250)
                    } */
                }
            }
        }

        NavigationItem {
              title: "Second"
              iconType: IconType.thlarge

              NavigationStack {

                AppPage {
                  title: "Second Page"
                }
              }
        }
    }

    function calculateInnerDiameter(outerDiameterInput, wallThicknessInput, innerDiameterText) {
        // Parse user input or use placeholder values if empty
        outerDiameter = outerDiameterInput.text.trim() === "" ? parseFloat(outerDiameterInput.placeholderText) : parseFloat(outerDiameterInput.text);
        wallThickness = wallThicknessInput.text.trim() === "" ? parseFloat(wallThicknessInput.placeholderText) : parseFloat(wallThicknessInput.text);

        // Store original values in millimeters
        originalOuterDiameter = convertToMM(outerDiameter, selectedUnit);
        originalWallThickness = convertToMM(wallThickness, selectedUnit);

        // Inner diameter calculation logic
        innerDiameter = originalOuterDiameter - 2 * originalWallThickness;

        innerDiameterString = convertToUnit(innerDiameter, selectedUnit)

        // Ensure that innerDiameterString has a maximum of 10 total digits
        if (innerDiameterString.length > 10) {
            innerDiameterString = innerDiameterString.slice(0, 10);
        }

        // Update the inner diameter text
        innerDiameterText.text = "Inner Diameter = " + innerDiameterString + " " + selectedUnit;
    }

    function convertToMM(value, unit) {
        switch (unit) {
            case "cm": return value * 10;
            case "m": return value * 1000;
            case "inch": return value * 25.4;
            default: return value; // Default to mm
        }
    }

    function convertToUnit(value, toUnit) {
        switch (toUnit) {
            case "cm": return value / 10;
            case "m": return value / 1000;
            case "inch": return value / 25.4;
            default: return value; // Default to the same unit
        }
    }

    function updateFields(outerDiameterInput, wallThicknessInput, innerDiameterText) {

        // Only update if there's user input, otherwise keep the placeholder
        if (outerDiameterInput.text.trim() !== "") {
            outerDiameterInput.text = convertToUnit(originalOuterDiameter, selectedUnit);
        }

        if (wallThicknessInput.text.trim() !== "") {
            wallThicknessInput.text = convertToUnit(originalWallThickness, selectedUnit);
        }

        calculateInnerDiameter(outerDiameterInput, wallThicknessInput, innerDiameterText)
    }
}
