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

#ifndef HELPER_H
#define HELPER_H

#include <QtCore/QObject>
#include <QtCore/QSharedPointer>


class QQmlIncubationController;
class QMLSyntaxHighlighter;
class QTextEdit;

class Helper : public QObject
{
    Q_OBJECT

  public:
    explicit Helper(QObject *parent = 0);
    virtual ~Helper();

    void setIncubatorController(QQmlIncubationController *controller);

    Q_INVOKABLE void installSyntaxHighlighter(QObject *object);

  public slots:
    void incubate();

  private:
    QQmlIncubationController *mController;
    QList<QSharedPointer<QMLSyntaxHighlighter> > mHighlighters;
};

#endif // HELPER_H
