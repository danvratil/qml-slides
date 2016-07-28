import QtQuick 2.0
import QtQml 2.2
import Qt.labs.presentation 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1

PlasmaPresentation
{
    id: deck

    width: 1024
    height: 768
    property alias loadingSlide: loadingSlide

    fontFamily: "Montserrat"

    onCurrentSlideChanged: {
        if (deck.currentSlide > 0 && !slideBg.visible) {
            showSlideBgAnimation.running = true
        } else if (deck.currentSlide === 0) {
            hideSlideBgAnimation.running = true
        }
    }

    Image {
        id: bgImage
        anchors.fill: parent
        source: "../images/background.png"
        antialiasing: true
        fillMode: Image.PreserveAspectFit

        Rectangle {
            id: slideBg;

            anchors {
                centerIn: parent;
            }
            width: parent.width * 0.90
            height: parent.height * 0.90

            visible: false;

            color: "white"
            radius: 10

            SequentialAnimation {
                id: showSlideBgAnimation
                PropertyAction { target: slideBg; property: "opacity"; value: 0; }
                PropertyAction { target: slideBg; property: "visible"; value: true; }
                NumberAnimation {
                    target: slideBg; property: "opacity"; to: 0.8; duration: 500;
                }
            }
            SequentialAnimation {
                id: hideSlideBgAnimation
                NumberAnimation {
                    target: slideBg; property: "opacity"; to: 0; duration: 500;
                }
                PropertyAction { target: slideBg; property: "visible"; value: false; }
                PropertyAction { target: slideBg; property: "opacity"; value: 1; }
            }
        }
    }

    Slide {
        id: loadingSlide

        Image {
            id: kdeLogo

            anchors.centerIn: parent

            source: "../images/qt-logo.png"
            antialiasing: true
            fillMode: Image.PreserveAspectFit

            width: 200
        }

        SequentialAnimation {
            running: deck.currentSlide === 0
            loops: Animation.Infinite

            NumberAnimation {
                target: kdeLogo
                property: "scale"
                to: 1.5
                duration: 1000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: kdeLogo
                property: "scale"
                to: 0.5
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }

    }

    TextSlide {
        id: titleSlide;

        Item {
            height: childrenRect.height
            width: parent.width;
            anchors.centerIn: parent;

            SlideText {
                slide: titleSlide
                id: presentationTitle;
                text: "Rapid UI development\nwith QML"
                scale: 0.1
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
            }

            SlideText {
                slide: titleSlide
                text: "Daniel Vrátil"
                anchors {
                    topMargin: 50
                    horizontalCenter: parent.horizontalCenter;
                    top: presentationTitle.bottom;
                }
            }
        }
    }

    ImageSlide {
        image: "../images/hobbit.jpg"
    }

    TextSlide {
        centeredText: "Cross-platform\n" +
                      "open-source\n" +
                      "application\n" +
                      "framework"
    }

    TextSlide {
        SlideText {
            scale: 0.06
            horizontalAlignment: Text.AlignLeft
            anchors {
                margins: 50
                centerIn: parent;
            }
            lineHeight: lineHeight * 1.1

            text: "1995: Qt 0.9 by Trolltech\n" +
                  "1996: Qt 1.0\n" +
                  "1998: K Desktop Environment 1.0\n" +
                  "1999: Qt 2.0\n" +
                  "2001: Qt 3.0\n" +
                  "2005: Qt 4.0\n" +
                  "2008: Trolltech acquired by Nokia\n" +
                  "2010: Qt 4.7 with QML\n" +
                  "2012: Digia acquires Qt from Nokia\n" +
                  "2012: Qt 5.0\n" +
                  "...\n" +
                  "2015: Qt 5.5"
        }
    }

    TextSlide {
        SlideText {
            scale: 0.06
            horizontalAlignment: Text.AlignLeft
            anchors {
                margins: 50
                centerIn: parent
            }

            lineHeight: lineHeight * 1.3

            text: "Qt 0.9: FreeQt\n" +
                  "Qt 2.0: Q Public License\n" +
                  "Qt 2.2: GPLv2\n" +
                  "Qt 4.5: GPLv2, LGPLv2.1\n" +
                  "Qt 5.6: GPLv2, GPLv3, LGPLv3"
        }
    }

    TextSlide {
        SlideText {
            text: "Linux\n" +
                  "Windows\n" +
                  "OS X"
            width: parent.width * 0.4
            anchors {
                leftMargin: parent.width * 0.1
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
        }

        SlideText {
            text: "Android\n" +
                  "iOS\n" +
                  "Win RT\n" +
                  "QNX\n" +
                  "..."
            width: parent.width * 0.4
            anchors {
                rightMargin: parent.width * 0.1
                top: parent.top
                right: parent.right
                bottom: parent.bottom;
            }
        }
    }

    TextSlide {
        centeredText: "X11\n&\nWayland"
    }

    TextSlide {
        centeredText: "Platform Native Look"
    }

    ImageSlide {
        image: "../images/qtcreator-windows.png"
    }

    ImageSlide {
        image: "../images/qtcreator-osx.png"
    }

    TextSlide {
        SlideText {
            text: "computers\n" +
                  "phones\n" +
                  "TVs\n" +
                  "fridges\n" +
                  "cars\n" +
                  "OIS\n" +
                  "..."

            anchors.centerIn: parent;
        }
    }

    TextSlide {
        centeredText: "QML"
    }

    TextSlide {
        centeredText: "Declarative Langauge"
    }

    TextSlide {
        centeredText: "QML = Language\n\nQtQuick = Components"
    }

    TextSlide {
        centeredText: "Extensible through\nC++ plugins"
    }

    TextSlide {
        centeredText: "UI/Logic Separation"
    }


    TextSlide {

        Button {
            id: introButton
            text: "Click me!"

            property int _stateIdx: 0
            property variant _stateNames: [ "topLeft", "bottomLeft", "bottomRight", "topRight" ]

            states: [
                State { name: "topLeft";
                    AnchorChanges { target: introButton;
                                    anchors { left: parent.left; top: parent.top; right: undefined; bottom: undefined }
                    }
                },
                State { name: "bottomLeft";
                    AnchorChanges { target: introButton;
                                    anchors { left: parent.left; top: undefined; right: undefined; bottom: parent.bottom }
                    }
                },
                State { name: "bottomRight";
                    AnchorChanges { target: introButton;
                                    anchors { left: undefined; top: undefined; right: parent.right; bottom: parent.bottom }
                    }
                },
                State { name: "topRight";
                    AnchorChanges { target: introButton;
                                    anchors { left: undefined; top: parent.top; right: parent.right; bottom: undefined }
                    }
                }
            ]
            state: "topLeft"

            transitions: Transition {
                SequentialAnimation {
                    AnchorAnimation {
                        duration: 2000
                        easing.type: Easing.OutBounce
                    }
                }
            }

            Timer {
                interval: 2000
                running: true; repeat: true
                onTriggered: {
                    introButton._stateIdx++;
                    if (introButton._stateIdx > 3) {
                        introButton._stateIdx = 0;
                    }
                    introButton.state = introButton._stateNames[introButton._stateIdx]
                }
            }
        }

        ExclusiveGroup {
            id: introExclusiveGroup
            property int checkedIdx: 0
        }
        ColumnLayout {

            x: parent.width * 0.15
            anchors {
                verticalCenter: parent.verticalCenter;
            }

            Repeater {
                model: 8
                RadioButton {
                    id:  introRadioButton;
                    exclusiveGroup: introExclusiveGroup
                    checked: introExclusiveGroup.checkedIdx == index
                }
            }
        }

        Timer {
            interval: 200
            running: true; repeat: true
            onTriggered: {
                introExclusiveGroup.checkedIdx = Math.floor(Math.random() * 10) % 8
            }
        }

        Slider {
            id: introSlider
            y: parent.height * 0.8
            width: parent.width * 0.6
            anchors {
                horizontalCenter: parent.horizontalCenter;
            }
            minimumValue: 0
            maximumValue: 100
            value: 0

            SequentialAnimation {
                PropertyAnimation {
                    target: introSlider; properties: "value"
                    from: 0; to: 100; duration: 2000
                    easing.type: Easing.InOutCubic
                }
                PropertyAnimation {
                    target: introSlider; properties: "value"
                    from: 100; to: 0; duration: 2000
                    easing.type: Easing.InOutCubic
                }

                running: true
                loops: Animation.Infinite
            }
        }

        ProgressBar {
            id: introProgress
            width: parent.width * 0.6
            anchors {
                horizontalCenter: parent.horizontalCenter;
                top: introSlider.bottom
            }
            minimumValue: 0
            maximumValue: 100
            value: 100 - introSlider.value
        }
        Label {
            anchors {
                horizontalCenter: introProgress.horizontalCenter
                top: introProgress.bottom
            }
            text: Math.round(introProgress.value) + "%";
            color: "black"
        }


        Rectangle {
            id: introTopRect
            width: 200
            height: 200
            color: "blue"
            anchors.centerIn: parent

            PropertyAnimation {
                target: introTopRect; properties: "rotation"
                from: 0; to: 360; duration: 5000
                running: true; loops: Animation.Infinite
            }

            SequentialAnimation {
                PropertyAnimation {
                    target: introTopRect; properties: "color"
                    to: "brown"; duration: 3000;
                }
                PropertyAnimation {
                    target: introTopRect; properties: "color"
                    to: "green"; duration: 3000;
                }
                PropertyAnimation {
                    target: introTopRect; properties: "color"
                    to: "black"; duration: 3000;
                }
                loops: Animation.Infinite
                running: true
            }

            SequentialAnimation {
                PropertyAnimation {
                    target: introTopRect; properties: "scale"
                    to: 1.3; duration: 2000
                }
                PropertyAnimation {
                    target: introTopRect; properties: "scale"
                    to: 0.7; duration: 2000
                }
                loops: Animation.Infinite
                running: true
            }

            Rectangle {
                id: introSubRect
                color: "red"
                width: parent.width / 2
                height: parent.height / 2
                anchors.centerIn: parent

                PropertyAnimation {
                    target: introSubRect
                    properties: "rotation"
                    from: 360; to: 0; duration: 2500
                    running: true; loops: Animation.Infinite
                }

                SequentialAnimation {
                    SequentialAnimation {
                        PropertyAnimation {
                            target: introSubRect; properties: "width"
                            from: introTopRect.width / 2; to: introTopRect.width * 1.5; duration: 1000
                            easing.type: Easing.OutElastic
                        }
                        PropertyAnimation {
                            target: introSubRect; properties: "width"
                            from: introTopRect.width * 1.5; to: introTopRect.width / 2; duration: 1000
                            easing.type: Easing.OutElastic
                        }
                    }
                    SequentialAnimation {
                        PropertyAnimation {
                            target: introSubRect; properties: "height"
                            from: introTopRect.height / 2; to: introTopRect.height * 1.5; duration: 1000
                            easing.type: Easing.OutElastic
                        }
                        PropertyAnimation {
                            target: introSubRect; properties: "height"
                            from: introTopRect.height * 1.5; to: introTopRect.height / 2; duration: 1000
                            easing.type: Easing.OutElastic
                        }
                    }
                    loops: Animation.Infinite
                    running: true
                }
            }
        }

        TabView {
            id: introTabView
            x: parent.width * 0.70
            width: parent.width * 0.25
            anchors {
                verticalCenter: parent.verticalCenter
            }

            Tab {
                title: "Tab 1"

                BusyIndicator {
                    anchors.centerIn: parent;
                    running: true
                }
            }
            Tab {
                title: "Tab 2"

                CheckBox {
                    id: introCheckBox
                    anchors.centerIn: parent
                    text:  "Check me!";

                    Timer {
                        interval: 1000; running: true; repeat: true
                        onTriggered: introCheckBox.checked = !introCheckBox.checked;
                    }
                }
            }

            Timer {
                interval: 5000;
                running: true; repeat: true
                onTriggered: {
                    introTabView.currentIndex = (introTabView.currentIndex === 0 ? 1 : 0)
                }
            }


        }


    }

    CodePreviewSlide {
        codeItem.width: 400
        codeItem.height: 200
        codeItem.x: 100
        code: "import QtQuick 2.4

Rectangle {
  id: blueRect
  x: 550; y: 230
  width: 200; height: 200
  color: \"steelblue\"
}"
    }


    CodePreviewSlide {
        codeItem.width: 400
        codeItem.height: 400
        codeItem.x: 80
        code: "import QtQuick 2.4

Rectangle {
  id: blueRect
  x: 600; y: 230
  width: 200; height: 200
  color: \"steelblue\"

  Rectangle {
    id: redRect
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: blueRect.width / 2
    height: blueRect.height / 2
    color: \"red\"
  }
}"

    }


    CodePreviewSlide {
        codeItem.width: 300
        codeItem.height: 600
        codeItem.x: 170
        code: "import QtQuick 2.4

Rectangle {
  id: blueRect
  anchors {
    horizontalCenter: parent.horizontalCenter
    bottom: parent.bottom
  }
  width: 200; height: 80
  color: \"steelblue\"

  Text {
    anchors.centerIn: parent
    text: Math.floor(blueRect.width)
    font { pixelSize: 40 }
  }

  PropertyAnimation {
    target: blueRect; properties: \"width\"
    from: 200; to: 600; duration: 5000
    running: true; loops: Animation.Infinite
  }
}"
    }

    CodePreviewSlide {
        codeItem.width: 300
        codeItem.height: 640
        codeItem.x: 30
        id: slideComboToggleBinding

        code: "import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

ColumnLayout {
  ComboBox {
    id: combo
    model: [ \"Item 1\", \"Item 2\", \"Item 3\" ]
  }

  CheckBox {
    id: chkBox;
    checked: combo.currentIndex == 0
  }

  Button {
    id: btn1;
    text: combo.currentText
    enabled: combo.currentIndex == 1
  }

  Button {
    id: btn2
    text: \"Hello\"
    visible: combo.currentIndex == 2
  }

}"
        customPreview: true
        previewItem: Item {

            ColumnLayout {
                id: cl1
                scale: 1.5

                x: slideComboToggleBinding.width - (width * scale) - 10
                y: (slideComboToggleBinding.height - (height * scale)) / 2
                z: 1000


                ComboBox {
                    id: combo
                    model: [ "Item 1", "Item 2", "Item 3" ]
                }

                CheckBox {
                    id: chkBox;
                    checked: combo.currentIndex == 0
                }

                Button {
                    id: btb1
                    text: combo.currentText
                    enabled: combo.currentIndex == 1
                }

                Button {
                    id: btn2
                    text: "Hello"
                    visible: combo.currentIndex == 2
                }
            }
        }
    }

    CodePreviewSlide {
        codeItem.width: 300
        codeItem.height: 530
        codeItem.x: 30

        code: "import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

ColumnLayout {
    ExclusiveGroup {
        id: radioGroup
    }

    Repeater {
        model: [ { checked: false, title: \"Option 1\" },
                 { checked: true, title: \"Option 2\" },
                 { checked: false, title: \"Option 3\" } ]

        RadioButton {
            id: radio
            exclusiveGroup: radioGroup
            text: modelData.title
            checked: modelData.checked
        }
    }
}"
        customPreview: true
        previewItem: Item {

            ColumnLayout {

                x: 600
                y: 100

                spacing: 20

                ExclusiveGroup {
                    id: radioGroup
                }

                Repeater {
                    model: [ { checked: false, title: "Option 1" },
                             { checked: true, title: "Option 2" },
                             { checked: false, title: "Option 3" } ]

                    RadioButton {
                        id: radio
                        exclusiveGroup: radioGroup
                        text: modelData.title
                        checked: modelData.checked
                        scale: 2
                    }
                }
            }
        }
    }

}
