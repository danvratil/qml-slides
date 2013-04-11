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

InteractiveSlide {
    objectName: "040_properties";

    title: "Properties";

    editorWidth: parent.width * 0.6;
    editorContent:
"import QtQuick 2.0;

Item {
  id: root; anchors.fill: parent;

  property string name: \"Pepa\";
  property alias name2: nameLabel2.text;

  Text {
    id: nameLabel; font.pointSize: 30;
    anchors {
      horizontalCenter: parent.horizontalCenter;
    }
    text: root.name;
  }

  Text {
    id: nameLabel2; font.pointSize: 30;
    anchors {
      top: nameLabel.bottom;
      horizontalCenter: parent.horizontalCenter;
    }
  }

  Component.onCompleted: {
    name2 = \"Jana\";
  }
}
"
}
