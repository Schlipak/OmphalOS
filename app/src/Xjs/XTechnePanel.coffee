XException      = require 'src/Exceptions/XException'

module.exports = class XTechnePanel
    @className = 'XTechnePanel'

    @xdesktop           = null
    @displaySurface     = null

    @container          = null
    @elements           = null

    constructor: (xdesktop, surface, data) ->
        if not xdesktop?
            throw new XException "Could not acquire #{XTechneDesktop.className} instance"
        if not surface?
            throw new XException 'Could not acquire display surface'
        @xdesktop = xdesktop
        @displaySurface = surface
        @container = document.createElement 'nav'
        if not data?
            @container.classList.add 'xtechneDesktopPanel'
        else
            @container.classList.add data.type
        @displaySurface.appendChild @container

    initContent: (contents) ->
        @elements = new Array
        _this = @
        for elData in contents
            if not elData.type?
                # TODO: Replace with future notification system call
                console.warn "Missing panelItem type for #{JSON.stringify(elData)}"
                continue
            elObj = {}
            el = document.createElement 'div'
            el.classList.add elData.type
            if elData.type isnt 'xtechneDesktopPanelSeparator'
                el.style.backgroundImage = "url('#{elData.iconSrc}')"
                el.onclick = (e) ->
                    _this.handleClick e
                Waves.attach el, ['waves-light']
            @container.appendChild el
            elObj.domTarget = el
            elObj.action = elData.onClickAction if elData.onClickAction?
            @elements.push elObj

    getElementFromDOM: (domEl) ->
        for o in @elements
            if o.domTarget is domEl
                return o

    handleClick: (e) ->
        o = @getElementFromDOM e.srcElement
        if not o?
            # TODO: Replace with future notification system call
            console.warn "Unknown panel item #{e.srcElement}"
        console.log o.action
