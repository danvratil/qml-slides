import QtQuick 2.0

Text {

    property Item slide: null;
    property real scale: 0.08

    font.family: "Montserrat"
    font.pixelSize: (slide ? slide : parent).height * scale
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter

    /*
    anchors {
        centerIn: slide ? slide : parent
    }
    */
}
