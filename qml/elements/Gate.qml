import QtQuick 2.7
import ".."

Element {
    id: gate

    desc: qsTr("*")
    name: qsTr("Gate")
    inputs: ["IN", "ONOFF"]
    outputs: ["OUT"]
    evalCode: "setOutput('OUT', !!inputValue('ONOFF') ? inputValue('IN') : 0"
}
