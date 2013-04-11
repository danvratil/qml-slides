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

#include <QtGui/QApplication>
#include "qtquick2applicationviewer.h"

#include <QtQml/QQmlIncubationController>
#include <QtQml/QQmlEngine>

#include <QtCore/QDebug>
#include <QtCore/QTimer>

#include "incubator.h"
#include "helper.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;

    QQmlIncubationController *incubationController = new QQmlIncubationController();
    viewer.engine()->setIncubationController(incubationController);

    Helper helper;
    helper.setIncubatorController(incubationController);

    QTimer incubationTimer;
    incubationTimer.setInterval(100);
    QObject::connect(&incubationTimer, &QTimer::timeout,
                     &helper, &Helper::incubate);
    incubationTimer.start();

    qmlRegisterType<Incubator>("cz.progdan.presenter", 1, 0, "Incubator");
    qmlRegisterType<Helper>("cz.progdan.presenter", 1, 0, "Helper");

    viewer.setMainQmlFile(QStringLiteral("qml/qtquick-presentation/main.qml"));
    //viewer.show();
    //viewer.resize(1024, 768);
    viewer.showFullScreen();

    int ret = app.exec();

    delete incubationController;

    return ret;
}
