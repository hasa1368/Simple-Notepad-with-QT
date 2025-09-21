import QtQuick 6.6
import QtQuick.Controls 6.6
import QtQuick.Layouts 1.6

Item {
    id: root
    anchors.fill: parent
    Rectangle {
        anchors.fill: parent
        color: "#f0f2f5"

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 16
            width: parent.width * 0.45

            // title
            Text {
                text: "Welcome to Simple Notepad"
                font.pixelSize: 28
                font.bold: true
                color: "#2c3e50"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Username
            Rectangle {
                radius: 10
                color: "#ffffff"
                border.color: "#dcdde1"
                border.width: 1
                height: 45
                Layout.fillWidth: true

                TextField {
                    id: username
                    placeholderText: "Username"
                    anchors.fill: parent
                    anchors.margins: 8
                    font.pixelSize: 16
                    background: null
                }
            }

            // Password
            Rectangle {
                radius: 10
                color: "#ffffff"
                border.color: "#dcdde1"
                border.width: 1
                height: 45
                Layout.fillWidth: true

                TextField {
                    id: password
                    placeholderText: "Password"
                    echoMode: TextInput.Password
                    anchors.fill: parent
                    anchors.margins: 8
                    font.pixelSize: 16
                    background: null
                }
            }

            // Successful message
            Text {
                id: errorLabel
                text: ""
                color: "#e74c3c"
                font.pixelSize: 14
                wrapMode: Text.Wrap
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            // Buttons
            RowLayout {
                Layout.fillWidth: true
                spacing: 12

                // Register
                Button {
                    text: "Register"
                    Layout.fillWidth: true
                    font.pixelSize: 16
                    font.bold: true
                    background: Rectangle {
                        radius: 12
                        color: "#44bd32"
                        border.color: "#27ae60"
                    }
                    hoverEnabled: true
                    onClicked: {
                        errorLabel.text = ""
                        if (username.text.length===0 || password.text.length===0) {
                            errorLabel.text = "Enter username and password"
                            return
                        }
                        var ok = DatabaseManager.createUser(username.text, password.text)
                        if(ok) {
                            errorLabel.color = "#27ae60"
                            errorLabel.text = "User registered successfully"
                        } else {
                            errorLabel.color = "#e74c3c"
                            errorLabel.text = "Registration failed (username may exist)"
                        }
                    }
                }

                // Login
                Button {
                    text: "Login"
                    Layout.fillWidth: true
                    font.pixelSize: 16
                    font.bold: true
                    background: Rectangle {
                        radius: 12
                        color: "#487eb0"
                        border.color: "#40739e"
                    }
                    hoverEnabled: true
                    onClicked: {
                        errorLabel.text = ""
                        if (username.text.length===0 || password.text.length===0) {
                            errorLabel.text = "Enter username and password"
                            return
                        }

                        var valid = DatabaseManager.validateUser(username.text, password.text)
                        if(!valid) {
                            errorLabel.color = "#e74c3c"
                            errorLabel.text = "Invalid username or password"
                            return
                        }

                        // Push to NotepadPage
                        var pageUrl = "NotepadPage.qml"
                        console.log("Pushing page:", pageUrl)
                        stack.push(pageUrl, { user: username.text })
                    }
                }
            }
        }
    }
}
