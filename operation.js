WorkerScript.onMessage = function(src) {
    var txt = src[0]
    var countwords = src[1]
    txt = txt.replace(/[.,\/#!$%\^&\*;:{}=\-_`~()?]/g,"")
    //        .replace(/\s{2,}/g," ")
    var massive = []
    var names = []
    var cols = []
    var result = {}
    var words = txt.split(" ")

    words.forEach(function(a) {
        if (a !== "")
//            result[a] = (result[a] + 1) || 1
            if (result[a] !== undefined || result[a.toLowerCase()] !== undefined)
                    ++result[a];
                else
                    result[a] = 1;
    })

//    for (var i = 0; i < words.length; i++) {
//        if (words[i] !== "") {
//            var cnt = txt.split(words[i])
//            var exist = false

//            if (names.length)
//                names.forEach(function(item, j, arr) {
//                    if(item === words[i])
//                        exist = true
//                })

//            if(!exist) {
////                var wordx = [{"name": "", "count": 0}]
//                var wordx = []
//                names.push(words[i])
//                cols.push(cnt.length - 1)
//                wordx = [words[i],cnt.length - 1]
//                massive.push(wordx)
//            }
//        }
//    }
    for (var key in result) {console.debug(key, result[key])}
//    for (var key in massive) {console.debug(massive[key][0],massive[key][1])}
    sort_by_alphabets(sort_by_counts(massive,names,cols).slice(0, countwords))
    WorkerScript.sendMessage({'names': names,'counts': cols})
}

function sort_by_counts(massive) {
    return massive.sort(function(a,b) {return a[1] - b[1]}).reverse()
}

function sort_by_alphabets(massive) {
    massive.sort(function(a,b) {
        var aname = a[0].toLowerCase()
        var bname = b[0].toLowerCase()
        if(aname < bname) return -1
        if(aname > bname) return 1
    })
//    for (var key in massive) {console.debug(massive[key][0],massive[key][1])}
}
