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

    editorContent:
"import QtQuick 2.0

Column {
  id: root; spacing: 20;
  Component {
    id: buttonComponent;
    Rectangle {
      id: rectangle;
      property string text: \"Click me!\";
      width: 200; height: 40;
      Text {
        id: label;
        text: rectangle.text;
        anchors.centerIn: parent;
        font.pointSize: 20;
      }
    }
  }

  Component.onCompleted: {
    var button1 = buttonComponent.createObject(root);
    button1.color = \"red\";

    var button2 = buttonComponent.createObject(root);
    button2.text = \"Hi there!\";
  }
}
"

}
