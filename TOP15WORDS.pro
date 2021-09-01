TEMPLATE = app
TARGET  = Top15Words

win32:      {
                RC_ICONS = icon.ico
                OS_SUFFIX = win32
                DESTDIR = Bin
                VERSION = $$system(D:\OLD\Program_Files\Git\cmd\git.exe rev-parse --abbrev-ref HEAD)
            }
linux-g++:  {
                OS_SUFFIX = linux
                VERSION = $$system(git rev-parse --abbrev-ref HEAD)
            }

BUILDSTR = $$system(D:\OLD\Program_Files\Git\cmd\git.exe describe --abbrev=12 --always --dirty=+)

QMAKE_TARGET_COPYRIGHT = (c) 2GIS LLC

DEFINES += APP_VERSION=\\\"$$VERSION\\\"    \
           APP_BUILD=\\\"$$BUILDSTR\\\" \

QT += quick qml quickcontrols2 charts

CONFIG += c++11

CONFIG(debug, debug|release) {
        BUILD_FLAG = debug
        LIB_SUFFIX = d
} else {
        BUILD_FLAG = release
        win32:QMAKE_POST_LINK += windeployqt --qmldir $$PWD/ --no-translations $$DESTDIR
  }

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
