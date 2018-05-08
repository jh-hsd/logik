import QtQuick 2.7
import ".."

Element {
    id: and

    desc: qsTr("&")
    name: qsTr("and")
    inputs: ["IN1", "IN2"]
    outputs: ["OUT"]

    onEvaluate: {
        var a = getInputByName("IN1");
        var b = getInputByName("IN2");
        setOutputByName("OUT", !!a & !!b);
    }
}
