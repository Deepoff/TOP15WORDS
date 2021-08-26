import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtCharts 2.2


Window {
    id: app
    visible: true
    width: 640
    height: 480
    title: qsTr("TOP 15 WORDS")

    property variant words: []
    property variant counts: []

    ColumnLayout {
        anchors.fill: parent
        ChartView {
            title: "TOP 15 WORDS"
//            anchors.fill: parent
            antialiasing: true
            Layout.fillWidth: true
            Layout.fillHeight: true

            HorizontalBarSeries {
                id: top15Bars

                axisY: BarCategoryAxis {
                    id: barCategoryAxis
//                    categories: words
                    labelsVisible: true
//                    labelsColor: "black"
//                    labelsFont: Qt.font({pixelSize: 12})
//                    titleText: qsTr("Words")
                }
                axisX: ValueAxis {
                    id: valueAxisY
                    min: 0
//                    tickCount: 100
                    gridVisible: true
                    labelsColor: "black"
                    labelsFont: Qt.font({pixelSize: 12})
                    titleText: qsTr("Count")
                    labelFormat: "%.1f"
                }

                BarSet {
                    id: barSet
//                    values: counts
                }
            }
        }

        TextEdit {
            id: name
            text: qsTr("")
            Layout.fillWidth: true
            focus: true
//            Layout.fillHeight: true

            onTextChanged: {

                operator.sendMessage(text)

//                words = []
//                counts = []
//                for (var key in massall) {
//                    words.push(massall[key].name)
//                    counts.push(massall[key].count)
//                }

//                barCategoryAxis.categories = words
//                barSet.values = counts
            }
        }

    }

//    function words_range(txt) {
//        txt = txt.replace(/[.,\/#!$%\^&\*;:{}=\-_`~()?]/g,"")
////        .replace(/\s{2,}/g," ")

//        var massive = []
//        var words = txt.split(" ")
//        var iter = 0
//        for (var i = 0; i < words.length; i++) {
//            if (words[i] !== "") {
//                var cnt = txt.split(words[i])
//                var exist = false

//                if (massive.length)
//                    massive.forEach(function(item, j, arr) {
//                        if(item.name === words[i])
//                            exist = true
//                    })

//                if(!exist) {
//                    iter += 1
//                    var wordx = [{"name": "", "count": 0}]
//                    wordx.name = words[i]
//                    wordx.count = cnt.length - 1
//                    massive.push(wordx)
//                }
//            }
//        }

////        for (var key in massive) {console.debug(massive[key].name,massive[key].count)}
//        return (massive)
//    }

    WorkerScript {
        id: operator
        source: "operation.js"
        onMessage: {
//            words = []
//            counts = []
            barCategoryAxis.categories = messageObject.names
            barSet.values = messageObject.counts
            valueAxisY.max = Math.max.apply(null,messageObject.counts)
//            console.debug(Math.max.apply(null,counts))
        }
    }
//    Component.onCompleted: operator.sendMessage("text")
}
