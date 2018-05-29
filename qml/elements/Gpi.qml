import QtQuick 2.7
import ".."

Element {
    id: gpi

    desc: qsTr("GPI")
    name: qsTr("input")
    param: "1"
    archs: ["RPi", "Arduino"]
    outputs: ["OUT"]
    evalCode: "mapOutputToPin('OUT', pin(gpi.param))"

    onModify: conn.value = !conn.value
}
