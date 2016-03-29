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

    # TODO: Use array of objects containing properties and HTML element rather
    # than the element only and storing actions in the element (safer that way)
    initContent: (contents) ->
        @elements = new Array
        _this = @
        for elData in contents
            if not elData.type?
                # TODO: Replace with future notification system call
                console.warn "Missing panelItem type for #{JSON.stringify(elData)}"
                continue
            el = document.createElement 'div'
            el.classList.add elData.type
            if elData.type isnt 'xtechneDesktopPanelSeparator'
                el.style.backgroundImage = "url('#{elData.iconSrc}')"
                el.setAttribute 'data-action', elData.onClickAction
                el.onclick = (e) ->
                    _this.handleClick e
                Waves.attach el, ['waves-light']
            @container.appendChild el
            @elements.push el

    handleClick: (e) ->
        console.log e.srcElement.getAttribute 'data-action'
