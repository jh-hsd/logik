import QtQuick 2.7
import ".."

Element {
    id: and

    desc: qsTr("&")
    name: qsTr("and")
    inputs: ["IN1", "IN2"]
    outputs: ["OUT"]

    onEvaluate: {
        var a = input("IN1");
        var b = input("IN2");
        setOutput("OUT", !!a.value & !!b.value);
    }
}
