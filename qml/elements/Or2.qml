import QtQuick 2.7

Element {
    id: or2

    desc: "|"
    name: "or2"
    inputs: ["IN1", "IN2"]
    outputs: ["OUT"]

    onModify: {
        if (conn.direction == "in")
            conn.value = !conn.value;
    }

    onEvaluate: {
        var a = getInputByName("IN1");
        var b = getInputByName("IN2");
        setOutputByName("OUT", !!a || !!b);
    }
}
