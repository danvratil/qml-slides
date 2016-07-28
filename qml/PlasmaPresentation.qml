import QtQuick 2.0
import Qt.labs.presentation 1.0

Presentation
{
    id: deck

    property bool inTransition: false;

    property variant fromSlide;
    property variant toSlide;

    property int transitionTime: 500;


    SequentialAnimation {
        id: forwardTransition
        PropertyAction { target: deck; property: "inTransition"; value: true }
        PropertyAction { target: toSlide; property: "visible"; value: true }
        ParallelAnimation {
            NumberAnimation { target: fromSlide; property: "opacity"; from: 1; to: 0; duration: deck.transitionTime; easing.type: Easing.OutQuart }
            NumberAnimation { target: fromSlide; property: "scale"; from: 1; to: 3; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
            NumberAnimation { target: toSlide; property: "opacity"; from: 0; to: 1; duration: deck.transitionTime; easing.type: Easing.InQuart }
            NumberAnimation { target: toSlide; property: "scale"; from: 0.3; to: 1; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
        }
        PropertyAction { target: fromSlide; property: "visible"; value: false }
        PropertyAction { target: fromSlide; property: "scale"; value: 1 }
        PropertyAction { target: deck; property: "inTransition"; value: false }
    }
    SequentialAnimation {
        id: backwardTransition
        running: false
        PropertyAction { target: deck; property: "inTransition"; value: true }
        PropertyAction { target: toSlide; property: "visible"; value: true }
        ParallelAnimation {
            NumberAnimation { target: fromSlide; property: "opacity"; from: 1; to: 0; duration: deck.transitionTime; easing.type: Easing.OutQuart }
            NumberAnimation { target: fromSlide; property: "scale"; from: 1; to: 0.7; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
            NumberAnimation { target: toSlide; property: "opacity"; from: 0; to: 1; duration: deck.transitionTime; easing.type: Easing.InQuart }
            NumberAnimation { target: toSlide; property: "scale"; from: 1.1; to: 1; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
        }
        PropertyAction { target: fromSlide; property: "visible"; value: false }
        PropertyAction { target: fromSlide; property: "scale"; value: 1 }
        PropertyAction { target: deck; property: "inTransition"; value: false }
    }

    function switchSlides(from, to, forward)
    {
        if (deck.inTransition)
            return false

        deck.fromSlide = from
        deck.toSlide = to

        if (forward)
            forwardTransition.running = true
        else
            backwardTransition.running = true

        return true
    }

}
