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

    InteractiveEditor {
        id: editor1;

        anchors {
            top: parent.top;
            left: parent.left;
            bottom: parent.bottom;
            margins: 20;
        }
        width: (parent.width - 30) / 2

        text:
            "import QtQuick 2.0

Item {
  id: root;

  Rectangle {
    id: rect; color: \"red\";
    width: 200; height: 50; radius: 5;

    PasswordInput {
        id: password;
        anchors.fill: parent;

        minLength: 5;

        onTextChanged:
          label.text = password.text;
        onLengthSufficient: {
          rect.color = (len > minLength + 3)
             ? \"black\"
             : \"lightBlue\";
        }
        onLengthInsufficient:
          rect.color = \"red\";
  } } }

  Text {
    id: label;
    anchors.top: rect.bottom;
  }
}
"
    }

    InteractiveEditor {
        id: editor2;

        anchors {
            left: editor1.right;
            right: parent.right;
            top: parent.top;
            margins: 20;
        }
        height: 630;
        text:
            "import QtQuick 2.0

Rectangle {
  signal lengthSufficient(int len);
  signal lengthInsufficient(int len);

  property alias text: edit.text;
  property int minLength: 5;

  color: \"white\"
  radius: 5;

  TextInput {
    id: edit;
    anchors.fill: parent;

    echoMode: TextInput.Password;

    onTextChanged: {
      if (text.length >= minLength) {
        lengthSufficient(text.length);
      } else {
        lengthInsufficient(text.length);
      }
    }
  }
}
"
    }


    Item {
        anchors {
            left: editor1.right;
            top: editor2.bottom;
            bottom: parent.bottom;
            right: parent.right;
            margins: 2;
        }

        Item {
            anchors.fill: parent;
            Rectangle {
                id: rect;
                color: "red";
                width: 200; height: 50;
                anchors.centerIn: parent;
                radius: 10;

                Rectangle {
                    anchors {
                        fill: parent;
                        margins: 5;
                    }
                    color: "white";
                    radius: 5;

                    TextInput {
                        signal lengthChanged(int len);

                        id: password;
                        width: parent.width - 20;
                        anchors.centerIn: parent;
                        echoMode: TextInput.Password;

                        onTextChanged: {
                            label.text = password.text;
                            lengthChanged(text.length);
                        }
                        font {
                            pointSize: 20;
                        }

                        onLengthChanged: {
                            function s(len) {
                              rect.color = (len >= 5) ? ((len > 8) ?"black" : "lightBlue") : "red";
                            }
                            s(len);
                        }
                    }
                }

                Text {
                    id: label;
                    anchors {
                        left: rect.right;
                        margins: 10
                    }
                    font {
                        pointSize: 20;
                    }
                }
            }
        }
    }
}
