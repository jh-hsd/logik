import QtQuick 2.7
import ".."

Element {
    id: gpo

    desc: qsTr("GPO")
    name: qsTr("output")
    param: "1"
    archs: ["RPi", "Arduino"]
    inputs: ["IN"]
}
