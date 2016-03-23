Kernel              = require 'Kernel'
XTechne             = require 'src/Xjs/XTechne'
OSException         = require 'src/Exceptions/OSException'

module.exports  = class OS
    @className      = 'OmphalOS'
    @version        = '0.1'
    @versionName    = 'Artemis'

    @kernel         = null
    @displayManager = null

    constructor: (container) ->
        @kernel = new Kernel(container)
        return @

    boot: () ->
        if not @kernel?
            throw new OSException 'Could not start kernel. This is bad.'
        @kernel.showTTY 1
        @kernel.write(@kernel.getTTY(1), "#{OS.className} version #{OS.version} \"#{OS.versionName}\"")
        @kernel.boot()
        @kernel.write(@kernel.getTTY(1), "Starting #{XTechne.className} on TTY7...")
        @displayManager = new XTechne @kernel, @kernel.getTTY 7
        if not @displayManager?
            throw new OSException @, "Could not connect to #{XTechne.className}"
        @displayManager.init()
