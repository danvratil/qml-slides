import QtQuick 2.0
import QtQml 2.2
import Qt.labs.presentation 1.0 as Presentation
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1

PlasmaPresentation
{
    id: deck

    width: 1024
    height: 768
    property alias loadingSlide: loadingSlide

    onCurrentSlideChanged: {
        if (deck.currentSlide > 1 && !slideBg.visible) {
            showSlideBgAnimation.running = true
        } else if (deck.currentSlide <= 1) {
            hideSlideBgAnimation.running = true
        }
    }

    Image {
        id: bgImage
        anchors.fill: parent
        source: "../images/background.png"
        antialiasing: true
        fillMode: Image.PreserveAspectFit

        Rectangle {
            id: slideBg;

            anchors {
                centerIn: parent;
            }
            width: parent.width * 0.90
            height: parent.height * 0.90

            visible: false;

            color: "white"
            radius: 10

            SequentialAnimation {
                id: showSlideBgAnimation
                PropertyAction { target: slideBg; property: "opacity"; value: 0; }
                PropertyAction { target: slideBg; property: "visible"; value: true; }
                NumberAnimation {
                    target: slideBg; property: "opacity"; to: 0.8; duration: 500;
                }
            }
            SequentialAnimation {
                id: hideSlideBgAnimation
                NumberAnimation {
                    target: slideBg; property: "opacity"; to: 0; duration: 500;
                }
                PropertyAction { target: slideBg; property: "visible"; value: false; }
                PropertyAction { target: slideBg; property: "opacity"; value: 1; }
            }
        }
    }

    Slide {
        id: loadingSlide

        Image {
            id: kdeLogo

            anchors.centerIn: parent

            source: "../images/kontact.png"
            antialiasing: true
            fillMode: Image.PreserveAspectFit

            width: 200
        }

        SequentialAnimation {
            running: deck.currentSlide === 0
            loops: Animation.Infinite

            NumberAnimation {
                target: kdeLogo
                property: "scale"
                to: 1.5
                duration: 1000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: kdeLogo
                property: "scale"
                to: 0.5
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }
    }

    Slide {
        id: titleSlide

        Item {
            height: childrenRect.height
            width: parent.width
            anchors.centerIn: parent

            Image {
                id: kdeLogoTitle

                source: "../images/kontact.png"
                antialiasing: true
                fillMode: Image.PreserveAspectFit

                width: 200

                anchors.horizontalCenter: parent.horizontalCenter
            }

            SlideText {
                id: talkTitle
                text: "KDE PIM Status Report"
                anchors.top: kdeLogoTitle.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                style: Text.Outline
                styleColor: "black"
                slide: titleSlide
            }

            SlideText {
                id: authorLabel
                text: "Daniel Vrátil <dvratil@kde.org>"
                anchors.top: talkTitle.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                style: Text.Outline
                styleColor: "black"
                slide: titleSlide
                fontScale:  0.05
            }
        }
    }

    Slide {
        SlideText {
            text: "What did we break last year?"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            height: parent.height / 2
            horizontalAlignment: Text.AlignHCenter
        }
    }


    Slide {
        animateTransition: false

        SlideText {
            text: "What did we break last year?"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            height: parent.height / 2
            horizontalAlignment: Text.AlignHCenter
        }

        SlideText {
            id: whatAreWeBreakingNext
            text: "What are we going to break next year?"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            height: parent.height / 2
            horizontalAlignment: Text.AlignHCenter
            visible: false
        }

        TransitionAnimation {
            to: whatAreWeBreakingNext
            transitionTime: 500
            running: deck.currentSlide === 3
        }
    }

    TextSlide {
        SlideText {
            anchors.centerIn: parent
            text: "Switch to KF5/Qt5"
        }

    }

    TextSlide {

        SlideText {
            anchors.centerIn: parent
            text: "Switch to QtWebEngine"
        }
    }

    TextSlide {

        SlideText {
            anchors.centerIn: parent
            text: "Switch to Grantlee"
        }
    }

    TextSlide {

        SlideText {
            anchors.centerIn: parent
            text: "Repository reorganization"
        }
    }

    Slide {

        // HACK!
        height: slideBg.height
        y: slideBg.y

        GridLayout {
            width: parent.width
            height: parent.height
            anchors {
                centerIn: parent.center
            }

            columns: 3
            rows: 2

            SlideText {
                text: "kdepimlibs"
                font.weight: Font.Bold

                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            }

            SlideText {
                text: "kdepim"
                font.weight: Font.Bold

                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.columnSpan: 2
            }


            SlideText {
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 18
                style: Text.Normal
                text: "<b>akonadi</b><br>" +
                      "akonadi-calendar<br>" +
                      "akonadi-contacts<br>" +
                      "akonadi-mime<br>" +
                      "akonadi-notes<br>" +
                      "<b>gpgmepp</b><br>" +
                      "kalarmcal<br>"  +
                      "kblog<br>" +
                      "<b>kcalcore</b><br>" +
                      "kcalutils<br>" +
                      "<b>kcontacts</b><br>" +
                      "<b>kholidays</b><br>" +
                      "kidentitymanagement<br>" +
                      "<b>kimap</b><br>" +
                      "<b>kldap</b><br>" +
                      "kmailtransport<br>" +
                      "kmbox<br>" +
                      "<b>kmime</b><br>" +
                      "kontactinterface<br>" +
                      "kpimtextedit<br>" +
                      "kpimutils<br>" +
                      "ktnef<br>" +
                      "kxmlrpcclient<br>" +
                      "syndication"
            }

            SlideText {
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 18
                style: Text.Normal
                text:"akonadi-calendar-tools<br>" +
                     "akonadiconsole<br>" +
                     "akonadi-import-wizard<br>" +
                     "akregator<br>" +
                     "blogilo<br>" +
                     "grantlee-editor<br>" +
                     "kaddressbook<br>" +
                     "kalarm<br>" +
                     "kleopatra<br>" +
                     "kmail<br>" +
                     "kontact<br>" +
                     "korganizer<br>" +
                     "pimcommon<br>" +
                     "mailimporter<br>" +
                     "mbox-importer<br>" +
                     "pim-data-exported<br>" +
                     "pim-sieve-editor<br>" +
                     "pim-storage-service-manager"
            }
            SlideText {
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 18
                style: Text.Normal
                text: "calendarsupport<br>" +
                      "eventviews<br>" +
                      "<b>grantleetheme</b><br>" +
                      "incidenceeditor<br>" +
                      "kdepim-addons<br>" +
                      "kdepim-apps-libs<br>" +
                      "kmail-account-wizard<br>" +
                      "<b>libgravatar</b><br>" +
                      "libkdepim<br>" +
                      "libkleo<br>" +
                      "<b>libksieve</b><br>" +
                      "mailcommon<br>" +
                      "messagelib<br>"
            }
        }
    }


    TextSlide {

        SlideText {
            anchors.centerIn: parent
            text: "KMail Love"
        }

    }

    TextSlide {

        SlideText {
            anchors.centerIn: parent
            text: "Akregator Love"
        }

    }

    TextSlide {

        SlideText {
            anchors.centerIn: parent
            text: "EasyGPG"
        }
    }

}
