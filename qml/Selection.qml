import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.0

import org.jh 1.0
import "./elements" as Element

BaseSelection {
    id: selection

    ColumnLayout {
        anchors.fill: parent
        spacing: 2

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
                var i = selection.architectures.indexOf(architecture);
                i++;
                if (i == selection.architectures.length)
                    i = 0;
                architecture = selection.architectures[i];
            }
        }

        Button {
            text: "Save"

            onClicked: fileDialog.visible = true

            FileDialog {
                id: fileDialog
                title: "Select project file"
                selectMultiple: false
                selectFolder: false
                folder: shortcuts.home
                nameFilters: [ "XML files (*.xml)" ]
                selectExisting: false
                onAccepted: {
                    project.save(fileDialog.fileUrl);
                    visible = false;
                }
            }
        }

        Flickable {
            width: parent.width

            Layout.preferredWidth: width
            Layout.fillHeight: true

            clip: true
            contentWidth: width
            contentHeight: elementFlow.height

            Flow {
                id: elementFlow
                width: parent.width
                height: implicitHeight
                spacing: 2 * connectorSize
                padding: spacing
                
                Repeater {
                    model: selection.elements
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
    }
}
