import QtQuick 2.7

Rectangle {
    id: parameterEntry

    width: parent.width
    height: applyBtn.height
    color: "white"
    anchors.top: parent.bottom
    anchors.topMargin: show ? -height : 0

    property bool show: false
    property alias btnText: applyBtn.text
    property alias text: input.text
    property var sourceObj: null

    Behavior on anchors.topMargin {
        NumberAnimation { duration: 200 }
    }

    function requestText(obj, btnText, text) {
        parameterEntry.sourceObj = obj;
        if (!btnText)
            parameterEntry.btnText = "Apply";
        else
            parameterEntry.btnText = btnText;
        parameterEntry.text = text;
        parameterEntry.show = true;
    }

    Button {
        id: applyBtn
        active: true
        width: 1.5 * label.paintedWidth
        height: 2 * label.paintedHeight
        text: "Apply"

        onClicked: {
            if (!sourceObj || !show) return;
            sourceObj.textChange(parameterEntry.text);
            sourceObj = null;
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
