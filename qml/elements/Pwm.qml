import QtQuick 2.7
import ".."

Element {
    id: pwm

    desc: "PWM"
    name: "control"
    archs: ["RPi", "Arduino"]
    outputs: ["OUT"]

    onModify: {
        if (conn.value == 255)
            conn.value = 0;
        else
            conn.value += 1;
    }
}
