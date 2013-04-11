/***************************************************************************
**
** This file is part of QML Presentation System **
**
** Copyright (c) 2010 Nokia Corporation and/or its subsidiary(-ies).*
**
** All rights reserved.
** Contact:  Nokia Corporation (qt-info@nokia.com)
**
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**
**  * Redistributions of source code must retain the above copyright notice,
**    this list of conditions and the following disclaimer.
**  * Redistributions in binary form must reproduce the above copyright notice,
**    this list of conditions and the following disclaimer in the documentation
**    and/or other materials provided with ** the distribution.
**  * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor the
**    names of its contributors may be used to endorse or promote products
**    derived from this software without specific ** prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
** AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
** IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
** ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
** LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
** DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
** SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
** CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
** OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
**************************************************************************/

import QtQuick 2.0
import QtQuick.Particles 2.0

Item {
    Rectangle {
        anchors.fill: parent
        smooth: true;
        gradient: Gradient {
            GradientStop { position: 0; color: "darkgreen" }
            GradientStop { position: 1; color: "green" }
        }
    }

    Rectangle {
        id: colorTableItem
        width: 16
        height: 16
        anchors.fill: parent

        property color color1: Qt.rgba(0.8, 0.8, 1, 0.3)
        property color color2: Qt.rgba(0.8, 0.8, 1, 0.3)

        smooth: true;

        gradient: Gradient {
            GradientStop { position: 0; color: colorTableItem.color1 }
            GradientStop { position: 0.3; color: "transparent" }
            GradientStop { position: 0.7; color: "transparent" }
            GradientStop { position: 1; color: colorTableItem.color2 }
        }

        visible: false
    }

    ShaderEffectSource {
        id: colorTableSource
        sourceItem: colorTableItem
        smooth: true
    }

    Repeater {
        model: 4
        Swirl {

            width: parent.width
            anchors.bottom: parent.bottom
            height: parent.height / (2 + index)
            opacity: 0.5
            speed: (index + 1) / 2;
            colorTable: colorTableSource
        }
    }
}
