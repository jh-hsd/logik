import QtQuick 2.7

import "./elements" as Element

Flow {
    spacing: connectorSize
    padding: spacing
    Element.Not {}
    Element.And2 {}
    Element.And4 {}
    Element.Or2 {}
    Element.Or4 {}
    Element.Gpi {}
    Element.Gpo {}
}
