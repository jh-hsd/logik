import QtQuick 2.7
import ".."

Element {
    id: or

    desc: qsTr("|")
    name: qsTr("or")
    inputs: ["IN1", "IN2"]
    outputs: ["OUT"]
    evalCode: "setOutput('OUT', !!inputValue('IN1') || !!inputValue('IN2'))"
}
