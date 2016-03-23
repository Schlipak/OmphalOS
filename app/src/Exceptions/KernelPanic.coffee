module.exports = class KernelPanic
    @className = 'KernelPanic'

    constructor: (kernel, msg) ->
        if not kernel?
            throw new Error msg
        if not kernel.TTYs? or kernel.TTYs.length is 0
            throw new Error msg
        tty = kernel.TTYs[0]
        time = new Date().toLocaleTimeString()
        for i in [2..7]
            kernel.clearTTY i
        kernel.showTTY 1
        kernel.write tty, "[ #{time} ] %(F:red)Kernel panic%(F): #{msg}"

KernelPanic.prototype = Object.create Error.prototype
KernelPanic.prototype.name = 'KernelPanic'
