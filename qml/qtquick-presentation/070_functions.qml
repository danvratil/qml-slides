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

    objectName: "070_functions";

    title: "Functions";

    editorContent:
"import QtQuick 2.0

Column {
  id: root;
  spacing: 50;
  Rectangle {
    id: rect; color: \"red\";
    width: 100; height: 50;

    function makeWider() { width += 100; }
  }

  Rectangle {
    id: button; width: 300; height: 50;
    Text {
      font.pointSize: 30;
      anchors.centerIn: parent;
      text: 'Make it wider!';
    }
    MouseArea {
      anchors.fill: parent;
      onClicked: rect.makeWider();
   }
  }
}"

}
