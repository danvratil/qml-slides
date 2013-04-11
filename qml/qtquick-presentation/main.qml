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

Item {
    id: root;

    width: 400;
    height: 400;

    BackgroundSwirls {
        anchors.fill: parent;
    }

    ListView {
        id :listView;
        focus: true;

        anchors.fill: parent;

        //interactive: false; // don't steal events from nested Flickable
        cacheBuffer: listView.width; // keep only 1 previous and 1 following slide
        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal;
        highlightMoveDuration: 600;
        highlightFollowsCurrentItem:true;

        model: [
            "010_title.qml",
            "999_end.qml"
        ]

        delegate: SlideDelegate {
            width: listView.width;
            height: listView.height;
            sourceFile: modelData;
        }
    }
}
