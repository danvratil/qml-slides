import QtQuick 2.0
import Qt.labs.presentation 1.0
import cz.dvratil 1.0

Slide {
    id: slide

    Loader {
        id: loader

        Item {
            id: livePreview
            anchors.fill: slide
        }
    }

    property string code
    property alias codeItem : codePreview
    property bool customPreview: false
    default property alias previewItem: loader.sourceComponent

    property Item _theObject: null

    x: parent.width * 0.05
    y: parent.height * 0.05
    height: parent.height * 0.90
    width: parent.width * 0.90


    onCodeChanged: {
        codeModel.clear();
        var codeLines = slide.code.split("\n");
        for (var i=0; i<codeLines.length; ++i) {
            codeModel.append({ line: i, code: codeLines[i] });
        }

        if (!customPreview) {
            var newObject = Qt.createQmlObject(slide.code, slide);
            if (slide._theObject) {
                slide._theObject.deleteLater();
                slide._theObject = newObject;
                //slide._theObject.anchors.centerIn = slide;
                //slide._theObject.anchors.margins = 5;
            }
        }
    }



    Item {
        id: codePreview;

        anchors {
            verticalCenter: parent.verticalCenter
            margins: 20
        }

        ListModel {
            id: codeModel
        }

        ListView {
            id: lineNumbers;

            width: 40
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
            }

            clip: true

            model: codeModel;

            delegate: Item {
                id: lineDelegate

                height: lineLabel.height
                width: parent.width

                Rectangle {
                    id: lineLabelBackground
                    anchors.fill: parent;
                    color: slide.textColor;
                    opacity: 0.1;
                }

                Text {
                    id: lineLabel
                    anchors {
                        right: lineLabelBackground.right;
                        rightMargin: 5
                    }
                    text: (line+1)
                    font.family: "Liberation Mono"
                    font.pixelSize: 20
                }
            }
        }

        QMLSyntaxHighlighter {
            id: highlighter
            textEdit: codeText
        }

        TextEdit {
            id: codeText

            anchors {
                top: parent.top
                left: lineNumbers.right
                bottom: parent.top
                right: parent.right
                leftMargin: 5
            }

            text: slide.code
            font {
                family: "Liberation Mono"
                pixelSize: 20
            }
        }
    }

}
