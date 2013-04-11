/*
 *   Copyright (C) 2013 Daniel Vrátil <dan@progdan.cz>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License along
 *   with this program; if not, write to the Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

import QtQuick 2.0

Slide {
    id: root;

    objectName: "010_title";

    Text {
        id: text;
        scale: 0; opacity: 0;
        anchors.centerIn: parent;
        text: "QML & QtQuick";
        font {
            family: "Liberation Sans";
            pointSize: 60;
            bold: true;
        }
        color: "white";
        style: Text.Outline;
        styleColor: "grey";
        smooth: true;
    }
    Text {
        id: name;
        y: text.y + text.height + 40;
        x: -name.width - 100;
        text: "Daniel Vrátil";
        font {
            family: "Liberation Sans";
            pointSize: 30;
            bold: true;
        }
        color: "white";
        style: Text.Outline;
        styleColor: "grey";
        smooth: true;
    }

    SequentialAnimation {
        id: animation;
        ParallelAnimation {
            id: textAnimation;
            property int duration: 3000;
            PropertyAnimation {
                target: text;
                property: "scale";
                from: 0; to: 1;
                duration: textAnimation.duration;
                easing.type: Easing.InOutQuad;
            }
            PropertyAnimation {
                target: text;
                property: "opacity";
                from: 0; to: 1;
                duration: textAnimation.duration / 1.5;
                easing.type: Easing.InOutQuad;
            }
            PropertyAnimation {
                target: text;
                property: "rotation";
                from: 0; to: 360*2;
                duration: textAnimation.duration;
                easing.type: Easing.OutQuad;
            }
        }

        PropertyAnimation {
            target: name;
            property: "x";
            to: (root.width - name.width) / 2;
            duration: 1000;
            easing {
                type: Easing.OutBack;
                overshoot: 2;
            }
        }
    }

    Timer {
        id: startTimer;
        interval: 200;
        onTriggered: animation.start();
        running: true;
    }
}

