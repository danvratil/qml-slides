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
import cz.progdan.presenter 1.0

Item {
    id: root;

    property string defaultContent: "";
    property alias text: textArea.text;

    Helper {
        id: helper;
    }

    Rectangle {
        id: rectangle;

        anchors.fill: parent;

        color: "white";
        opacity: 0.8;
        radius: 30;
    }

    TextEdit {
        id: textArea;

        anchors.fill: parent;
        anchors.margins: 15;

        textFormat: TextEdit.AutoText;
        font {
            family: "monospace";
            pointSize: 14;
        }

        color: "black";
        text: defaultContent;
        wrapMode: TextEdit.Wrap;
        selectByMouse: true;

        onTextChanged: root.textChanged();

        Component.onCompleted: helper.installSyntaxHighlighter(textArea);
    }
}
