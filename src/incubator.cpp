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

#include "incubator.h"

#include <QtQml/QQmlEngine>
#include <QtQml/QQmlComponent>
#include <QtQml/QQmlContext>

#include <QtCore/QDir>
#include <QtCore/QDebug>
#include <QtCore/QStringBuilder>

Incubator::Incubator(QObject *parent):
    QObject(parent),
    QQmlIncubator(QQmlIncubator::Asynchronous),
    mEngine(0),
    mComponent(0)
{
}

Incubator::~Incubator()
{
}

void Incubator::incubate(const QString &qmlData)
{
    clear();
    if (mComponent) {
        mComponent->deleteLater();
    }

    QQmlContext *context = QQmlEngine::contextForObject(this);
    Q_ASSERT(context != 0);

    mComponent = new QQmlComponent(context->engine(), this);
    connect(mComponent.data(), &QQmlComponent::statusChanged,
            this, &Incubator::componentStatusChanged);
    mComponent->setData(qmlData.toLatin1(), QUrl(QDir::currentPath() % "qml/qtquick-presentation"));
}

void Incubator::destroyItem(QObject *object)
{
    object->deleteLater();
}

void Incubator::componentStatusChanged()
{
    qDebug() << "Incubator::componentStatusChanged:" << mComponent->status();
    QQmlContext *context = QQmlEngine::contextForObject(this);
    Q_ASSERT(context != 0);

    if (mComponent->isReady()) {
        mComponent->create(*this, context);
        return;
    }

    if (mComponent->isError()) {
        qWarning() << mComponent->errorString();
        mComponent->deleteLater();
    }
}

void Incubator::statusChanged(QQmlIncubator::Status status)
{
    qDebug() << "Incubator::statusChanged:" << status;

    if (isReady()) {
        emit incubated(object());
        return;
    }

    if (isError()) {
        qWarning() << mComponent->errorString();
        mComponent->deleteLater();
        return;
    }
}

