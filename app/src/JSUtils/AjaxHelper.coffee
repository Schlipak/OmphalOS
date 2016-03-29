module.exports = class AjaxHelper
    @className : 'AjaxHelper'

    @getJSON = (url, callback) ->
        if not url?
            console.warn 'no url'
            return null
        if not callback?
            console.warn 'no callback'
            return null
        if not url.match /^.+(.json)$/
            url = url + '.json'
        request = new XMLHttpRequest()
        request.open 'GET', url, true
        request.onload = () ->
            if request.status >= 200 and request.status < 400
                data = JSON.parse request.responseText
                callback data
            else
                console.warn 'error getting data'
        request.onerror = (e) ->
            warn e
        request.send()
