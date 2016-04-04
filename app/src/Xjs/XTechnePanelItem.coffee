XTechneWindow   = require 'src/Xjs/XTechneWindow'

module.exports = class XTechnePanelItem
    @className  : 'XTechnePanelItem'

    @type       = ''

    @panel      = null

    @domTarget  = null
    @action     = null
    @menu       = null

    @isOpen     = false

    constructor: (panel, data) ->
        if not panel?
            # TODO: Replace with future notification system call
            console.warn 'Cannot acquire panel instance'
            return undefined
        if not data.type?
            # TODO: Replace with future notification system call
            console.warn "Missing panelItem type for #{JSON.stringify(data)}"
            return undefined
        _this = @
        @panel = panel
        @type = data.type
        @domTarget = document.createElement 'div'
        @domTarget.classList.add @type
        if @type isnt 'xtechneDesktopPanelSeparator'
            @domTarget.style.backgroundImage = "url('#{data.iconSrc}')"
            @domTarget.onclick = (e) ->
                _this.panel.handleClick e
            Waves.attach @domTarget, ['waves-light']
        @action = data.onClickAction if data.onClickAction?
        if @action? and @action is 'startMenuToggle'
            @createStartMenu()

    createStartMenu: () ->
        @domTarget.id = "startMenuToggler"
        @menu = new XTechneWindow @panel.displaySurface, 'Start', {
            position:
                left: '0'
                right: null
                top: null
                bottom: '50px'
            size:
                w: '400px'
                h: '600px'
            borders: false
            background: '#282828'
            stack: 9999
        }
        _this = @
        @menu.window.addEventListener 'blur', (e) ->
            o = _this.panel.getElementFromWindow e.srcElement
            o.menu.hide()

    setOpen: (b) ->
        @isOpen = b
        if b
            @domTarget.classList.add 'open'
        else
            @domTarget.classList.remove 'open'
