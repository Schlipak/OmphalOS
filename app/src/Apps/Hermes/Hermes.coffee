XTechneWindow       = require 'src/Xjs/XTechneWindow'

module.exports = class Hermes extends XTechneWindow
    @className  : 'Hermes'

    constructor: (surface) ->
        super(surface, 'Hermes', {
            size:
                w: '500px'
                h: '400px'
        })
        @show()
