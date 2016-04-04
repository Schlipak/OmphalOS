module.exports = class XTechneWindow
    @className  : 'XTechneWindow'

    @displaySurface = null

    @name           = ""
    @window         = null
    @bar            = null
    @minimizeButton = null
    @maximizeButton = null
    @closeButton    = null

    @style          = null
    @draggie        = null

    @isMaximized    = false

    constructor: (surface, name, style) ->
        if not surface?
            console.warn 'No surface'
            return undefined
        if not name?
            console.warn 'No name'
            return undefined
        if not style?
            console.warn 'No style'
            return undefined
        @displaySurface = surface
        @name = name
        @window = document.createElement 'div'
        @window.classList.add 'xtechneWindow'
        @window.tabIndex = 0
        @style = style
        if @style.borders is false
            @window.classList.add 'borderless'
        @hide()
        @init(!(@style.borders is false))

    init: (borders) ->
        @setSize()
        @setPosition()
        @setBackground()
        @setStack()
        @displaySurface.appendChild @window
        if borders then @initBorders()

    setSize: (size) ->
        if not size?
            if @style.size? and @style.size.w? and @style.size.h?
                @window.style.width = @style.size.w
                @window.style.height = @style.size.h
        else
            @window.style.width = size.w
            @window.style.height = size.h

    setPosition: (position) ->
        if position?
            @window.style.left = position.left if position.left?
            @window.style.right = position.right if position.right?
            @window.style.top = position.top if position.top?
            @window.style.bottom = position.bottom if position.bottom?
        else if @style.position?
            @window.style.left = @style.position.left if @style.position.left?
            @window.style.right = @style.position.right if @style.position.right?
            @window.style.top = @style.position.top if @style.position.top?
            @window.style.bottom = @style.position.bottom if @style.position.bottom?
        else
            left = (window.innerWidth / 2) - (parseInt(@window.style.width) / 2)
            top = (window.innerHeight / 2) - (parseInt(@window.style.height) / 2)
            @window.style.left = "#{left}px"
            @window.style.top = "#{top}px"

    setBackground: () ->
        if @style.background? then @window.style.background = @style.background

    setStack: () ->
        if @style.stack? then @window.style.zIndex = @style.stack

    initBorders: () ->
        @bar = document.createElement 'div'
        @bar.classList.add 'bar'
        @bar.classList.add 'noselect'
        content = "
            <span class='windowBorderName'>#{@name}</span>
            <nav class='windowBorderControls'>
                <span class='windowBorderControl minimize'></span>
                <span class='windowBorderControl maximize'></span>
                <span class='windowBorderControl close'></span>
            </nav>
        "
        @bar.insertAdjacentHTML 'beforeend', content
        @window.appendChild @bar
        @draggie = new Draggabilly @window, {handle: '.bar'}
        @minimizeButton = @bar.getElementsByClassName('minimize')[0]
        _this = @
        @minimizeButton.onclick = () ->
            _this.minimize()
        @maximizeButton = @bar.getElementsByClassName('maximize')[0]
        @maximizeButton.onclick = () ->
            _this.maximize()
        @closeButton = @bar.getElementsByClassName('close')[0]
        @closeButton.onclick = () ->
            _this.close()

    show: () ->
        if not @isHidden() then return
        @window.classList.remove 'hidden'
        @window.classList.add 'moving'
        @setSize()
        @setPosition()
        _this = @
        setTimeout(
            () ->
                _this.window.classList.remove 'moving'
                _this.window.focus()
            , 400
        )

    hide: () ->
        @window.classList.add 'hidden'
        @window.blur()

    toggle: () ->
        if @isHidden
            @show()
        else
            @hide()

    isHidden: () ->
        @window.classList.contains 'hidden'

    minimize: () ->
        @window.classList.add 'moving'
        @setSize {
            w: '0px'
            h: '0px'
        }
        @setPosition {
            top: '100%'
            left: '50%'
        }
        @hide()
        _this = @
        setTimeout(
            () ->
                _this.window.classList.remove 'moving'
            , 400
        )

    maximize: () ->
        @window.classList.add 'moving'
        if @isMaximized
            @setSize()
            @setPosition()
            @isMaximized = false
        else
            @setSize {
                w: window.innerWidth + 'px'
                h: window.innerHeight - 40 + 'px'
            }
            @setPosition {
                top: 0
                left: 0
            }
            @isMaximized = true
        _this = @
        setTimeout(
            () ->
                _this.window.classList.remove 'moving'
            , 400
        )

    close: () ->
        _this = @
        @minimizeButton.onclick = null
        @maximizeButton.onclick = null
        @closeButton.onclick = null
        @hide()
        setTimeout(
            () ->
                _this.draggie.destroy()
                _this.draggie = null
                _this.displaySurface.removeChild _this.window
                window.xDesktop.stackManager.updateStack()
            , 400
        )
        return null
