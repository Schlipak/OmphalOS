IOException     = require 'src/Exceptions/IOException'

module.exports  = class KeyboardListener
    @className  = 'KeyboardListener'
    @version    = '0.1'

    @kernel     = null
    @listener   = null

    constructor: (kernel) ->
        if not kernel?
            throw new IOException 'Somehow, could not acquire kernel. This is bad.'
        @kernel = kernel
        if not window.keypress.Listener?
            @kernel.emitException 'Cannot initialize keyboard listener', true
        @listener = new window.keypress.Listener()
        @kernel.write(@kernel.getTTY(1), "#{KeyboardListener.className} version #{KeyboardListener.version}")
        return @

    register: (combo, callback, unordered, solitary) ->
        if not combo? or not callback?
            @kernel.emitException 'Cannot register new key listener: Invalid combo or callback'
            return false
        if not unordered? then unordered = true
        if not solitary? then solitary = true
        @listener.register_combo({
            'keys': combo,
            'on_keydown': callback,
            'is_unordered': unordered,
            'is_solitary': solitary
        })
        true

    unregister: (combo) ->
        if not combo?
            @kernel.emitException 'Cannot unregister unknown key combo'
            return false
        @listener.unregister_combo(combo)
        true

    registerTTYCombos: () ->
        if not @kernel?
            throw new IOException 'Somehow, could not acquire kernel. This is bad.'
        _kernel = @kernel
        for i in [1..7]
            @register("meta alt #{i}", (e) ->
                _kernel.showTTY e.which - 48
            )
