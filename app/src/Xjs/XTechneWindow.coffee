module.exports = class XTechneWindow
    @className  : 'XTechneWindow'

    @displaySurface = null

    @name           = ""
    @window         = null
    @bar            = null
    @style          = null

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
        if @style.size? and @style.size.w? and @style.size.h?
            @window.style.width = @style.size.w
            @window.style.height = @style.size.h
        if @style.position?
            @window.style.left = @style.position.left if @style.position.left?
            @window.style.right = @style.position.right if @style.position.right?
            @window.style.top = @style.position.top if @style.position.top?
            @window.style.bottom = @style.position.bottom if @style.position.bottom?
        else
            left = (window.innerWidth / 2) - (parseInt(@window.style.width) / 2)
            top = (window.innerHeight / 2) - (parseInt(@window.style.height) / 2)
            @window.style.left = "#{left}px"
            @window.style.top = "#{top}px"
        if @style.background?
            @window.style.background = @style.background
        @displaySurface.appendChild @window
        if borders
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

    show: () ->
        @window.classList.remove 'hidden'
        @window.focus()

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
