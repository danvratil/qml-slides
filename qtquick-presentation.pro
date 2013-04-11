# Add more folders to ship with the application, here
folder_01.source = qml/qtquick-presentation
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT += widgets

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += src/main.cpp \
    src/helper.cpp \
    src/incubator.cpp \
    src/qmlsyntaxhighlighter.cpp

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    src/helper.h \
    src/incubator.h \
    src/qmlsyntaxhighlighter.h

OTHER_FILES += \
    qml/qtquick-presentation/*.qml
