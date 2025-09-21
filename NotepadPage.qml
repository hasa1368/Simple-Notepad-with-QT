import QtQuick 6.6
import QtQuick.Controls 6.6
import QtQuick.Layouts 6.6
import Qt.labs.platform 1.1
import QtQuick.Controls.Material 6.6
import Qt5Compat.GraphicalEffects

Item {
    id: root
    property string user: ""

    Rectangle {
        anchors.fill: parent
        color: "#f0f2f5"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 12

            // Display Username
            Text {
                text: "Welcome " + root.user
                font.pixelSize: 26
                font.bold: true
                color: "#2c3e50"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }

            // Scrollable TextArea
            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                Rectangle {
                    color: "#ffffff"
                    radius: 12
                    border.color: "#dcdde1"
                    border.width: 1
                    anchors.fill: parent
                    layer.enabled: true
                    layer.effect: DropShadow {
                        horizontalOffset: 0
                        verticalOffset: 4
                        radius: 12
                        color: "#40000000"
                    }

                    TextArea {
                        id: editor
                        anchors.fill: parent
                        wrapMode: Text.Wrap
                        font.pixelSize: 16
                        placeholderText: "Type your notes here..."
                        color: "#2f3640"
                        padding: 10
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                //   Save
                Button {
                    text: "Save"
                    Layout.fillWidth: true
                    font.pixelSize: 16
                    font.bold: true
                    background: Rectangle {
                        radius: 12
                        color: "#44bd32"
                        border.color: "#27ae60"
                    }
                    hoverEnabled: true
                    onClicked: saveDialog.open()
                }

                //   Open
                Button {
                    text: "Open"
                    Layout.fillWidth: true
                    font.pixelSize: 16
                    font.bold: true
                    background: Rectangle {
                        radius: 12
                        color: "#487eb0"
                        border.color: "#40739e"
                    }
                    hoverEnabled: true
                    onClicked: openDialog.open()
                }

                // Return
                Button {
                    text: "Back to Login"
                    Layout.fillWidth: true
                    font.pixelSize: 16
                    font.bold: true
                    background: Rectangle {
                        radius: 12
                        color: "#e84118"
                        border.color: "#c23616"
                    }
                    hoverEnabled: true
                    onClicked: stack.pop()
                }
            }
        }

        // --- Save Dialog ---
        FileDialog {
            id: saveDialog
            title: "Save File"
            fileMode: FileDialog.SaveFile
            nameFilters: ["Text files (*.txt)"]
            onAccepted: {
                if (saveDialog.file) {
                    var path = saveDialog.file.toString()
                    if (path.startsWith("file:///"))
                        path = path.substring(8)
                    var success = fileManager.saveFile(path, editor.text)
                    if (success) console.log("File saved successfully")
                    else console.log("Cannot save file")
                }
            }
        }

        // --- Open Dialog ---
        FileDialog {
            id: openDialog
            title: "Open File"
            fileMode: FileDialog.OpenFile
            nameFilters: ["Text files (*.txt)"]
            onAccepted: {
                if (openDialog.file) {
                    var path = openDialog.file.toString()
                    if (path.startsWith("file:///"))
                        path = path.substring(8)
                    var content = fileManager.openFile(path)
                    if (content !== "") editor.text = content
                    else console.log("Cannot open file")
                }
            }
        }
    }
}
