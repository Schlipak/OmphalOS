module.exports = class IOException
    @className : 'IOException'

    constructor: (msg) ->
        time = new Date().toLocaleTimeString()
        document.getElementsByTagName('body')[0].innerHTML = "[ #{time} ] IO exception: #{msg}"
        throw new Error msg

IOException.prototype = Object.create Error.prototype
IOException.prototype.name = 'IOException'
