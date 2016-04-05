module.exports = class Nomos
    @className : 'Nomos framework'

    @createImage = (src, w, h) ->
        if not src? then return null
        img = document.createElement 'img'
        img.classList.add 'nomosImage'
        img.src = src
        if w? then img.style.width = w
        if h? then img.style.height = h
        return img

    @createText = (str, size) ->
        if not str? then return null
        text = document.createElement 'span'
        text.classList.add 'nomosTextNode'
        text.innerHTML = str
        if size? then text.style.fontSize = size
        return text

    @createLayout = (data) ->
        if not data? then return null
        if not data.type? then return null
        layout = document.createElement 'div'
        layout.classList.add 'nomosLayout'
        layout.classList.add data.type
        if data.direction? then layout.classList.add data.direction
        if data.alignment? then layout.classList.add data.alignment
        if data.padding? then layout.classList.add data.padding
        if data.backgroundColor? then layout.style.backgroundColor = data.backgroundColor
        return layout

    @createTextInput = (defaultValue, style) ->
        input = document.createElement 'input'
        input.type = 'text'
        input.value = defaultValue
        input.classList.add 'nomosTextInput'
        input.setAttribute 'spellcheck', false
        if style? and style.width? then input.classList.add style.width
        if style? and style.border? then input.classList.add style.border
        return input

    @createIFrame = (src) ->
        if not src? then return null
        frame = document.createElement 'iframe'
        frame.classList.add 'nomosIFrame'
        frame.src = src
        return frame
