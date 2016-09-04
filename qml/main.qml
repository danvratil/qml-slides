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

    showNotes: true

    onCurrentSlideChanged: {
        if (!slideBg.visible && deck.slides[deck.currentSlide].hasBackground) {
            showSlideBgAnimation.running = true
        } else if (slideBg.visible && !deck.slides[deck.currentSlide].hasBackground) {
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

            Text {
                text: "QtCon 2016: KDE PIM Status Report"
                font.pixelSize: 15
                anchors {
                    left: parent.left
                    bottom: parent.bottom
                    leftMargin: 10
                    bottomMargin: 10
                }
            }

            Text {
                text: "Daniel Vrátil <dvratil@kde.org>"
                font.pixelSize: 15
                anchors {
                    right: parent.right
                    bottom: parent.bottom
                    rightMargin: 10
                    bottomMargin: 10
                }
            }
        }
    }

    Slide {
        id: loadingSlide

        hasBackground: false

        notes: "<h1>Welcome</h1>"

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

        hasBackground: false

        notes: "<h1>Title Slide</h1>"

        ColumnLayout {
            anchors.centerIn: parent

            Image {
                source: "../images/kontact.png"
                antialiasing: true
                fillMode: Image.PreserveAspectFit

                width: 200

                Layout.alignment: Qt.AlignHCenter
            }

            SlideText {
                text: "KDE PIM Status Report"
                color: "white"
                style: Text.Outline
                styleColor: "black"
                slide: titleSlide

                Layout.alignment: Qt.AlignHCenter
            }

            SlideText {
                text: "Daniel Vrátil <dvratil@kde.org>"
                color: "white"
                style: Text.Outline
                styleColor: "black"
                slide: titleSlide
                fontScale:  0.05

                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    Slide {

        notes: "<h1>What did we break last year? (1/2)</h1>"

        SlideText {
            text: "What did we break last year?"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            height: parent.height / 2
            horizontalAlignment: Text.AlignHCenter
        }
    }


    Slide {
        id: whatAreWeBreakingSlide
        animateTransition: false

        notes: "<h1>What did we break last year (2/2)</h1>"

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
            running: deck.slides[currentSlide] === whatAreWeBreakingSlide
        }
    }

    TextSlide {

        notes: "<h1>Switch to KF5/Qt5</h1>" +
               "<ul><li>Started in App/15.08</li>" +
               "<li>Performance improvements</li>" +
               "<li>Improved experience</li>" +
               "<li>Overall well accepted by users</li>"

        SlideText {
            anchors.centerIn: parent
            text: "Switch to KF5/Qt5"
        }

    }

    TextSlide {

        notes: "<h1>Switch to QtWebEngine</h1>" +
               "<ul><li>QtWebKit deprecated by Qt</li>" +
               "<li>secure, maintained</li>" +
               "<li>emails are a vector of attack</li></ul>"

        SlideText {
            anchors.centerIn: parent
            text: "Switch to QtWebEngine"
        }
    }

    TextSlide {

        notes: "<h1>Switch to Grantlee</h1>" +
               "<ul><li>Grantlee, Qt library for HTML templates</li>" +
               "<li>we had lots of C++ code to generate HTML, ugly, hard to maintian</li></ul>"

        SlideText {
            anchors.centerIn: parent
            text: "Switch to Grantlee"
        }
    }

    TextSlide {

        notes: "<h1>Repository Reorganization (1/2)</h1>" +
               "<ul><li>used to be: akonadi, kdepimlibs, kdepim and kdepim-runtime</li></ul>"

        SlideText {
            anchors.centerIn: parent
            text: "Repository reorganization"
        }
    }

    Slide {

        notes: "<h1>Repository Reorganization (2/2)</h1>" +
               "<ul><li>KDE PIM: 58 (~60) repos</li>" +
               "<li>KDE Frameworks: 71 (~70) repos</li>" +
               "<li>Akonadi: merged libs to server</li>" +
               "<li>gpgmepp: upstreamed to gpgme</li>" +
               "<li>kcalcore, kcontacts, kmime</li>" +
               "<li>kholidays</li>" +
               "<li>kimap, kldap</li>" +
               "<li>grantleetheme</li>" +
               "<li>libgravatar</li>" +
               "<li>libksieve</li></ul>"

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

        notes: "<h1>KMail Love</h1>" +
               "<ul><li>improved accessibility (TTS)</li>" +
               "<li>cached threading</li>" +
               "<li>composer: check identity for recipient</li>" +
               "<li>bug fixes</li>" +
               "<li>small influx of new contributors</li></ul>"


        SlideText {
            anchors.centerIn: parent
            text: "KMail Love"
        }
    }

    TextSlide {

        notes: "<h1>Akregator Love</h1>" +
               "<ul><li>long time neglected</li>" +
               "<li>QtWebEngine</li>" +
               "<li>bug fixes</li>" +
               "<li>notification improvements - NEW CONTRIBUTOR?</li></ul>"

        SlideText {
            anchors.centerIn: parent
            text: "Akregator Love"
        }
    }

    TextSlide {
        notes: "<h1>Plasma Calendar plugin</h1>" +
               "<ul><li>Show events in calendars in Plasma Clock applets</li></ul>"


        SlideText {
            anchors.centerIn: parent
            text: "Plasma Calendar integration"
        }
    }

    TextSlide {

        notes: "<h1>EasyGPG</h1>" +
               "<ul><li>Make OpenPGP accessible for normal users</li>" +
               "<li>Currently phase 1</li>" +
               "<li>Crypto is hard for normal users, hide from them as much as possible</li>" +
               "<li>Automatically generate and publish key pair</li>" +
               "<li>Automatically fetch recipient keys for encryption</li>"

        SlideText {
            anchors.centerIn: parent
            text: "EasyGPG"
        }
    }

    Slide {
        id: pimInNumbersSlide1

        notes: "<h1>PIM in Numbers (0/3)</h1>" +
               "Time period 1 Sep 2015 - 1 Sep 2016<br>" +
               "<ul><li>64 contributors</li>" +
               "<li>8800 commits</li>" +
               "<li>90% by 5 contributors</li>" +
               "<li>72% by Laurent</li>" +
               "<li>324 bugs FIXED</li></ul>"

        SlideText {
            id: pimInNumbers
            text: "PIM in Numbers"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Slide {
        id: pimInNumbersSlide2
        animateTransition: false

        notes: "<h1>PIM in Numbers (1/3 - contributors)</h1>" +
               "Time period 1 Sep 2015 - 1 Sep 2016<br>" +
               "<ul><li>64 contributors</li>" +
               "<li>8800 commits</li>" +
               "<li>90% by 5 contributors</li>" +
               "<li>72% by Laurent</li>" +
               "<li>324 bugs FIXED</li></ul>"


        SlideText {
            id: pimInNumbers2
            text: "PIM in Numbers"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
        }

        Row {
            anchors {
                left: parent.left
                top: pimInNumbers2.bottom
                right: parent.right
                bottom: parent.bottom
            }


            SlideText {
                id: contributorsCount

                property int value : 0

                NumberAnimation {
                    target: contributorsCount; property: "value"
                    from: 0; to: 64
                    duration: 3000;
                    running: contributorsCount.visible
                    easing.type: Easing.OutExpo
                }

                text: "Contributors\n" + value
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: false

                width: parent.width / 3
            }
        }

        TransitionAnimation {
            to: contributorsCount
            transitionTime: 500
            running: deck.slides[currentSlide] === pimInNumbersSlide2
        }
    }

    Slide {
        id: pimInNumbersSlide3
        animateTransition: false

        notes: "<h1>PIM in Numbers (2/3 - commits)</h1>" +
               "Time period 1 Sep 2015 - 1 Sep 2016<br>" +
               "<ul><li>64 contributors</li>" +
               "<li>8800 commits</li>" +
               "<li>90% by 5 contributors</li>" +
               "<li>72% by Laurent</li>" +
               "<li>324 bugs FIXED</li></ul>"


        SlideText {
            id: pimInNumbers3
            text: "PIM in Numbers"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
        }

        Row {
            anchors {
                left: parent.left
                top: pimInNumbers3.bottom
                right: parent.right
                bottom: parent.bottom
            }

            SlideText {
                text: "Contributors\n64"
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter

                width: parent.width / 3
            }

            SlideText {
                id: commitsCount

                property int value : 0

                NumberAnimation {
                    target: commitsCount; property: "value"
                    from: 0; to: 8800
                    duration: 3000;
                    running: commitsCount.visible
                    easing.type: Easing.OutExpo
                }

                text: "Commits\n" + value
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: false

                width: parent.width / 3
            }

        }

        TransitionAnimation {
            to: commitsCount
            transitionTime: 500
            running: deck.slides[currentSlide] === pimInNumbersSlide3
        }
    }

    Slide {
        id: pimInNumbersSlide4
        animateTransition: false

        notes: "<h1>PIM in Numbers (3/3 - bugs)</h1>" +
               "Time period 1 Sep 2015 - 1 Sep 2016<br>" +
               "<ul><li>64 contributors</li>" +
               "<li>8800 commits</li>" +
               "<li>90% by 5 contributors</li>" +
               "<li>72% by Laurent</li>" +
               "<li>324 bugs FIXED</li></ul>"


        SlideText {
            id: pimInNumbers4
            text: "PIM in Numbers"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
        }

        Row {
            anchors {
                left: parent.left
                top: pimInNumbers4.bottom
                right: parent.right
                bottom: parent.bottom
            }

            SlideText {
                text: "Contributors\n64"
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter

                width: parent.width / 3
            }

            SlideText {
                text: "Commits\n8800"
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter

                width: parent.width / 3
            }

            SlideText {
                id: bugsCount

                property int value : 0

                NumberAnimation {
                    target: bugsCount; property: "value"
                    from: 0; to: 324
                    duration: 2500;
                    running: bugsCount.visible
                    easing.type: Easing.OutExpo
                }


                text: "Bugs fixed\n" + value
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                visible: false

                width: parent.width / 3
            }
        }

        TransitionAnimation {
            to: bugsCount
            transitionTime: 500
            running: deck.slides[currentSlide] === pimInNumbersSlide4
        }
    }


    ImageSlide {

        notes: "<h1>Plans for future</h1>" +
               "Obligatory Doctor Who Reference"

        animatedImage: "../images/time-travel.gif"
        source:  "(Obligatory Doctor Who reference)"
    }

    TextSlide {

        notes: "<h1>More crypto stuff</h1>" +
               "re/de/encrypt received emails with user's key for secure storage"

        SlideText {
            anchors.centerIn: parent
            text: "More crypto stuff"
        }
    }

    TextSlide {

        notes: "<h1>Changes in search</h1>" +
               "<ul><li>changes in search infrastructure</li>" +
               "<li>changes in search UI</li></ul>"

        SlideText {
            anchors.centerIn: parent
            text: "Changes in Search"
        }
    }

    TextSlide {

        notes: "<h1>Modularization</h1>" +
               "Moving even more functionality into plugins"

        SlideText {
            anchors.centerIn: parent
            text: "Modularization"
        }
    }

    // UI improvements
    TextSlide {

        notes: "<h1>Kontact Facelift</h1>" +
               "<ul><li>modern look</li>" +
               "<li>simplified settings</li>" +
               "<li>streamlined account management</li></ul>"

        SlideText {
            anchors.centerIn: parent;
            text: "Kontact Facelift"
        }
    }

    TextSlide {

        notes: "<h1>User Survey</h1>" +
               "<ul><li>We don't know anything about our users</li>" +
               "<li>Account cnt, email cnt, favourite/unknown features</li>" +
               "<li>Published after Akademy</li></ul>"

        SlideText {
            anchors.centerIn: parent
            text: "User Survey"
        }
    }

    TextSlide {
        id: bofSlide

        notes: "<h1>KDE PIM BoF</h1>" +
               "Monday at 3 PM, room MAR 0.003"

        ColumnLayout {
            anchors.centerIn: parent

            SlideText {
                id: kdepimbofLabel
                text: "KDE PIM BoF"
                slide: bofSlide

                Layout.alignment: Qt.AlignHCenter
            }
            SlideText {
                text: "Monday at 3 PM<br>Room MAR 0.003"
                fontScale: 0.05
                slide: bofSlide

                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    TextSlide {

        id: thankYouSlide
        hasBackground: false

        notes: "<h1>Thank you! Questions?</h1>"

        SlideText {
            text: "Thank you!<br>Questions?"
            anchors.centerIn: parent
            color: "white"
            style: Text.Outline
            styleColor: "black"
            fontScale: 0.15
        }


    }

}
