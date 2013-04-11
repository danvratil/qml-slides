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

    Item {
        id: frame1;

        anchors {
            left: parent.left;
            top: parent.top;
            bottom: parent.bottom;
            margins: 20;
        }
        width: (parent.width - 40) / 2;

        SlideText {
            id: text1;
            text: "main.qml";
            anchors.horizontalCenter: parent.horizontalCenter;
        }

        InteractiveEditor {
            id: editor1;

            anchors {
                top: text1.bottom;
                left: parent.left;
                right: parent.right;
            }
            height: 480;

            text:
"import QtQuick 2.0

Item {
  id: root;

  Button {
    id: button1;
    width: 100; height: 50;
  }

  Button {
    id: button2;
    anchors {
      left: button1.right;
      margins: 20;
    }
    width: 100; height: 50;
  }
}
"
        }

        Item {
            anchors {
                left: parent.left;
                right: parent.right;
                top: editor1.bottom;
                bottom: parent.bottom;
            }

            Item {
                anchors.centerIn: parent;
                width: childrenRect.width;
                height: childrenRect.height;

                Rectangle {
                    id: button1;
                    width: 150; height: 50;
                    Text {
                        anchors.centerIn: parent;
                        text: "Click me!";
                        font.pointSize: 20;
                        font.family: "Monospace";
                    }
                }
                Rectangle {
                    id: button2;
                    width: 150; height: 50;
                    anchors.left: button1.right;
                    anchors.margins: 20;
                    Text {
                        anchors.centerIn: parent;
                        text: "Click me!";
                        font.pointSize: 20;
                        font.family: "Monospace";
                    }
                }
            }
        }
    }

    Item {
        id: frame2;

        anchors {
            left: frame1.right;
            right: parent.right;
            top: parent.top;
            margins: 20;
        }

        height: (parent.height - 40) / 2;

        SlideText {
            id: text2;
            text: "Button.qml";
            anchors.horizontalCenter: parent.horizontalCenter;
        }

        InteractiveEditor {
            id: editor2;

            anchors {
                left: parent.left;
                right: parent.right;
                top: text2.bottom;
                bottom: parent.bottom;
            }

            text:
"import QtQuick 2.0

Rectangle {
  id: root;

  ButtonText {
    text: \"Click me!\";
  }
}
"
        }
    }

    Item {
        id: frame3;

        anchors {
            left: frame1.right;
            right: parent.right;
            top: frame2.bottom;
            bottom: parent.bottom;
            margins: 20;
        }

        SlideText {
            id: text3;
            text: "ButtonText.qml";
            anchors.horizontalCenter: parent.horizontalCenter;
        }

        InteractiveEditor {
            id: editor3;

            anchors {
                left: parent.left;
                right: parent.right;
                top: text3.bottom;
                bottom: parent.bottom;
            }

            text:
"import QtQuick 2.0

Text {
  id: root;
  anchors.centerIn: parent;
  font {
    pointSize: 20;
    family: \"Monospace\";
  }
}
"
        }
    }

}
