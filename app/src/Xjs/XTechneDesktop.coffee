XException      = require 'src/Exceptions/XException'
XTechnePanel    = require 'src/Xjs/XTechnePanel'
AjaxHelper      = require 'src/JSUtils/AjaxHelper'

module.exports = class XTechneDesktop
    @className = 'XTechneDesktop'

    @xtechne            = null
    @displaySurface     = null

    @panels             = null

    constructor: (xtechne, surface) ->
        if not xtechne?
            throw new XException "Could not acquire #{XTechne.className} instance"
        if not surface?
            throw new XException 'Could not acquire display surface'
        @xtechne = xtechne
        @displaySurface = surface
        @initDesktop()

    initDesktop: () ->
        _this = @
        AjaxHelper.getJSON 'etc/xtechne/desktoprc', (data) ->
            _this.panels = new Array
            for pData in data.panels
                panel = new XTechnePanel _this, _this.displaySurface, pData
                panel.initContent pData.contents
                _this.panels.push panel
