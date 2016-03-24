XException  = require 'src/Exceptions/XException'

module.exports = class XTechneLogin
    @className      = 'XTechne login manager'

    @xtechne        = null
    @displaySurface = null
    @panel          = null
    @box            = null

    @usernameInput  = null
    @passwordInput  = null
    @submitButton   = null

    _logged         = false

    constructor: (xtechne, surface) ->
        if not xtechne?
            throw new XException "Could not acquire #{XTechne.className} instance"
        if not surface?
            throw new XException 'Could not acquire display surface'
        @xtechne = xtechne
        @displaySurface = surface
        EventDispatcher.prototype.apply XTechneLogin.prototype
        @addEventListener('loginSuccess', (e) -> xtechne.startDesktop())
        @addEventListener('loginError', (e) -> console.warn e.message)
        @createPanel()

    createPanel: () ->
        @panel = document.createElement 'div'
        @panel.classList.add 'xtechneLoginContainer'
        @displaySurface.appendChild @panel
        @box = document.createElement 'div'
        @box.classList.add 'xtechneLoginBox'
        @panel.appendChild @box
        content = '
            <form action="javascript:void(0);">
                <label for=\"userInputBox\">
                    Username
                    <input type="text" name="username" id="userInputBox" autocomplete="off">
                </label>
                <label for=\"passwordInputBox\">
                    Password
                    <input type="password" name="password" id="passwordInputBox" autocomplete="off">
                </label>
                <button type="submit" name="loginButton" id="loginButton" class="material button blue">Login</button>
            </form>
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
        if username.length > 0 and @passwordInput.value.length > 0
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
