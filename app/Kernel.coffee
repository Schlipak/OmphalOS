KernelPanic         = require 'src/Exceptions/KernelPanic'
NodeTester          = require 'src/HTMLUtils/NodeTester'
KeyboardListener    = require 'src/IO/KeyboardListener'
TTYManager          = require 'src/IO/TTYManager'

module.exports = class Kernel
    @className          = 'Kernel'
    @version            = '0.1'

    @displaySurface     = null
    @keyboardListener   = null
    @TTYManager         = null

    constructor: (container) ->
        if not container?
            throw new KernelPanic @, 'Could not acquire display, aborting'
        @displaySurface = container
        @createTTYs()
        return @

    createTTYs: () ->
        @TTYManager = new TTYManager @, @displaySurface, 7

    getTTY: (id) ->
        @TTYManager.getTTY id

    hideTTYs: () ->
        @TTYManager.hideTTYs()

    showTTY: (id) ->
        @TTYManager.showTTY id

    clearTTY: (id) ->
        @TTYManager.clearTTY id

    emitException: (msg, halt = false) ->
        tty = @TTYManager.getTTY 1
        if not tty?
            throw new IOException 'Could not acquire TTY'
        time = new Date().toLocaleTimeString()
        @write tty, "[#{time}] %(F:yellow)Kernel exception%(F): #{msg}"
        if halt is true
            throw new Error msg

    emitMessage: (msg, id = 1) ->
        tty = @TTYManager.getTTY id
        if not tty?
            throw new IOException 'Could not acquire TTY'
        time = new Date().toLocaleTimeString()
        @write tty, "[#{time}] Message: #{msg}"

    boot: () ->
        @write(@getTTY(1), "Kernel version #{Kernel.version}")
        @write(@getTTY(1), '%(F:green)Welcome!%(F)')
        @write(@getTTY(1), 'Starting keyboard listener...')
        @keyboardListener = new KeyboardListener @
        @keyboardListener.registerTTYCombos()
        @write(@getTTY(1), 'Loading single-user configuration...')

    write: (target, string) ->
        if not target?
            @emitException 'Could not find write target'
            return false
        if NodeTester.isDOM target
            string = string.replace(/%\(([FB]){1}\:([\w\d]+)*\)/g, "<span class=\"$1 $2\" data-color=\"$2\">")
            string = string.replace(/%\([FB]{1}\)/g, '</span>')
            target.insertAdjacentHTML 'beforeend', '<span>'+string+'</span>'
            return true
        false
