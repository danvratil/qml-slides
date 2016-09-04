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
        running: false
        PropertyAction { target: deck; property: "inTransition"; value: true }
        TransitionAnimation {
            from: fromSlide
            to: toSlide
            transitionTime: deck.transitionTime
        }
        PropertyAction { target: deck; property: "inTransition"; value: false }
    }

    SequentialAnimation {
        id: backwardTransition
        running: false
        PropertyAction { target: deck; property: "inTransition"; value: true }
        PropertyAction { target: deck.toSlide; property: "visible"; value: true }
        ParallelAnimation {
            NumberAnimation { target: deck.romSlide; property: "opacity"; from: 1; to: 0; duration: deck.transitionTime; easing.type: Easing.OutQuart }
            NumberAnimation { target: deck.fromSlide; property: "scale"; from: 1; to: 0.7; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
            NumberAnimation { target: deck.toSlide; property: "opacity"; from: 0; to: 1; duration: deck.transitionTime; easing.type: Easing.InQuart }
            NumberAnimation { target: deck.toSlide; property: "scale"; from: 1.1; to: 1; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
        }
        PropertyAction { target: deck.fromSlide; property: "visible"; value: false }
        PropertyAction { target: deck.fromSlide; property: "scale"; value: 1 }
        PropertyAction { target: deck; property: "inTransition"; value: false }
    }

    function switchSlides(from, to, forward)
    {
        if (deck.inTransition)
            return false

        deck.fromSlide = from
        deck.toSlide = to

        if (forward) {
            if (to.animateTransition) {
                forwardTransition.running = true
            } else {
                to.visible = true
                from.visible = false
            }
        } else {
            if (from.animateTransition) {
                backwardTransition.running = true
            } else {
                to.visible = true
                from.visible = false
            }
        }

        return true
    }

}
