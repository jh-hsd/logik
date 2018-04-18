import QtQuick 2.7

Element {
    id: not

    desc: "!"
    name: "not"
    inputs: ["IN"]
    outputs: ["OUT"]

    onModify: {
        if (conn.direction == "in")
            conn.value = !conn.value;
    }

    onEvaluate: {
        var s = getInputByName("IN");
        setOutputByName("OUT", !s);
    }
}
