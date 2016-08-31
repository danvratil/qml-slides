import QtQuick 2.0

SequentialAnimation {
    id: root

    property var to
    property var from
    property int transitionTime


    PropertyAction { target: root.to; property: "visible"; value: true }
    ParallelAnimation {
        NumberAnimation { target: root.from; property: "opacity"; from: 1; to: 0; duration: root.transitionTime; easing.type: Easing.OutQuart }
        NumberAnimation { target: root.from; property: "scale"; from: 1; to: 3; duration: root.transitionTime; easing.type: Easing.InOutQuart }
        NumberAnimation { target: root.to; property: "opacity"; from: 0; to: 1; duration: root.transitionTime; easing.type: Easing.InQuart }
        NumberAnimation { target: root.to; property: "scale"; from: 0.3; to: 1; duration: root.transitionTime; easing.type: Easing.InOutQuart }
    }
    PropertyAction { target: root.from; property: "visible"; value: false }
    PropertyAction { target: root.to; property: "scale"; value: 1 }
}
