import QtQuick 2.7
import QtQuick.Layouts 1.3

import "./elements" as Element

ColumnLayout {
    id: selection
    spacing: 2

    signal placeInProject(string comp)

    Button {
        text: {
            switch (main.operationMode) {
            case "sim" : return "Run";
            case "run" : return "Simulation";
            }
        }
        onClicked: {
            switch (main.operationMode) {
            case "sim" :
                main.operationMode = "run";
                break;
            case "run" :
                main.operationMode = "sim";
                break;
            }
        }
    }

    Button {
        text: "Architecture<br><b>" + architecture + "</b>"
        active: !!architecture

        onClicked: {
            var i = main.architectures.indexOf(architecture);
            i++;
            if (i == main.architectures.length)
                i = 0;
            architecture = main.architectures[i];
        }
    }

    Button {
        text: "Save"

        onClicked: project.save()
    }
    
    Flow {
        width: parent.width
        spacing: 2 * connectorSize
        padding: spacing

        Layout.preferredWidth: width
        Layout.fillHeight: true

        Repeater {
            model: main.elements
            delegate: Loader {
                id: elementLoader
                asynchronous: false
                source: "./elements/" + modelData + ".qml"

                Connections {
                    target: item
                    ignoreUnknownSignals: true
                    onClicked: selection.placeInProject(modelData);
                }
            }
        }
    }
}
