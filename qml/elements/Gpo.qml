import QtQuick 2.7

Element {
    id: gpo

    desc: "GPO"
    name: "output"
    archs: ["RPi"]
    inputs: ["IN"]

    onModify: conn.value = !conn.value
}
