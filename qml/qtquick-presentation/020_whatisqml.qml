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
    objectName: "020_whatisqml";

    title: "QML & QtQuick";

    Column {
        id: row;
        spacing: 40;

        anchors {
            fill: parent;
            margins: row.spacing;
        }


        SlideText {

            text:
"<h2>QML</h2>
<ul>
  <li>declarative language</li>
  <li>JSON &amp; CSS &amp; JavaScript-like language</li>
  <li>hierarchy of objects</li>
  <li>heavily relies on Qt Meta-Object System</li>
 </ul>"

        }

        SlideText {

            text:
"<h2>QtQuick / BB Cascades</h2>
<ul>
  <li>set of components that can be used in QML</li>
  <li>just QObjects with custom <i>paint()</i>
    <ul>
      <li>(actually <i>QDeclarativeItem</i>/<i>QQuickItem</i>)</li>
    </ul></li>
</ul>"

        }
    }
}
