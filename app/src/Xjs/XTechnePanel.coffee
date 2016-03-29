XException      = require 'src/Exceptions/XException'
XTechneWindow   = require 'src/Xjs/XTechneWindow'

module.exports = class XTechnePanel
    @className : 'XTechnePanel'

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
            if elObj.action? and elObj.action is 'startMenuToggle'
                elObj.menu = new XTechneWindow @displaySurface, 'Start', {
                    position:
                        left: '0'
                        right: null
                        top: null
                        bottom: '60px'
                    size:
                        w: '400px'
                        h: '600px'
                    borders: false
                    background: '#282828'
                }
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
        if o.action is 'startMenuToggle' and o.menu?
            o.menu.toggle()
        else if o.action.match /^exec .+$/
            action = o.action.split('exec ')[1]
            action = action.slice(0,1).toUpperCase() + action.slice(1).toLowerCase()
            AppClass = require "src/Apps/#{action}/#{action}"
            @xdesktop.stackManager.register new AppClass @displaySurface
