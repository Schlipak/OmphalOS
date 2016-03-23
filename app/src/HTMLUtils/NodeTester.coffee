module.exports = class NodeTester
    @className = 'NodeTester'

    constructor: () ->

    @isNode: (o) ->
        return false if not o?
        if typeof o is typeof {}
            return o instanceof Node
        return typeof o is typeof {} and typeof o.nodeType is typeof 0 and typeof o.nodeName is typeof ''

    @isDOM: (o) ->
        return false if not o?
        if HTMLElement is typeof {}
            return o instanceof HTMLElement
        return typeof o is typeof {} and o isnt null and o.nodeType is 1 and typeof o.nodeName is typeof ''
