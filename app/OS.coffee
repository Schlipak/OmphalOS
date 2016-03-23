Kernel              = require 'Kernel'
OSException         = require 'src/Exceptions/OSException'

module.exports  = class OS
    @className      = 'OmphalOS'
    @version        = '0.1'
    @versionName    = 'Artemis'

    @kernel     = null

    constructor: (container) ->
        @kernel = new Kernel(container)
        return @

    boot: () ->
        if not @kernel?
            throw new OSException 'Cannot find kernel.'
        @kernel.showTTY 1
        @kernel.write(@kernel.getTTY(1), "#{OS.className} version #{OS.version} \"#{OS.versionName}\"")
        @kernel.boot()
