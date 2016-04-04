XException          = require 'src/Exceptions/XException'
XTechneWindow       = require 'src/Xjs/XTechneWindow'
XTechnePanelItem    = require 'src/Xjs/XTechnePanelItem'

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
            el = new XTechnePanelItem @, elData
            if not el? then continue
            @container.appendChild el.domTarget
            @elements.push el

    getElementFromTarget: (domEl) ->
        for o in @elements
            if o.domTarget is domEl
                return o

    getElementFromWindow: (w) ->
        for o in @elements
            if o.menu? and o.menu.window is w
                return o

    handleClick: (e) ->
        o = @getElementFromTarget e.srcElement
        if not o?
            # TODO: Replace with future notification system call
            console.warn "Unknown panel item #{e.srcElement}"
        if o.action is 'startMenuToggle' and o.menu?
            o.menu.toggle()
        else if o.action.match /^exec .+$/
            if o.isOpen
                win = @xdesktop.stackManager.findByTarget o
                if win?
                    win.show()
                else
                    o.setOpen false
            else
                action = o.action.split('exec ')[1]
                action = action.slice(0,1).toUpperCase() + action.slice(1).toLowerCase()
                AppClass = require "src/Apps/#{action}/#{action}"
                @xdesktop.stackManager.register(o, new AppClass @displaySurface)
                o.setOpen true
