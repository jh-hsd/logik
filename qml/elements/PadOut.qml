import QtQuick 2.7
import ".."

Element {
    id: padOut

    desc: "PAD"
    name: "output"
    archs: ["Component"]
    inputs: ["IN"]

    onModify: conn.value = !conn.value
}
