KernelPanic         = require 'src/Exceptions/KernelPanic'
XManager            = require 'src/Xjs/XManager'
NodeTester          = require 'src/HTMLUtils/NodeTester'
KeyboardListener    = require 'src/IO/KeyboardListener'

module.exports = class Kernel
    @className          = 'Kernel'
    @version            = '0.1'

    @displaySurface     = null
    @displayManager     = null

    @keyboardListener   = null

    @TTYs               = null
    @activeTTY          = 1

    constructor: (container) ->
        if not container?
            throw new KernelPanic @, 'Unable to acquire display, aborting'
        @displaySurface = container
        @createTTYs()
        @displayManager = new XManager @, @getTTY 7
        return @

    createTTYs: () ->
        @TTYs = new Array
        for i in [1..7]
            tty = document.createElement 'div'
            tty.classList.add 'tty'
            tty.setAttribute 'data-id', i
            @displaySurface.appendChild tty
            @TTYs.push tty
            @write tty, "[TTY#{i}]"
        true

    getTTY: (id) ->
        if not id? or id < 1 or id > 7
            @emitException "TTY#{id} does not exist"
            return undefined
        return @TTYs[id - 1]

    hideTTYs: () ->
        for tty in @TTYs
            tty.classList.remove 'active'
        true

    showTTY: (id) ->
        if not id?
            @emitException 'Invalid TTY id'
            return false
        if typeof id is typeof 0
            if id is @activeTTY
                return false
            if id < 1 or id > 7
                @emitException "TTY#{id} does not exist"
                return false
            @hideTTYs()
            @TTYs[id - 1].classList.add 'active'
            @activeTTY = id
        else if NodeTester.isDOM id
            @hideTTYs()
            id.classList.add 'active'
            @activeTTY = id.getAttribute 'data-id'
        else
            return false
        true

    clearTTY: (id) ->
        tty = @getTTY id
        while tty.lastChild
            tty.removeChild tty.lastChild
        true

    emitException: (msg, halt) ->
        if not @TTYs? or @TTYs.length is 0
            throw new Error msg
        tty = @TTYs[0]
        time = new Date().toLocaleTimeString()
        @write tty, "[#{time}] %(F:yellow)Kernel exception%(F): #{msg}"
        if halt? and halt is true
            throw new Error msg

    emitMessage: (msg, id = 1) ->
        if not @TTYs? or @TTYs.length is 0
            false
        tty = @TTYs[id - 1]
        time = new Date().toLocaleTimeString()
        @write tty, "[#{time}] Message: #{msg}"

    boot: () ->
        @write(@getTTY(1), "Kernel version #{Kernel.version}")
        @write(@getTTY(1), '%(F:green)Welcome!%(F)')
        @write(@getTTY(1), 'Loading keyboard listener...')
        @keyboardListener = new KeyboardListener()
        _this = @
        for i in [1..7]
            @keyboardListener.register("meta alt #{i}", (e) ->
                _this.showTTY e.which - 48
            )
        @write(@getTTY(1), 'Loading single-user configuration...')
        @write(@getTTY(1), 'Starting XManager on TTY7...')
        if not @displayManager?
            throw new KernelPanic @, 'Unable to connect to XManager, aborting'
        @displayManager.init()

    write: (target, string) ->
        if not target?
            @emitException 'Unable to find write target'
            return false
        if NodeTester.isDOM target
            string = string.replace(/%\((\w){1}\:([\w\d]+)*\)/g, "<span class=\"$1 $2\" data-color=\"$2\">")
            string = string.replace(/%\(\w{1}\)/g, '</span>')
            target.insertAdjacentHTML 'beforeend', '<span>'+string+'</span>'
            return true
        false
