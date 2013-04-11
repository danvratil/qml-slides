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
 *
 *   Based on the Qt Syntax Highlighter Example
 */

#ifndef QMLSYNTAXHIGHLIGHTER_H
#define QMLSYNTAXHIGHLIGHTER_H

#include <QtGui/QSyntaxHighlighter>
#include <QtGui/QTextCharFormat>

class QMLSyntaxHighlighter : public QSyntaxHighlighter
{
    Q_OBJECT

  public:
    explicit QMLSyntaxHighlighter(QTextDocument *textDocument);
    virtual ~QMLSyntaxHighlighter();
    
  protected:
    virtual void highlightBlock(const QString &text);

  private:
    struct HighlightingRule
    {
        QRegExp pattern;
        QTextCharFormat format;
    };
    QVector<HighlightingRule> highlightingRules;

    QRegExp commentStartExpression;
    QRegExp commentEndExpression;

    QTextCharFormat keywordFormat;
    QTextCharFormat classFormat;
    QTextCharFormat singleLineCommentFormat;
    QTextCharFormat multiLineCommentFormat;
    QTextCharFormat quotationFormat;
    QTextCharFormat functionFormat;
    QTextCharFormat propertyFormat;
    QTextCharFormat referenceFormat;
};

#endif // QMLSYNTAXHIGHLIGHTER_H
