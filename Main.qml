import QtQuick 6.6
import QtQuick.Controls 6.6

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Notepad App"

    StackView {
        id: stack
        anchors.fill: parent

        initialItem: LoginPage {}

    }
}
