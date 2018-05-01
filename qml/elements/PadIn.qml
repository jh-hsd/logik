import QtQuick 2.7
import ".."

Element {
    id: padIn

    desc: "Pad"
    name: "input"
    archs: ["Component"]
    outputs: ["OUT"]

    onModify: conn.value = !conn.value
}
