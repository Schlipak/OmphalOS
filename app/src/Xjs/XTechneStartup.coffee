XException  = require 'src/Exceptions/XException'
XTechne     = require 'src/Xjs/XTechne'

module.exports = class XTechneStartup
    @className = 'XTechneStartup'

    @xtechne        = null
    @displaySurface = null

    @panel          = null
    @osName         = null

    constructor: (xtechne, surface) ->
        if not xtechne?
            throw new XException "Could not acquire #{XTechne.className} instance"
        if not surface?
            throw new XException 'Could not acquire display surface'
        @xtechne = xtechne
        @displaySurface = surface
        EventDispatcher.prototype.apply XTechneStartup.prototype
        @addEventListener('startup', (e) -> xtechne.startLogin())
        @displaySplash()

    displaySplash: () ->
        OS = require 'OS'
        @panel = document.createElement 'div'
        @panel.classList.add 'xtechneStartupContainer'
        content = "
            <span id=\"XTechneStartupOsName\" class=\"noselect\">Omphal<span>OS</span>
                <span id=\"XTechneStartupOsDetails\" class=\"noselect\">v#{OS.version} #{OS.versionName}</span>
            </span>
        "
        @panel.insertAdjacentHTML 'beforeend', content
        @osName = document.getElementById 'XTechneStartupOsName'
        @displaySurface.appendChild @panel
        _this = @
        setTimeout(
            () ->
                _this.xtechne.clearSurface _this.displaySurface
                _this.dispatchEvent({
                    type: 'startup',
                    message: 'Startup splash finished'
                    })
            , 6000
        )
