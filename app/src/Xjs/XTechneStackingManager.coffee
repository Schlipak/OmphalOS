module.exports = class XTechneStackingManager
    @className  : 'XTechneStackingManager'

    @stack      = null

    constructor: () ->
        @stack = new Array

    register: (frame) ->
        if not frame?
            # TODO: Replace with notification call?
            console.warn 'Cannot acquire window frame'
        @stack.push frame
        @updateStack()

    unregister: (frame) ->
        if not frame?
            # TODO: Replace with notification call?
            console.warn 'Cannot acquire window frame'
        i = @stack.indexOf frame
        if i isnt -1
            @stack.splice i, 1

    updateStack: () ->
        i = 1
        for frame in @stack
            frame.style.zIndex = i
            i += 100
