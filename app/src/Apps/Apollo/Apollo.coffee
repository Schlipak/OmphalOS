XTechneWindow       = require 'src/Xjs/XTechneWindow'
Nomos               = require 'src/Nomos/Nomos'

module.exports = class Apollo extends XTechneWindow
    @className  : 'Apollo web browser'
    @version    : '0.1'
    @homeUrl    : 'https://duckduckgo.com/'

    @layout     = null
    @logo       = null
    @text       = null

    @navBar     = null
    @frame      = null

    constructor: (surface) ->
        super(surface, 'Apollo', {
            size:
                w: '900px'
                h: '600px'
        })
        @initContent()
        @show()

    initContent: () ->
        _this = @
        @layout = Nomos.createLayout {
            type: 'flex'
            direction: 'column'
        }
        @logo = Nomos.createImage '../usr/share/icons/apps/apollo.svg', '200px', '200px'
        @text = Nomos.createText "#{Apollo.className} - v#{Apollo.version}", '18px'
        if @logo? then @layout.appendChild @logo
        if @text? then @layout.appendChild @text
        @window.appendChild @layout
        @initFrame()

    initFrame: () ->
        _this = @
        @frame = Nomos.createIFrame Apollo.homeUrl
        @navBar = Nomos.createTextInput Apollo.homeUrl, {
            border: 'border-apollo'
        }
        setTimeout(
            () ->
                _this.layout.classList.add 'fadeOut'
                setTimeout(
                    () ->
                        _this.window.removeChild _this.layout
                        _this.layout = Nomos.createLayout {
                            type: 'flex'
                            direction: 'column'
                            alignment: 'justify-start'
                            padding: 'padding-none'
                            backgroundColor: '#373737'
                        }
                        _this.layout.classList.add 'fadeIn'
                        _this.window.appendChild _this.layout
                        _this.layout.appendChild _this.navBar
                        _this.layout.appendChild _this.frame
                        _this.navBar.onkeyup = (e) ->
                            key = e.which || e.keyCode
                            if key is 13 then _this.navigate()
                    , 400
                )
            , 1300
        )

    navigate: (url) ->
        if not url?
            url = @navBar.value
        if not url.match /^https?:\/\/.*$/
            url = 'http://' + url
        try
            @frame.src = url
        catch error
            console.warn error
