import QtQuick 2.7
import ".."

Element {
    id: not

    desc: qsTr("!")
    name: qsTr("not")
    inputs: ["IN"]
    outputs: ["OUT"]
    evalCode: "setOutput('OUT', !inputValue('IN'))"
}
