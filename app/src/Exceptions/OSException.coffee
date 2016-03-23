module.exports = class OSException
    @className = 'OSException'

    constructor: (msg) ->
        time = new Date().toLocaleTimeString()
        document.getElementsByTagName('body')[0].innerHTML = "[ #{time} ] System exception: #{msg}"
        throw new Error msg

OSException.prototype = Object.create Error.prototype
OSException.prototype.name = 'OSException'
