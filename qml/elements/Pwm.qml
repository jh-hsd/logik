import QtQuick 2.7
import ".."

Element {
    id: pwm

    desc: qsTr("PWM")
    name: qsTr("control")
    param: "0"
    archs: ["RPi", "Arduino"]
    outputs: ["OUT"]

    onModify: {
        var v = conn.value + direction;
        if (v == 256)
            conn.value = 255;
        else if (v < 0)
            conn.value = 0;
        else
            conn.value = v;
        param = conn.value.toString();
    }
}
