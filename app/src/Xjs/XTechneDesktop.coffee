XException              = require 'src/Exceptions/XException'
XTechnePanel            = require 'src/Xjs/XTechnePanel'
AjaxHelper              = require 'src/JSUtils/AjaxHelper'
XTechneStackingManager  = require 'src/Xjs/XTechneStackingManager'

module.exports = class XTechneDesktop
    @className : 'XTechneDesktop'

    @xtechne            = null
    @displayContainer   = null
    @displaySurface     = null

    @stackManager       = null
    @panels             = null

    constructor: (xtechne, surface) ->
        if not xtechne?
            throw new XException "Could not acquire #{XTechne.className} instance"
        if not surface?
            throw new XException 'Could not acquire display surface'
        @xtechne = xtechne
        @displayContainer = surface
        @displaySurface = document.createElement 'div'
        @displaySurface.classList.add 'xtechneDesktopContainer'
        @displaySurface.classList.add 'hidden'
        @displayContainer.appendChild @displaySurface
        OS = require 'OS'
        @initDesktop()

    initDesktop: () ->
        _this = @
        @stackManager = new XTechneStackingManager()
        AjaxHelper.getJSON 'etc/xtechne/desktoprc', (data) ->
            _this.panels = new Array
            for pData in data.panels
                panel = new XTechnePanel _this, _this.displaySurface, pData
                panel.initContent pData.contents
                _this.panels.push panel
            if data.theme? and data.theme.backgroundImage?
                _this.displaySurface.style.backgroundImage = "url('#{data.theme.backgroundImage}')"
            _this.displaySurface.classList.remove 'hidden'
