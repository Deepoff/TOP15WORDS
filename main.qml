import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtCharts 2.2
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0 as Labs


ApplicationWindow {
    id: app
    visible: true
    width: 640
    height: 800
    title: qsTr("TOP 15 WORDS")

    property int topwords: 15

    header: ToolBar {
        id: mainToolbar
        anchors.right: parent.right
        anchors.left: parent.left

        RowLayout {
            anchors.fill: parent

            OpenButton {
                id: openButton
                visible: true
                Layout.fillHeight: true
                onClicked: {openFileDialog.open(); btn_state = 1}
            }
            Label {
                id: labelName
                text: "TOP 15 WORDS"
                font.bold: true
                font.pixelSize: 20
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            AboutButton {
                id: aboutButton
                onClicked: {popupAbout.open(); btn_state = 1}
            }

            Popup {
                id: popupAbout

//                parent: Overlay.overlay

                contentItem:
                    Text {
                    id: about1
                    font.pixelSize: 15
                    //            fontsize: 15
                    anchors.fill: parent
                    anchors.margins: parent.width/50
                    text: "Application version: " + APP_VERSION +
                          "\n" + "Number of build: " + APP_BUILD +
                          "\n" + "Date of build: " + DATESTR
                }

                x: Math.round((app.width - width) / 2)
                y: Math.round((app.height - height) / 2)
                width: app.width/1.5
                height: app.height/3
                onClosed: aboutButton.btn_state = 0
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        ChartView {
            id: chartView
            antialiasing: true
            dropShadowEnabled: true
//            title: "TOP 15 WORDS!"
            Layout.fillWidth: true
            Layout.fillHeight: true
            theme: ChartView.ChartThemeBlueCerulean

            HorizontalBarSeries {
                id: top15Bars
                barWidth: 0.8
                labelsFormat: ""
                visible: true
                labelsVisible: true
                useOpenGL: true

                axisY: BarCategoryAxis {
                    id: barCategoryAxis
                    labelsVisible: true
                    labelsFont: Qt.font({pixelSize: 15})
                }
                axisX: ValueAxis {
                    id: valueAxisY
                    min: 0
                    tickCount: 1
                    gridVisible: true
//                    labelsColor: "black"
                    labelsFont: Qt.font({pixelSize: 15})
                    titleText: qsTr("Count")
                    labelFormat: "%.1f"          
                }

                BarSet {
                    id: barSet
                }
            }
        }

        ProgressBar {
            id: progressBar
            Layout.fillWidth: true
            Layout.minimumHeight: 50
            from: 0
            to: 1
        }

//        TextEdit {
//            id: name
//            text: qsTr("")
//            Layout.fillWidth: true
//            Layout.maximumHeight: 100
//            focus: true

//            onTextChanged: {
//                var msg = [text,topwords]
//                threaded_operator.sendMessage(msg)
//            }
//        }
    }

    WorkerScript {
        id: threaded_operator
        source: "operation.js"
        onMessage: {
            if(messageObject.complete) {
                progressBar.value = 0
                barCategoryAxis.titleText = "Words"
                barCategoryAxis.categories = messageObject.names
                barSet.values = messageObject.counts
                valueAxisY.max = Math.max.apply(null,messageObject.counts)
            }
            else
                progressBar.value = messageObject.progress
        }
    }

    FileDialog {
        id: openFileDialog
        nameFilters: ["Text files (*.txt)", "All files (*)"]
        onAccepted: {
            var msg = [openFile(openFileDialog.fileUrl),topwords]
            threaded_operator.sendMessage(msg)
            chartView.title = nameFile(openFileDialog.fileUrl)
//            name.text = openFile(openFileDialog.fileUrl);
            openButton.btn_state = 0
        }
        onRejected: openButton.btn_state = 0
        folder: Labs.StandardPaths.writableLocation(Labs.StandardPaths.DocumentsLocation)
    }
    function openFile(fileUrl) {
        var request = new XMLHttpRequest();
        request.open("GET", fileUrl, false);
        request.send(null);
        return request.responseText;
    }
    function nameFile(fileUrl) {
        var name = fileUrl.toString()
        name = name.slice(name.lastIndexOf("/")+1, name.indexOf("."))
        return name
    }
}
