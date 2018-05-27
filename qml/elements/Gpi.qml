import QtQuick 2.7
import ".."

Element {
    id: gpi

    desc: qsTr("GPI")
    name: qsTr("input")
    param: "1"
    archs: ["RPi", "Arduino"]
    outputs: ["OUT"]

    onModify: conn.value = !conn.value
}
