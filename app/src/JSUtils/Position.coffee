module.exports = class Position
    @className : 'Position'

    @getPosition = (el) ->
        if not el? then return null
        xPos = 0
        yPos = 0
        while el
            if el.tagName is 'BODY'
                xScroll = el.scrollLeft || document.documentElement.scrollLeft
                yScroll = el.scrollTop || document.documentElement.scrollTop
                xPos += (el.offsetLeft - xScroll + el.clientLeft)
                yPos += (el.offsetTop - yScroll + el.clientTop)
            else
                xPos += (el.offsetLeft - el.scrollLeft + el.clientLeft)
                yPos += (el.offsetTop - el.scrollTop + el.clientTop)
            el = el.offsetParent
        return {
            x: xPos
            y: yPos
        }
