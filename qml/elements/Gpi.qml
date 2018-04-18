import QtQuick 2.7

Element {
    id: gpi

    desc: "GPI"
    name: "input"
    archs: ["RPi"]
    outputs: ["OUT"]

    onModify: conn.value = !conn.value
}
