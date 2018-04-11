import QtQuick 2.7

Element {
    id: gpi

    desc: "GPI"
    name: "input"
    outputs: ["OUT1"]

    onOutputClicked: setOutput(n, !getOutput(n))
}
