Item {
	anchors.fill: parent
	Column {
		width: parent.width
		height: parent.height
		Column {
			width: 450
			height: 115
			Rectangle {
				width: parent.width
				height: parent.height - 10
				color: "#141414"
				radius: 5
				Column {
					x: 10
					y: 10
					width: parent.width - 20
					spacing: 0
					Text {
						color: theme.primarytextcolor
						text: "Thêm đèn bằng địa chỉ IP"
						font.pixelSize: 16
						font.family: "Poppins"
						font.bold: true
					}
					Row {
						spacing: 6
						Image {
							x: 10
							y: 6
							height: 50
							source: "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/logo.png"
							fillMode: Image.PreserveAspectFit
							antialiasing: false
							mipmap: false
						}
						Rectangle {
							x: 10
							y: 6
							width: 200
							height: 50
							radius: 5
							border.color: "#1c1c1c"
							border.width: 2
							color: "#141414"
							TextField {
								width: 180
								leftPadding: 10
								rightPadding: 10
								id: discoverIP
								x: 10
								color: theme.primarytextcolor
								font.family: "Poppins"
								font.bold: true
								font.pixelSize: 20
								verticalAlignment: TextInput.AlignVCenter
								placeholderText: "192.168.0.1"
								onEditingFinished: {
									discovery.forceDiscover(discoverIP.text);
								}
								validator: RegularExpressionValidator {
									regularExpression:  /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){0,3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
								}
								background: Item {
									width: parent.width
									height: parent.height
									Rectangle {
										color: "transparent"
										height: 1
										width: parent.width
										anchors.bottom: parent.bottom
									}
								}
							}
						}
					}
				}
				Column {
					x: 260
					y: 4
					width: parent.width - 20
					spacing: 10
					Image {
						x: 10
						y: 10
						height: 50
						source: "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/logo-2.png"
						fillMode: Image.PreserveAspectFit
						antialiasing: false
						mipmap: false
					}
				}
				Column {
					x: 285
					y: 60
					width: parent.width - 20
					spacing: 10
					Item{
						Rectangle {
							width: 120
							height: 26
							color: "#D65A00"
							radius: 5
						}
						width: 120
						height: 26
						ToolButton {
							height: 30
							width: 120
							anchors.verticalCenter: parent.verticalCenter
							font.family: "Poppins"
							font.bold: true
							icon.source: "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/icon-discover.png"
							text: "Tìm kiếm"
							anchors.right: parent.right
							onClicked: {
								discovery.forceDiscover(discoverIP.text);
							}
						}
					}
				}
			}
		}

		ListView {
			id: controllerList
			model: service.controllers
			width: contentItem.childrenRect.width + (controllerListScrollBar.width * 1.5)
			height: parent.height - 265
			clip: true

			ScrollBar.vertical: ScrollBar {
				id: controllerListScrollBar
				anchors.right: parent.right
				width: 10
				visible: parent.height < parent.contentHeight
				policy: ScrollBar.AlwaysOn

				height: parent.availableHeight
				contentItem: Rectangle {
					radius: parent.width / 2
					color: theme.scrollBar
				}
			}


			delegate: Item {
				visible: true
				width: 450
				height: 115
				property var device: model.modelData.obj

				Rectangle {
					width: parent.width
					height: parent.height - 10
					color: device.offline ? "#101010" : device.connected ? "#003EFF" : "#292929"
					radius: 5
				}
				Column {
					x: 260
					y: 4
					width: parent.width - 20
					spacing: 10
					Image {
						x: 10
						y: 10
						height: 50
						source: device.offline ? "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/logo-white.png" : device.connected ? "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/logo-2.png" : "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/logo-white.png"
						fillMode: Image.PreserveAspectFit
						antialiasing: false
						mipmap: false
					}
				}
				Column {
					x: 285
					y: 60
					width: parent.width - 20
					spacing: 10
					Item{
						Rectangle {
							width: 120
							height: 26
							color: device.offline ? "#C0A21B" : device.connected ? "#292929" : "#003EFF"
							radius: 5
							MouseArea {
								anchors.fill: parent
								acceptedButtons: Qt.NoButton
								cursorShape: Qt.ForbiddenCursor
							}
						}
						width: 120
						height: 26
						ToolButton {
							height: 30
							width: 120
							anchors.verticalCenter: parent.verticalCenter
							font.family: "Poppins"
							font.bold: true
							visible: device.offline ? false : device.connected
							text: "Gỡ"
							anchors.right: parent.right
							onClicked: {
								device.startRemove();
							}
						}
						ToolButton {
							height: 30
							width: 120
							anchors.verticalCenter: parent.verticalCenter
							font.family: "Poppins"
							font.bold: true
							visible: device.offline ? false : !device.connected
							text: "Kết nối"
							anchors.right: parent.right
							onClicked: {
								device.startLink();
							}
						}
						Text {
							anchors.verticalCenter: parent.verticalCenter
							anchors.horizontalCenter: parent.horizontalCenter
							color: theme.primarytextcolor
							font.pixelSize: 15
							font.family: "Poppins"
							font.bold: true
							visible: device.offline
							text: "Mất kết nối!"
						}
					}
				}
				Column {
					x: 10
					y: 4
					spacing: 6
					Row {
						width: parent.width - 20
						spacing: 6

						Text {
							color: theme.primarytextcolor
							text: device.name
							font.pixelSize: 16
							font.family: "Poppins"
							font.bold: true
						}
						Image {
							y: 3
							id: iconSignalStrength
							source: device.offline ? "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/device-offline.png" : device.signalstrength >= 90 ? "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/device-signal4.png" : device.signalstrength >= 75 ? "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/device-signal3.png" : device.signalstrength >= 60 ? "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/device-signal2.png" : device.signalstrength >= 50 ? "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/device-signal1.png" : "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/device-signal0.png"
						}
					}
					Row {
						spacing: 6
						Image {
							visible: device.offline ? false : true
							id: iconTurnOn
							source: "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/device-turnon.png"
							width: 16; height: 16
							opacity: 1.0
							MouseArea {
								anchors.fill: parent
								hoverEnabled: true
								acceptedButtons: Qt.LeftButton
								onClicked: {
									 device.turnOn();
								}
								onEntered: {
									iconTurnOn.opacity = 0.8;
								}
								onExited: {
									iconTurnOn.opacity = 1.0;
								}
							}
						}
						Image {
							visible: device.offline ? false : true
							id: iconTurnOff
							source: "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/device-turnoff.png"
							width: 16; height: 16
							opacity: 1.0
							MouseArea {
								anchors.fill: parent
								hoverEnabled: true
								acceptedButtons: Qt.LeftButton
								onClicked: {
									 device.turnOff();
								}
								onEntered: {
									iconTurnOff.opacity = 0.8;
								}
								onExited: {
									iconTurnOff.opacity = 1.0;
								}
							}
						}
						Image {
							id: iconDelete
							source: "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/device-delete.png"
							width: 16; height: 16
							visible: device.forced ? true : false
							opacity: 1.0
							MouseArea {
								anchors.fill: parent
								hoverEnabled: true
								acceptedButtons: Qt.LeftButton
								onClicked: {
									 device.startDelete();
								}
								onEntered: {
									iconDelete.opacity = 0.8;
								}
								onExited: {
									iconDelete.opacity = 1.0;
								}
							}
						}
						Image {
							id: iconForceAdd
							source: "https://raw.githubusercontent.com/zippo-2024/Skydimond-WiFi/main/images/device-forceadd.png"
							width: 16; height: 16
							visible: device.forced ? false : true
							opacity: 1.0
							MouseArea {
								anchors.fill: parent
								hoverEnabled: true
								acceptedButtons: Qt.LeftButton
								onClicked: {
									 device.startForceDiscover();
								}
								onEntered: {
									iconForceAdd.opacity = 0.8;
								}
								onExited: {
									iconForceAdd.opacity = 1.0;
								}
							}
						}
					}
					Text {
						color: theme.primarytextcolor
						text: "MAC: " + device.mac + "  |  IP: " + device.ip
					}
					Text {
						color: theme.primarytextcolor
						text: "Số bóng LED: " + device.deviceledcount
					}
				}
			}
		}
	}
}
