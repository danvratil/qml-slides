
#include <QGuiApplication>
#include <QUrl>
#include <QDir>
#include <QMetaObject>
#include <QRegularExpression>
#include <QCommandLineParser>
#include <QCommandLineOption>

#include <QQuickView>
#include <QQuickItem>
#include <QQuickTextDocument>
#include <QQmlEngine>


#include <QSyntaxHighlighter>

class QMLSyntaxHighlighter : public QSyntaxHighlighter
{
    Q_OBJECT

    Q_DISABLE_COPY(QMLSyntaxHighlighter)
public:
    QMLSyntaxHighlighter(QTextDocument *parent = Q_NULLPTR)
        : QSyntaxHighlighter(parent)
    {

        if (mHighlightingRules.isEmpty()) {
            {
                QTextCharFormat format;
                format.setForeground(Qt::darkYellow);
                QStringList keywordPatterns;
                keywordPatterns << QStringLiteral("\\baction\\b")
                                << QStringLiteral("\\bbool\\b")
                                << QStringLiteral("\\bcolor\\b")
                                << QStringLiteral("\\bdate\\b")
                                << QStringLiteral("\\bdouble\\b")
                                << QStringLiteral("\\benumeration\\b")
                                << QStringLiteral("\\bfont\\b")
                                << QStringLiteral("\\bint\\b")
                                << QStringLiteral("\\blist\\b")
                                << QStringLiteral("\\bpoint\\b")
                                << QStringLiteral("\\breal\\b")
                                << QStringLiteral("\\brect\\b")
                                << QStringLiteral("\\bsize\\b")
                                << QStringLiteral("\\bstring\\b")
                                << QStringLiteral("\\btime\\b")
                                << QStringLiteral("\\burl\\b")
                                << QStringLiteral("\\bvariant\\b")
                                << QStringLiteral("\\bvector3d\\b")
                                << QStringLiteral("\\bimport\\b")
                                << QStringLiteral("\\bfunction\\b")
                                << QStringLiteral("\\bvar\\b")
                                << QStringLiteral("\\bbehavior\\b")
                                << QStringLiteral("\\bproperty\\b")
                                << QStringLiteral("\\balias\\b")
                                << QStringLiteral("\\bsignal\\b");
                Q_FOREACH (const QString &pattern, keywordPatterns) {
                    mHighlightingRules.append({ QRegularExpression(pattern), format });
                }
            }

            {
                QTextCharFormat format;
                format.setForeground(Qt::darkGreen);
                mHighlightingRules.append({ QRegularExpression(QStringLiteral("\\b[A-Z][A-Za-z]+[\\s]+(?=\\{)")),
                                           format });
            }

            {
                QTextCharFormat format;
                format.setForeground(Qt::darkMagenta);
                mHighlightingRules.append({ QRegularExpression(QStringLiteral("\".*\"")),
                                           format });
            }

            {
                QTextCharFormat format;
                format.setFontItalic(true);
                format.setForeground(Qt::blue);
                mHighlightingRules.append({ QRegularExpression(QStringLiteral("\\b[A-Za-z0-9_]+(?=\\()")),
                                           format });
            }

            {
                QTextCharFormat format;
                format.setForeground(Qt::darkBlue);
                mHighlightingRules.append({ QRegularExpression(QStringLiteral("//[^\n]*")),
                                           format });
            }

            {
                QTextCharFormat format;
                format.setFontItalic(true);
                mHighlightingRules.append({ QRegularExpression(QStringLiteral("\\b[a-z][A-Za-z0-9_]+[.]")),
                                           format });
            }

            {
                QTextCharFormat format;
                mHighlightingRules.append({ QRegularExpression(QStringLiteral("parent")),
                                           format } );
            }

            {
                QTextCharFormat format;
                format.setForeground(Qt::darkRed);
                mHighlightingRules.append({ QRegularExpression(QStringLiteral("\\b[a-z][A-Za-z0-9_]*[\\s]*(?=[:\{])")),
                                           format });
                mHighlightingRules.append({ QRegularExpression(QStringLiteral("\\b[a-z][A-Za-z0-9_]*[.][a-z][A-Za-z0-9_]*[\\s]*(?=[:\{])")),
                                           format });
            }

            mMultilineCommentFormat.setForeground(Qt::darkBlue);
            mCommentStartExpression = QRegularExpression(QStringLiteral("/\\*"));
            mCommentEndExpression = QRegularExpression(QStringLiteral("\\*/"));
        }
    }

    ~QMLSyntaxHighlighter()
    {
    }

    void highlightBlock(const QString &text) Q_DECL_OVERRIDE
    {
        Q_FOREACH(const HighlightingRule &rule, mHighlightingRules) {
            auto match = rule.pattern.match(text);
            if (match.hasMatch()) {
                for (int i = 0; i <= match.lastCapturedIndex(); ++i) {
                    setFormat(match.capturedStart(i), match.capturedLength(i), rule.format);
                }
            }
        }

        setCurrentBlockState(0);

        int startIndex = 0;
        if (previousBlockState() != 1) {
            auto match = mCommentStartExpression.match(text);
            startIndex = match.capturedStart();
        }

        while (startIndex >= 0) {
            auto match = mCommentEndExpression.match(text, startIndex);
            const int endIndex = match.capturedStart();
            int commentLength;
            if (endIndex == -1) {
                setCurrentBlockState(1);
                commentLength = text.length() - startIndex;
            } else {
                commentLength = endIndex - startIndex + match.capturedLength();
            }
            setFormat(startIndex, commentLength, mMultilineCommentFormat);
            startIndex = mCommentStartExpression.match(text, startIndex + commentLength).capturedStart();
        }
    }

private:
    struct HighlightingRule
    {
        QRegularExpression pattern;
        QTextCharFormat format;
    };

    static QVector<HighlightingRule> mHighlightingRules;
    static QTextCharFormat mMultilineCommentFormat;
    static QRegularExpression mCommentStartExpression;
    static QRegularExpression mCommentEndExpression;
};

QVector<QMLSyntaxHighlighter::HighlightingRule> QMLSyntaxHighlighter::mHighlightingRules;
QTextCharFormat QMLSyntaxHighlighter::mMultilineCommentFormat;
QRegularExpression QMLSyntaxHighlighter::mCommentStartExpression;
QRegularExpression QMLSyntaxHighlighter::mCommentEndExpression;


class QMLSyntaxHighlighterWrapper : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QQuickItem *textEdit READ textEdit WRITE setTextEdit)
public:
    QMLSyntaxHighlighterWrapper(QObject *parent = Q_NULLPTR)
        : QObject(parent)
        , mTextEdit(Q_NULLPTR)
    {
    }

    ~QMLSyntaxHighlighterWrapper()
    {
    }

    QQuickItem *textEdit() const
    {
        return mTextEdit;
    }

    void setTextEdit(QQuickItem *textEdit)
    {
        auto qmlDoc = textEdit->property("textDocument").value<QQuickTextDocument*>();
        if (!qmlDoc) {
            qWarning() << textEdit << "does not have a valid QQuickTextDocument";
            return;
        }

        mTextEdit = textEdit;
        new QMLSyntaxHighlighter(qmlDoc->textDocument());
    }

private:
    QQuickItem *mTextEdit;
};




int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);

    QCommandLineParser parser;
    QCommandLineOption fullscreenOption(QStringLiteral("fullscreen"));
    parser.addOption(fullscreenOption);
    parser.process(app);

    qmlRegisterType<QMLSyntaxHighlighterWrapper>("cz.dvratil", 1, 0, "QMLSyntaxHighlighter");

    QQuickView window(QUrl::fromLocalFile(QDir::currentPath() + QStringLiteral("/qml/main.qml")));
    if (parser.isSet(fullscreenOption)) {
        window.showFullScreen();
    } else {
        window.showNormal();
    }

    return app.exec();
}

#include "main.moc"

