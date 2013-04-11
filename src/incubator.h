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

#ifndef INCUBATOR_H
#define INCUBATOR_H

#include <QtCore/QObject>
#include <QtQml/QQmlIncubator>
#include <QtQml/QQmlComponent>

#include <QtCore/QPointer>

class Incubator : public QObject,
                  public QQmlIncubator
{
    Q_OBJECT

  public:
    explicit Incubator(QObject *parent = 0);
    virtual ~Incubator();

    Q_INVOKABLE void incubate(const QString &qmlData);
    Q_INVOKABLE void destroyItem(QObject *object);

  signals:
    void incubated(QObject *object);
    
  protected:
    void statusChanged(Status status);
    void componentStatusChanged();

  private:
    QQmlEngine *mEngine;
    QPointer<QQmlComponent> mComponent;
};


#endif // INCUBATOR_H
