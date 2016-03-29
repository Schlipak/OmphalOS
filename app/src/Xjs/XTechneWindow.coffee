module.exports = class XTechneWindow
    @className  : 'XTechneWindow'

    @displaySurface = null
    @window         = null
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
        @window = document.createElement 'div'
        @window.classList.add 'xtechneWindow'
        @style = style
        if @style.borders is false
            @window.classList.add 'borderless'
        @hide()
        @init()

    init: () ->
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
            console.log left, top
            @window.style.left = "#{left}px"
            @window.style.top = "#{top}px"
        if @style.background?
            @window.style.background = @style.background
        @displaySurface.appendChild @window

    show: () ->
        @window.classList.remove 'hidden'

    hide: () ->
        @window.classList.add 'hidden'

    toggle: () ->
        @window.classList.toggle 'hidden'
