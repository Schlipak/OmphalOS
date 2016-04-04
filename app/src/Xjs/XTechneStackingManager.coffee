module.exports = class XTechneStackingManager
    @className  : 'XTechneStackingManager'

    @stack      = null

    constructor: () ->
        @stack = new Array

    register: (target, frame) ->
        if not frame?
            # TODO: Replace with notification call?
            console.warn 'Cannot acquire window frame'
            return undefined
        if not frame?
            # TODO: Replace with notification call?
            console.warn 'Cannot acquire window frame'
            return undefined
        @stack.push {
            target: target
            frame: frame
        }
        @updateStack()

    unregister: (frame) ->
        if not frame?
            # TODO: Replace with notification call?
            console.warn 'Cannot acquire window frame'
        i = -1
        for s in @stack
            if s.frame is frame
                i++
                break
            i++
        if i isnt -1
            @stack.splice i, 1

    updateStack: () ->
        i = 0
        z = 1
        for s in @stack
            if not document.contains s.frame.window
                s.target.setOpen false
                @stack.splice i, 1
                @updateStack()
            s.frame.style.zIndex = z
            i++
            z += 100

    findByTarget: (target) ->
        i = 0
        for s in @stack
            if s.target is target
                if document.contains s.frame.window
                    return s.frame
            i++
        undefined

    findByFrame: (frame) ->
        i = 0
        for s in @stack
            if s.frame is frame
                s.target
            i++
        undefined
