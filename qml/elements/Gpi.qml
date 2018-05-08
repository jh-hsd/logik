import QtQuick 2.7
import ".."

Element {
    id: gpi

    desc: qsTr("GPI")
    name: qsTr("input")
    archs: ["RPi"]
    outputs: ["OUT"]

    onModify: conn.value = !conn.value
}
