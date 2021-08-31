WorkerScript.onMessage = function(src) {
    var txt = src[0]
    var countwords = src[1]
    var smooth_count = 100
    txt = txt.replace(/[.,\/#!$%\^&\*;:{}=\-_`~()?"]/g,"")
            .replace(/[\s+\r?\n]+/g," ")
    var names = []
    var cols = []
    var result = []
    var words = txt.split(" ")

    words.forEach(function(word,i,arr) {
        var word_l = word.trim()
        if (word_l !== "") {
            var b = arr.find(function(element){return element.toLowerCase() === word_l.toLowerCase()})
            result[b] = (result[b] + 1) || 1
            WorkerScript.sendMessage({'progress': i/arr.length, 'complete': false})

            if(i % Math.floor(arr.length/smooth_count) == 0) {
                var names_loc =[]
                var cols_loc = []
                var sort_result1 = sort_by_alphabets(sort_by_counts(reload_massive(result)).slice(0, countwords))
                sort_result1.forEach(function(a) {names_loc.push(a[0]); cols_loc.push(a[1])})
                WorkerScript.sendMessage({'names': names_loc,'counts': cols_loc, 'complete': true})
            }
        }
    })
//    for (var key1 in result) {console.debug(key1, result[key1])}
    var sort_result = sort_by_alphabets(sort_by_counts(reload_massive(result)).slice(0, countwords))
    sort_result.forEach(function(a) {names.push(a[0]); cols.push(a[1])})
    WorkerScript.sendMessage({'names': names,'counts': cols, 'complete': true})
}

function reload_massive (massive) {
    var mass =[]
    for (var key in massive) mass.push([key, massive[key]])
    return mass
}

function sort_by_counts(massive) {
    massive.sort(function(a,b) {return b[1] - a[1]})
    return massive
}

function sort_by_alphabets(massive) {
    massive.sort(function(a,b) {
        var aname = a[0].toLowerCase()
        var bname = b[0].toLowerCase()
        if(aname < bname) return -1
        if(aname > bname) return 1
    })
    return massive
}
