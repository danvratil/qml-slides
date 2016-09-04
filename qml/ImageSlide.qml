import QtQuick 2.0
import QtGraphicalEffects 1.0


Slide {
    id: slide


    property alias image: image.source
    property alias animatedImage: animatedImage.source
    property string source
    property bool glow: true

    property bool isAnimated: animatedImage.source != ""

    x: parent.width * 0.05
    y: parent.height * 0.05
    height: parent.height * 0.90
    width: parent.width * 0.90

    RectangularGlow {
        anchors.fill: parent.isAnimated ? animatedImage : image
        glowRadius: 15
        spread: 0.2
        color: "#000000"
        opacity: 0.8
        cornerRadius: glowRadius
        visible: slide.glow
    }

    Image {
        id: image;
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        visible: !parent.isAnimated

        onWidthChanged: {
            if (width > parent.width * 0.90) {
                width = parent.width * 0.90;
            }
        }
    }

    AnimatedImage {
        id: animatedImage;
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent;
        visible: parent.isAnimated

        onWidthChanged: {
            if (width > parent.width * 0.90) {
                width = parent.width * 0.90;
            }
        }
    }

    Text {
        id: source;
        anchors {
            top: parent.isAnimated ? animatedImage.bottom : image.bottom
            horizontalCenter: parent.isAnimated ? animatedImage.horizontalCenter : image.horizontalCenter
            topMargin: 10
        }
        font.pixelSize: 15
        visible: parent.source !== ""
        text: parent.source
    }
}
