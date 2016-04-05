XTechneWindow   = require 'src/Xjs/XTechneWindow'
Position        = require 'src/JSUtils/Position'

module.exports = class XTechnePanelItem
    @className  : 'XTechnePanelItem'

    @type       = ''

    @panel      = null

    @wrapper    = null
    @domTarget  = null
    @tooltip    = null
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
        @wrapper = document.createElement 'div'
        @wrapper.classList.add 'xtechneDesktopPanelItemWrapper'
        @domTarget = document.createElement 'div'
        @domTarget.classList.add @type
        @wrapper.appendChild @domTarget
        if @type isnt 'xtechneDesktopPanelSeparator'
            @domTarget.style.backgroundImage = "url('#{data.iconSrc}')"
            @domTarget.onclick = (e) ->
                _this.panel.handleClick e
            Waves.attach @domTarget, ['waves-light']
        @action = data.onClickAction if data.onClickAction?
        if @action? and @action is 'startMenuToggle'
            @createStartMenu()

    initTooltip: () ->
        _this = @
        action = @panel.actionToString @action
        if action is '' then return
        @tooltip = document.createElement 'span'
        @tooltip.classList.add 'tooltip'
        @tooltip.innerHTML = action
        @wrapper.appendChild @tooltip

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
