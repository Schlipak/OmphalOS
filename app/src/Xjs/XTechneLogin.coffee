XException = require 'src/Exceptions/XException'

module.exports = class XTechneLogin
    @className      = 'XTechne login manager'

    @displaySurface = null
    @panel          = null

    constructor: (surface) ->
        if not surface?
            throw new XException 'Could not acquire display surface'
        @displaySurface = surface
        @createPanel()

    createPanel: () ->
        @panel = document.createElement 'div'
        @panel.classList.add 'xtechneLoginContainer'
        @displaySurface.appendChild @panel
        
