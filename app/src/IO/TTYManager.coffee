IOException         = require 'src/Exceptions/IOException'
NodeTester          = require 'src/HTMLUtils/NodeTester'

module.exports      = class TTYManager
    @className      : 'TTYManager'

    @kernel         = null
    @displaySurface = null

    @TTYs           = null
    @activeTTY      = 1

    constructor: (kernel, surface, nb) ->
        if not kernel?
            throw new IOException 'Somehow, could not acquire kernel. This is bad.'
        @kernel = kernel
        if not surface?
            throw new IOException 'Could acquire display surface'
        @displaySurface = surface
        @TTYs = new Array
        for i in [1..nb]
            tty = document.createElement 'div'
            tty.classList.add 'tty'
            tty.setAttribute 'data-id', i
            surface.appendChild tty
            @TTYs.push tty
            @kernel.write tty, "[TTY#{i}]"

    getTTY: (id) ->
        if not id? or id < 1 or id > 7
            @kernel.emitException "TTY#{id} does not exist"
            return undefined
        return @TTYs[id - 1]

    hideTTYs: () ->
        for tty in @TTYs
            tty.classList.remove 'active'
        true

    showTTY: (id) ->
        if not id?
            @kernel.emitException 'Invalid TTY id'
            return false
        if typeof id is typeof 0
            if id is @activeTTY
                return false
            if id < 1 or id > 7
                @kernel.emitException "TTY#{id} does not exist"
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
