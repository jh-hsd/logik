import QtQuick 2.7

Rectangle {
    id: parameterEntry

    width: parent.width
    height: applyBtn.height
    color: "white"
    anchors.top: parent.bottom
    anchors.topMargin: show ? -height : 0

    property bool show: false
    property var setup: null
    property alias btnText: applyBtn.text
    property alias text: input.text

    Behavior on anchors.topMargin {
        NumberAnimation { duration: 200 }
    }

    /*
     * param is an object with properties
     * - btnText: alternate apply button text, empty equals 'Apply'
     * - text: what goes into the text edit field
     * - callback: a function which is called on apply
     */
    function requestText(setup) {
        parameterEntry.setup = setup;
        if (!setup.btnText)
            parameterEntry.btnText = "Apply";
        else
            parameterEntry.btnText = setup.btnText;
        parameterEntry.text = setup.text;
        parameterEntry.show = true;
    }

    Button {
        id: applyBtn
        active: true
        width: 1.5 * label.paintedWidth
        height: 2 * label.paintedHeight
        text: "Apply"

        onClicked: {
            if (!setup || !show) return;
            setup.callback(parameterEntry.text);
            show = false;
        }
    }
    
    TextInput {
        id: input
        anchors.left: applyBtn.right
        anchors.right: parent.right
        height: parent.height
        verticalAlignment: TextInput.AlignVCenter
    }
}
