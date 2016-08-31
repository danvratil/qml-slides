import QtQuick 2.0

Text {

    property Item slide: null;
    property real fontScale: 0.08

    font.pixelSize: (slide ? slide : parent).height * fontScale
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter

    color: "#3a3a3a"

    /*
    anchors {
        centerIn: slide ? slide : parent
    }
    */
}
