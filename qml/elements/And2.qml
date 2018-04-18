import QtQuick 2.7

Element {
    id: and2

    desc: "&"
    name: "and2"
    inputs: ["IN1", "IN2"]
    outputs: ["OUT"]

    onModify: {
        if (conn.direction == "in")
            conn.value = !conn.value;
    }

    onEvaluate: {
        var a = getInputByName("IN1");
        var b = getInputByName("IN2");
        setOutputByName("OUT", !!a & !!b);
    }
}
