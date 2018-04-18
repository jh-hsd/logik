import QtQuick 2.7
import QtQuick.Layouts 1.3

import "./elements" as Element

ColumnLayout {
    id: selection
    spacing: 2

    signal placeInProject(string comp)

    Button {
        text: "Simulate"
    }

    Button {
        text: "Run"
    }
    
    Flow {
        width: parent.width
        spacing: 2 * connectorSize
        padding: spacing

        Layout.preferredWidth: width
        Layout.fillHeight: true

        Element.Not {
            onClicked: selection.placeInProject("Not")
        }
        Element.And2 {
            onClicked: selection.placeInProject("And2")
        }
        Element.Or2 {
            onClicked: selection.placeInProject("Or2")
        }
        Element.Gpi {
            onClicked: selection.placeInProject("Gpi")
        }
        Element.Gpo {
            onClicked: selection.placeInProject("Gpo")
        }
    }

    Button {
        text: "Architecture<br><b>" + architecture + "</b>"
        active: !!architecture

        onClicked: {
            var i = supportedArchitectures.indexOf(architecture);
            i++;
            if (i == supportedArchitectures.length)
                i = 0;
            architecture = supportedArchitectures[i];
        }
    }
}
