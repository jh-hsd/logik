import QtQuick 2.7
import ".."

Element {
    id: padOut

    desc: "Pad"
    name: "output"
    archs: ["Component"]
    inputs: ["IN"]

    onModify: conn.value = !conn.value
}
