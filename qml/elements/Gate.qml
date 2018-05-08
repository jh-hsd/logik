import QtQuick 2.7
import ".."

Element {
    id: gate

    desc: qsTr("*")
    name: qsTr("Gate")
    inputs: ["IN", "ONOFF"]
    outputs: ["OUT"]

    onEvaluate: {
        var a = getInputByName("IN");
        var b = getInputByName("ONOFF");
        if (!!b)
            setOutputByName("OUT", a);
        else
            setOutputByName("OUT", 0);
    }
}
