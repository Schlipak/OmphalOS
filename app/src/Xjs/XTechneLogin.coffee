XException  = require 'src/Exceptions/XException'
AjaxHelper  = require 'src/JSUtils/AjaxHelper'

module.exports = class XTechneLogin
    @className      = 'XTechne login manager'

    @xtechne        = null
    @displaySurface = null
    @panel          = null
    @box            = null

    @loginForm      = null
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
        _this = @
        @addEventListener('loginSuccess', (e) -> xtechne.startDesktop())
        @addEventListener('loginError', (e) -> _this.displayError(e))
        @createPanel()
        Waves.attach @submitButton, ['waves-button', 'waves-float', 'waves-light']

    createPanel: () ->
        @panel = document.createElement 'div'
        @panel.classList.add 'xtechneLoginContainer'
        @displaySurface.appendChild @panel
        @box = document.createElement 'div'
        @box.classList.add 'xtechneLoginBox'
        @panel.appendChild @box
        content = '
            <form action="" id="loginFormContainer">
                <label for="userInputBox" class="noselect">
                    Username
                    <input type="text" name="username" id="userInputBox" autocomplete="off" autofocus>
                </label>
                <label for="passwordInputBox" class="noselect">
                    Password
                    <input type="password" name="password" id="passwordInputBox" autocomplete="off">
                </label>
                <button type="submit" name="loginButton" id="loginButton" class="material button blue">Login</button>
            </form>
        '
        @box.insertAdjacentHTML 'beforeend', content
        @loginForm     = document.getElementById 'loginFormContainer'
        @usernameInput = document.getElementById 'userInputBox'
        @passwordInput = document.getElementById 'passwordInputBox'
        @submitButton  = document.getElementById 'loginButton'
        _this = @
        @loginForm.onsubmit = (e) ->
            e.preventDefault()
            _this.login()

    __get_user_hash__: (user, callback) ->
        if not user?
            return false
        if not callback?
            return false
        AjaxHelper.getJSON 'etc/passwd.json', callback

    displayError: (e) ->
        console.warn e.message
        @submitButton.disabled = true
        @submitButton.classList.add 'error'
        _this = @
        setTimeout(
            () ->
                _this.submitButton.disabled = false
                _this.submitButton.classList.remove 'error'
            , 1200
        )


    login: () ->
        if _logged is true
            return false
        username = @usernameInput.value.toLowerCase()
        @usernameInput.value = username
        hash = String(CryptoJS.SHA3(@passwordInput.value))
        _this = @
        if username.length > 0 and _this.passwordInput.value.length > 0
            @__get_user_hash__ username, (data) ->
                matchHash = null
                for userEntry in data
                    if userEntry.user is username
                        matchHash = userEntry.hash
                if not matchHash? or matchHash isnt hash
                    _this.dispatchEvent({
                        type: 'loginError',
                        message: "Bad credentials for user #{username}"
                    })
                    return false
                _logged = true
                _this.submitButton.disabled = true
                _this.dispatchEvent({
                    type: 'loginSuccess',
                    message: "User #{username} logged in successfully"
                })
                _this.panel.classList.add 'dismissing'
                return true
        else
            @dispatchEvent({
                type: 'loginError',
                message: "Username or password missing"
            })
        return false
