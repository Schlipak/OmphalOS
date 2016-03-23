XException      = require 'src/Exceptions/XException'
XTechneLogin    = require 'src/Xjs/XTechneLogin'

module.exports = class XTechne
    @className = 'XTechne display manager'

    @kernelInstance = null
    @displaySurface = null

    @displayContainer   = null
    @loginManager       = null

    constructor: (kernel, surface) ->
        if not kernel?
            throw new XException 'Somehow, could not acquire kernel. This is bad.'
        if not surface?
            throw new XException 'Could not acquire display surface. Aborting'
        @kernelInstance = kernel
        @displaySurface = surface

    init: () ->
        @kernelInstance.showTTY @displaySurface
        @kernelInstance.write(@displaySurface, 'Loading display...')
        @clearScreen()
        @displaySurface.classList.add 'xinstance'
        @displayContainer = document.createElement 'div'
        @displayContainer.classList.add 'xtechneContainer'
        @displaySurface.appendChild @displayContainer
        @loginManager = new XTechneLogin @displayContainer
        _xtechne = @
        @loginManager.addEventListener('loginSuccess', (e) ->
            _xtechne.startDesktop()
        )
        @loginManager.addEventListener('loginError', (e) ->
            console.warn e.message
        )

    startDesktop: () ->
        _xtechne = @
        @loginManager.removeEventListener('loginSuccess')
        @loginManager.removeEventListener('loginError')
        setTimeout(
            () ->
                _xtechne.clearSurface _xtechne.loginManager.displaySurface
                delete _xtechne.loginManager
                _xtechne.loginManager = null
            , 600
        )

    clearSurface: (surface) ->
        if not surface?
            @kernel.emitException 'Could not find XTechne surface'
            return false
        while surface.lastChild
            surface.removeChild surface.lastChild
        undefined

    clearScreen: () ->
        while @displaySurface.lastChild
            @displaySurface.removeChild @displaySurface.lastChild
        undefined
