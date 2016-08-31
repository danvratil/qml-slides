QT += quick
CONFIG += C++11 qml_debug

SOURCES += \
    main.cpp

OTHER_FILES += images/* \
               qml/*

DISTFILES += \
    qml/TransitionAnimation.qml \
    qml/Slide.qml
