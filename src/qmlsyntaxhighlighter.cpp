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

#include "qmlsyntaxhighlighter.h"

#include <QtCore/QDebug>

QMLSyntaxHighlighter::QMLSyntaxHighlighter(QTextDocument *textDocument):
    QSyntaxHighlighter(textDocument)
{
    HighlightingRule rule;

    keywordFormat.setForeground(Qt::darkYellow);
    //keywordFormat.setFontWeight(QFont::Bold);
    QStringList keywordPatterns;
    keywordPatterns << "\\baction\\b" << "\\bbool\\b" << "\\bcolor\\b"
                    << "\\bdate\\b" << "\\bdouble\\b" << "\\benumeration\\b"
                    << "\\bfont\\b" << "\\bint\\b" << "\\blist\\b"
                    << "\\bpoint\\b" << "\\breal\\b" << "\\brect\\b"
                    << "\\bsize\\b" << "\\bstring\\b" << "\\btime\\b"
                    << "\\burl\\b" << "\\bvariant\\b" << "\\bvector3d\\b"
                    << "\\bimport\\b" << "\\bfunction\\b" << "\\bvar\\b"
                    << "\\bbehavior\\b" << "\\bproperty\\b" << "\\balias\\b"
                    << "\\bsignal\\b";
    foreach (const QString &pattern, keywordPatterns) {
        rule.pattern = QRegExp(pattern);
        rule.format = keywordFormat;
        highlightingRules.append(rule);
    }

    classFormat.setFontWeight(QFont::Bold);
    classFormat.setForeground(Qt::magenta);
    rule.pattern = QRegExp("\\b[A-Z][A-Za-z]+[\\s]+(?=\\{)");
    rule.format = classFormat;
    highlightingRules.append(rule);

    quotationFormat.setForeground(Qt::darkGreen);
    rule.pattern = QRegExp("\".*\"");
    rule.format = quotationFormat;
    highlightingRules.append(rule);

    functionFormat.setFontItalic(true);
    functionFormat.setForeground(Qt::blue);
    rule.pattern = QRegExp("\\b[A-Za-z0-9_]+(?=\\()");
    rule.format = functionFormat;
    highlightingRules.append(rule);

    singleLineCommentFormat.setForeground(Qt::blue);
    rule.pattern = QRegExp("//[^\n]*");
    rule.format = singleLineCommentFormat;
    highlightingRules.append(rule);

    multiLineCommentFormat.setForeground(Qt::blue);

    commentStartExpression = QRegExp("/\\*");
    commentEndExpression = QRegExp("\\*/");

    referenceFormat.setFontItalic(true);
    rule.pattern = QRegExp("\\b[a-z][A-Za-z0-9_]+[.]");
    rule.format = referenceFormat;
    highlightingRules.append(rule);

    rule.pattern = QRegExp("parent");
    highlightingRules.append(rule);

    propertyFormat.setForeground(Qt::red);
    rule.pattern = QRegExp("\\b[a-z][A-Za-z0-9_]*[\\s]*(?=[:\{])");
    rule.format = propertyFormat;
    highlightingRules.append(rule);

    rule.pattern = QRegExp("\\b[a-z][A-Za-z0-9_]*[.][a-z][A-Za-z0-9_]*[\\s]*(?=[:\{])");
    highlightingRules.append(rule);
}

QMLSyntaxHighlighter::~QMLSyntaxHighlighter()
{
}

void QMLSyntaxHighlighter::highlightBlock(const QString &text)
{
    foreach(const HighlightingRule &rule, highlightingRules) {
        QRegExp expression(rule.pattern);
        int index = expression.indexIn(text);
        while (index >= 0) {
            int length = expression.matchedLength();
            setFormat(index, length , rule.format);
            index = expression.indexIn(text, index + length);
        }
    }

    setCurrentBlockState(0);

    int startIndex = 0;
    if (previousBlockState() != 1)
        startIndex = commentStartExpression.indexIn(text);

    while (startIndex >= 0) {
        int endIndex = commentEndExpression.indexIn(text, startIndex);
        int commentLength;
        if (endIndex == -1) {
            setCurrentBlockState(1);
            commentLength = text.length() - startIndex;
        } else {
            commentLength = endIndex - startIndex
                    + commentEndExpression.matchedLength();
        }
        setFormat(startIndex, commentLength, multiLineCommentFormat);
        startIndex = commentStartExpression.indexIn(text, startIndex + commentLength);
    }
}
