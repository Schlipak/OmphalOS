module.exports = class GenericException
    @className = 'GenericException'

    constructor: (kernel, msg) ->
        if not kernel?
            throw new Error msg
        tty = kernel.getTTY 1
        time = new Date().toLocaleString()
        kernel.write tty, "[ #{time} ] Generic exception: #{msg}"

GenericException.prototype = Object.create Error.prototype
GenericException.prototype.name = 'GenericException'
