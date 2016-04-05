XTechneWindow       = require 'src/Xjs/XTechneWindow'
Nomos               = require 'src/Nomos/Nomos'

module.exports = class Hermes extends XTechneWindow
    @className  : 'Hermes file explorer'

    @layout     = null
    @logo       = null
    @text       = null

    constructor: (surface) ->
        super(surface, 'Hermes', {
            size:
                w: '500px'
                h: '400px'
        })
        @initContent()
        @show()

    initContent: () ->
        @layout = Nomos.createLayout {
            type: 'flex'
            direction: 'column'
        }
        @logo = Nomos.createImage 'usr/share/icons/apps/hermes.svg', '200px', '200px'
        @text = Nomos.createText "#{Hermes.className}", '18px'
        if @logo? then @layout.appendChild @logo
        if @text? then @layout.appendChild @text
        @window.appendChild @layout
