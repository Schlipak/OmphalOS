GenericException = require 'src/Exceptions/GenericException'

module.exports = class XException extends GenericException
    @className : 'XException'

    constructor: (msg) ->
        super msg
        body = document.getElementsByTagName('body')[0]
        body.innerHTML = msg

XException.prototype = Object.create Error.prototype
XException.prototype.name = 'XException'
