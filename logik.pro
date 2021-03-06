######################################################################
# Automatically generated by qmake (3.1) Tue Apr 17 19:51:58 2018
######################################################################

TEMPLATE        = app
QT             += qml quick
CONFIG         += debug c++1z
TARGET          = logik
INCLUDEPATH    += .

# The following define makes your compiler warn you if you use any
# feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES        += QT_DEPRECATED_WARNINGS

MOC_DIR        += build
OBJECTS_DIR    += build

# Input
HEADERS        += src/item.h \
                  src/selection.h \
                  src/project.h \
                  src/element.h \
                  src/wire.h \
                  src/connector.h

SOURCES        += src/main.cpp \
                  src/item.cpp \
                  src/selection.cpp \
                  src/project.cpp \
                  src/element.cpp \
                  src/wire.cpp \
                  src/connector.cpp

RESOURCES      += qml/qml.qrc
