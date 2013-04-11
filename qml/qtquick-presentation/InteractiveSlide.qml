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

Slide {
    id: root;

    property alias editorContent: interactiveEditor.defaultContent;
    property bool handleSize: true;
    property int editorWidth: (root.width / 2);

    Helper {
        id: helper;
    }

    Incubator {
        id: incubator;

        onIncubated: {
            for (var i = 0; i < preview.children.length; i++) {
                // Can't .destroy() item created outside QML
                incubator.destroyItem(preview.children[i]);
            }

            object.parent = preview;
        }
    }

    InteractiveEditor {
        id: interactiveEditor;

        width: root.editorWidth;
        anchors {
            left: parent.left;
            top: parent.top;
            bottom: parent.bottom;
            margins: 50;
        }

        onTextChanged: {
            incubator.incubate(interactiveEditor.text);
        }
    }

    Item {
        id: previewContainer;

        anchors {
            left: interactiveEditor.right;
            top: parent.top;
            bottom: parent.bottom;
            right: parent.right;
            margins: 50;
        }

        Item {
            id: preview;

            width: childrenRect.width;
            height: childrenRect.height;
            anchors.centerIn: parent;
        }
    }
}

