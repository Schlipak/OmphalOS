XException = require 'src/Exceptions/XException'

module.exports = class XManager
    @className = 'XManager'

    @kernelInstance = null
    @displaySurface = null

    constructor: (kernel, surface) ->
        if not kernel?
            throw new XException 'Somehow, could not acquire kernel. This is bad.'
        if not surface?
            throw new XException 'Could not acquire display surface. Aborting'
        @kernelInstance = kernel
        @displaySurface = surface

    init: () ->
        @kernelInstance.showTTY @displaySurface
        @kernelInstance.write(@displaySurface, 'Loading display...')

    clearScreen: () ->
        while @displaySurface.lastChild
            @displaySurface.removeChild @displaySurface.lastChild
            undefined
