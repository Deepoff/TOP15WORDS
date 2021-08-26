WorkerScript.onMessage = function(txt) {
    txt = txt.replace(/[.,\/#!$%\^&\*;:{}=\-_`~()?]/g,"")
    //        .replace(/\s{2,}/g," ")
    var massive = []
    var names = []
    var cols = []
    var words = txt.split(" ")
    for (var i = 0; i < words.length; i++) {
        if (words[i] !== "") {
            var cnt = txt.split(words[i])
            var exist = false

            if (names.length)
                names.forEach(function(item, j, arr) {
                    if(item === words[i])
                        exist = true
                })

            if(!exist) {
//                var wordx = [{"name": "", "count": 0}]
                names.push(words[i])
                cols.push(cnt.length - 1)
//                massive.push(wordx)
            }
        }
    }

//    massive = [{"name":"dfsd", "count": 12}]

//    for (var key in massive) {console.debug(massive[key].name,massive[key].count)}

    WorkerScript.sendMessage({'names': names,'counts': cols})
}
