XException  = require 'src/Exceptions/XException'

module.exports = class XTechneLogin
    @className      = 'XTechne login manager'

    @displaySurface = null
    @panel          = null
    @box            = null

    @usernameInput  = null
    @passwordInput  = null
    @submitButton   = null

    _logged         = false

    constructor: (surface) ->
        if not surface?
            throw new XException 'Could not acquire display surface'
        EventDispatcher.prototype.apply XTechneLogin.prototype
        @displaySurface = surface
        @createPanel()

    createPanel: () ->
        @panel = document.createElement 'div'
        @panel.classList.add 'xtechneLoginContainer'
        @displaySurface.appendChild @panel
        @box = document.createElement 'div'
        @box.classList.add 'xtechneLoginBox'
        @panel.appendChild @box
        content = '
            <label for=\"userInputBox\">
                Username
                <input type="text" name="username" id="userInputBox">
            </label>
            <label for=\"passwordInputBox\">
                Password
                <input type="password" name="password" id="passwordInputBox">
            </label>
            <button type="button" name="loginButton" id="loginButton" class="material button blue">Login</button>
        '
        @box.insertAdjacentHTML 'beforeend', content
        @usernameInput = document.getElementById 'userInputBox'
        @passwordInput = document.getElementById 'passwordInputBox'
        @submitButton  = document.getElementById 'loginButton'
        _this = @
        @submitButton.onclick = (e) ->
            _this.login()

    login: () ->
        if _logged is true
            return false
        username = @usernameInput.value
        hash = String(CryptoJS.SHA3(@passwordInput.value))
        if true
            _logged = true
            @dispatchEvent({
                type: 'loginSuccess',
                message: "User #{username} logged in successfully"
            })
            @panel.classList.add 'dismissing'
            return true
        @dispatchEvent({
            type: 'loginError',
            message: "Bad credentials for user #{username}"
        })
        return false
