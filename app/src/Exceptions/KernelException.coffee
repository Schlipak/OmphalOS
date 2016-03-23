GenericException = require 'src/Exceptions/GenericException'

module.exports = class KernelException extends GenericException
    @className = 'KernelException'

    constructor: (kernel, msg) ->
        super msg
        tty = kernel.getTTY 1
        time = new Date().toLocaleString()
        kernel.write tty, "[ #{time} ] Kernel exception: #{msg}"

KernelException.prototype = Object.create Error.prototype
KernelException.prototype.name = 'KernelException'
