XException      = require 'src/Exceptions/XException'
XTechneStartup  = require 'src/Xjs/XTechneStartup'
XTechneLogin    = require 'src/Xjs/XTechneLogin'
XTechneDesktop  = require 'src/Xjs/XTechneDesktop'

module.exports = class XTechne
    @className : 'XTechne display manager'

    @kernelInstance = null
    @displaySurface = null

    @displayContainer   = null
    @startupManager     = null
    @loginManager       = null
    @desktopManager     = null

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
        @displaySurface.classList.add 'xinstance'
        @displayContainer = document.createElement 'div'
        @displayContainer.classList.add 'xtechneContainer'
        Waves.init()
        @clearScreen()
        @displaySurface.appendChild @displayContainer
        @startupManager = new XTechneStartup @, @displayContainer

    startLogin: () ->
        @loginManager = new XTechneLogin @, @displayContainer

    startDesktop: () ->
        _xtechne = @
        @loginManager.removeEventListener('loginSuccess')
        @loginManager.removeEventListener('loginError')
        setTimeout(
            () ->
                _xtechne.clearSurface _xtechne.loginManager.displaySurface
                delete _xtechne.loginManager
                _xtechne.loginManager = null
                _xtechne.desktopManager = new XTechneDesktop(_xtechne, _xtechne.displayContainer)
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
