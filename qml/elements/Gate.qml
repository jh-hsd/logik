import QtQuick 2.7
import ".."

Element {
    id: gate

    desc: qsTr("*")
    name: qsTr("Gate")
    inputs: ["IN", "ONOFF"]
    outputs: ["OUT"]

    onEvaluate: {
        var a = input("IN");
        var b = input("ONOFF");
        if (!!b.value)
            setOutput("OUT", a.value);
        else
            setOutput("OUT", 0);
    }
}
