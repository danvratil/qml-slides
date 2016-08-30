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
}
