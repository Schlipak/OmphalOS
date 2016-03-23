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
        @loginManager.onlogin = (e) ->
            _xtechne.startDesktop()

    startDesktop: () ->
        undefined

    clearScreen: () ->
        while @displaySurface.lastChild
            @displaySurface.removeChild @displaySurface.lastChild
            undefined
