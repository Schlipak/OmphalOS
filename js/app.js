!function(){"use strict";var e="undefined"==typeof window?global:window;if("function"!=typeof e.require){var t={},n={},r={},i={}.hasOwnProperty,o=function(e,t){var n=r[e]||r[e+"/index.js"];return n||e},s=/^\.\.?(\/|$)/,a=function(e,t){for(var n,r=[],i=(s.test(t)?e+"/"+t:t).split("/"),o=0,a=i.length;a>o;o++)n=i[o],".."===n?r.pop():"."!==n&&""!==n&&r.push(n);return r.join("/")},l=function(e){return e.split("/").slice(0,-1).join("/")},u=function(t){return function(n){var r=a(l(t),n);return e.require(r,t)}},c=function(e,t){var r={id:e,exports:{}};return n[e]=r,t(r.exports,u(e),r),r.exports},p=function(e,r){null==r&&(r="/");var s=o(e,r);if(i.call(n,s))return n[s].exports;if(i.call(t,s))return c(s,t[s]);var l=a(s,"./index");if(i.call(n,l))return n[l].exports;if(i.call(t,l))return c(l,t[l]);throw new Error('Cannot find module "'+e+'" from "'+r+'"')};p.alias=function(e,t){r[t]=e},p.register=p.define=function(e,n){if("object"==typeof e)for(var r in e)i.call(e,r)&&p.register(r,e[r]);else t[e]=n},p.list=function(){var e=[];for(var n in t)i.call(t,n)&&e.push(n);return e},p.brunch=!0,p._cache=n,e.require=p}}(),require.register("Kernel",function(e,t,n){var r,i,o,s,a;i=t("src/Exceptions/KernelPanic"),s=t("src/HTMLUtils/NodeTester"),o=t("src/IO/KeyboardListener"),a=t("src/IO/TTYManager"),n.exports=r=function(){function e(e){if(null==e)throw new i(this,"Could not acquire display, aborting");return this.displaySurface=e,this.createTTYs(),this}return e.className="Kernel",e.version="0.1",e.displaySurface=null,e.keyboardListener=null,e.TTYManager=null,e.prototype.createTTYs=function(){return this.TTYManager=new a(this,this.displaySurface,7)},e.prototype.getTTY=function(e){return this.TTYManager.getTTY(e)},e.prototype.hideTTYs=function(){return this.TTYManager.hideTTYs()},e.prototype.showTTY=function(e){return this.TTYManager.showTTY(e)},e.prototype.clearTTY=function(e){return this.TTYManager.clearTTY(e)},e.prototype.emitException=function(e,t){var n,r;if(null==t&&(t=!1),r=this.TTYManager.getTTY(1),null==r)throw new IOException("Could not acquire TTY");if(n=(new Date).toLocaleTimeString(),this.write(r,"["+n+"] %(F:yellow)Kernel exception%(F): "+e),t===!0)throw new Error(e)},e.prototype.emitMessage=function(e,t){var n,r;if(null==t&&(t=1),r=this.TTYManager.getTTY(t),null==r)throw new IOException("Could not acquire TTY");return n=(new Date).toLocaleTimeString(),this.write(r,"["+n+"] Message: "+e)},e.prototype.boot=function(){return this.write(this.getTTY(1),"Kernel version "+e.version),this.write(this.getTTY(1),"%(F:green)Welcome!%(F)"),this.write(this.getTTY(1),"Starting keyboard listener..."),this.keyboardListener=new o(this),this.keyboardListener.registerTTYCombos(),this.write(this.getTTY(1),"Loading single-user configuration...")},e.prototype.write=function(e,t){return null==e?(this.emitException("Could not find write target"),!1):s.isDOM(e)?(t=t.replace(/%\(([FB]){1}\:([\w\d]+)*\)/g,'<span class="$1 $2" data-color="$2">'),t=t.replace(/%\([FB]{1}\)/g,"</span>"),e.insertAdjacentHTML("beforeend","<span>"+t+"</span>"),!0):!1},e}()}),require.register("OS",function(e,t,n){var r,i,o,s;r=t("Kernel"),s=t("src/Xjs/XTechne"),o=t("src/Exceptions/OSException"),n.exports=i=function(){function e(e){return this.kernel=new r(e),this}return e.className="OmphalOS",e.version="0.1",e.versionName="Artemis",e.kernel=null,e.displayManager=null,e.prototype.boot=function(){if(null==this.kernel)throw new o("Could not start kernel. This is bad.");if(this.kernel.showTTY(1),this.kernel.write(this.kernel.getTTY(1),e.className+" version "+e.version+' "'+e.versionName+'"'),this.kernel.boot(),this.kernel.write(this.kernel.getTTY(1),"Starting "+s.className+" on TTY7..."),this.displayManager=new s(this.kernel,this.kernel.getTTY(7)),null==this.displayManager)throw new o(this,"Could not connect to "+s.className);return this.displayManager.init()},e}()}),require.register("src/Exceptions/GenericException",function(e,t,n){var r;n.exports=r=function(){function e(e,t){var n,r;if(null==e)throw new Error(t);r=e.getTTY(1),n=(new Date).toLocaleString(),e.write(r,"[ "+n+" ] Generic exception: "+t)}return e.className="GenericException",e}(),r.prototype=Object.create(Error.prototype),r.prototype.name="GenericException"}),require.register("src/Exceptions/IOException",function(e,t,n){var r;n.exports=r=function(){function e(e){var t;throw t=(new Date).toLocaleTimeString(),document.getElementsByTagName("body")[0].innerHTML="[ "+t+" ] IO exception: "+e,new Error(e)}return e.className="IOException",e}(),r.prototype=Object.create(Error.prototype),r.prototype.name="IOException"}),require.register("src/Exceptions/KernelException",function(e,t,n){var r,i,o=function(e,t){function n(){this.constructor=e}for(var r in t)s.call(t,r)&&(e[r]=t[r]);return n.prototype=t.prototype,e.prototype=new n,e.__super__=t.prototype,e},s={}.hasOwnProperty;r=t("src/Exceptions/GenericException"),n.exports=i=function(e){function t(e,n){var r,i;t.__super__.constructor.call(this,n),i=e.getTTY(1),r=(new Date).toLocaleString(),e.write(i,"[ "+r+" ] Kernel exception: "+n)}return o(t,e),t.className="KernelException",t}(r),i.prototype=Object.create(Error.prototype),i.prototype.name="KernelException"}),require.register("src/Exceptions/KernelPanic",function(e,t,n){var r;n.exports=r=function(){function e(e,t){var n,r,i,o;if(null==e)throw new Error(t);if(null==e.TTYs||0===e.TTYs.length)throw new Error(t);for(o=e.TTYs[0],i=(new Date).toLocaleTimeString(),n=r=2;7>=r;n=++r)e.clearTTY(n);e.showTTY(1),e.write(o,"[ "+i+" ] %(F:red)Kernel panic%(F): "+t)}return e.className="KernelPanic",e}(),r.prototype=Object.create(Error.prototype),r.prototype.name="KernelPanic"}),require.register("src/Exceptions/OSException",function(e,t,n){var r;n.exports=r=function(){function e(e){var t;throw t=(new Date).toLocaleTimeString(),document.getElementsByTagName("body")[0].innerHTML="[ "+t+" ] System exception: "+e,new Error(e)}return e.className="OSException",e}(),r.prototype=Object.create(Error.prototype),r.prototype.name="OSException"}),require.register("src/Exceptions/XException",function(e,t,n){var r,i,o=function(e,t){function n(){this.constructor=e}for(var r in t)s.call(t,r)&&(e[r]=t[r]);return n.prototype=t.prototype,e.prototype=new n,e.__super__=t.prototype,e},s={}.hasOwnProperty;r=t("src/Exceptions/GenericException"),n.exports=i=function(e){function t(e){var n;t.__super__.constructor.call(this,e),n=document.getElementsByTagName("body")[0],n.innerHTML=e}return o(t,e),t.className="XException",t}(r),i.prototype=Object.create(Error.prototype),i.prototype.name="XException"}),require.register("src/HTMLUtils/NodeTester",function(e,t,n){var r;n.exports=r=function(){function e(){}return e.className="NodeTester",e.isNode=function(e){return null==e?!1:typeof e==typeof{}?e instanceof Node:typeof e==typeof{}&&"number"==typeof e.nodeType&&"string"==typeof e.nodeName},e.isDOM=function(e){return null==e?!1:HTMLElement===typeof{}?e instanceof HTMLElement:typeof e==typeof{}&&null!==e&&1===e.nodeType&&"string"==typeof e.nodeName},e}()}),require.register("src/IO/KeyboardListener",function(e,t,n){var r,i;r=t("src/Exceptions/IOException"),n.exports=i=function(){function e(t){if(null==t)throw new r("Somehow, could not acquire kernel. This is bad.");return this.kernel=t,null==window.keypress.Listener&&this.kernel.emitException("Cannot initialize keyboard listener",!0),this.listener=new window.keypress.Listener,this.kernel.write(this.kernel.getTTY(1),e.className+" version "+e.version),this}return e.className="KeyboardListener",e.version="0.1",e.kernel=null,e.listener=null,e.prototype.register=function(e,t,n,r){return null==e||null==t?(this.kernel.emitException("Cannot register new key listener: Invalid combo or callback"),!1):(null==n&&(n=!0),null==r&&(r=!0),this.listener.register_combo({keys:e,on_keydown:t,is_unordered:n,is_solitary:r}),!0)},e.prototype.unregister=function(e){return null==e?(this.kernel.emitException("Cannot unregister unknown key combo"),!1):(this.listener.unregister_combo(e),!0)},e.prototype.registerTTYCombos=function(){var e,t,n,i;if(null==this.kernel)throw new r("Somehow, could not acquire kernel. This is bad.");for(e=this.kernel,i=[],t=n=1;7>=n;t=++n)i.push(this.register("meta alt "+t,function(t){return e.showTTY(t.which-48)}));return i},e}()}),require.register("src/IO/TTYManager",function(e,t,n){var r,i,o;r=t("src/Exceptions/IOException"),i=t("src/HTMLUtils/NodeTester"),n.exports=o=function(){function e(e,t,n){var i,o,s,a;if(null==e)throw new r("Somehow, could not acquire kernel. This is bad.");if(this.kernel=e,null==t)throw new r("Could acquire display surface");for(this.displaySurface=t,this.TTYs=new Array,i=o=1,s=n;s>=1?s>=o:o>=s;i=s>=1?++o:--o)a=document.createElement("div"),a.classList.add("tty"),a.setAttribute("data-id",i),t.appendChild(a),this.TTYs.push(a),this.kernel.write(a,"[TTY"+i+"]")}return e.className="TTYManager",e.kernel=null,e.displaySurface=null,e.TTYs=null,e.activeTTY=1,e.prototype.getTTY=function(e){return null==e||1>e||e>7?void this.kernel.emitException("TTY"+e+" does not exist"):this.TTYs[e-1]},e.prototype.hideTTYs=function(){var e,t,n,r;for(n=this.TTYs,e=0,t=n.length;t>e;e++)r=n[e],r.classList.remove("active");return!0},e.prototype.showTTY=function(e){if(null==e)return this.kernel.emitException("Invalid TTY id"),!1;if("number"==typeof e){if(e===this.activeTTY)return!1;if(1>e||e>7)return this.kernel.emitException("TTY"+e+" does not exist"),!1;this.hideTTYs(),this.TTYs[e-1].classList.add("active"),this.activeTTY=e}else{if(!i.isDOM(e))return!1;this.hideTTYs(),e.classList.add("active"),this.activeTTY=e.getAttribute("data-id")}return!0},e.prototype.clearTTY=function(e){var t;for(t=this.getTTY(e);t.lastChild;)t.removeChild(t.lastChild);return!0},e}()}),require.register("src/JSUtils/AjaxHelper",function(e,t,n){var r;n.exports=r=function(){function e(){}return e.className="AjaxHelper",e.getJSON=function(e,t){var n;return null==e?(console.warn("no url"),null):null==t?(console.warn("no callback"),null):(n=new XMLHttpRequest,n.open("GET",e,!0),n.onload=function(){var e;return n.status>=200&&n.status<400?(e=JSON.parse(n.responseText),t(e)):console.warn("error getting data")},n.onerror=function(e){return warn(e)},n.send())},e}()}),require.register("src/Xjs/XTechne",function(e,t,n){var r,i,o,s;r=t("src/Exceptions/XException"),s=t("src/Xjs/XTechneStartup"),o=t("src/Xjs/XTechneLogin"),n.exports=i=function(){function e(e,t){if(null==e)throw new r("Somehow, could not acquire kernel. This is bad.");if(null==t)throw new r("Could not acquire display surface. Aborting");this.kernelInstance=e,this.displaySurface=t}return e.className="XTechne display manager",e.kernelInstance=null,e.displaySurface=null,e.displayContainer=null,e.startupManager=null,e.loginManager=null,e.prototype.init=function(){return this.kernelInstance.showTTY(this.displaySurface),this.kernelInstance.write(this.displaySurface,"Loading display..."),this.displaySurface.classList.add("xinstance"),this.displayContainer=document.createElement("div"),this.displayContainer.classList.add("xtechneContainer"),Waves.init(),this.clearScreen(),this.displaySurface.appendChild(this.displayContainer),this.startupManager=new s(this,this.displayContainer)},e.prototype.startLogin=function(){return this.loginManager=new o(this,this.displayContainer)},e.prototype.startDesktop=function(){var e;return e=this,this.loginManager.removeEventListener("loginSuccess"),this.loginManager.removeEventListener("loginError"),setTimeout(function(){return e.clearSurface(e.loginManager.displaySurface),delete e.loginManager,e.loginManager=null},600)},e.prototype.clearSurface=function(e){if(null==e)return this.kernel.emitException("Could not find XTechne surface"),!1;for(;e.lastChild;)e.removeChild(e.lastChild)},e.prototype.clearScreen=function(){for(;this.displaySurface.lastChild;)this.displaySurface.removeChild(this.displaySurface.lastChild)},e}()}),require.register("src/Xjs/XTechneLogin",function(e,t,n){var r,i,o;i=t("src/Exceptions/XException"),r=t("src/JSUtils/AjaxHelper"),n.exports=o=function(){function e(t,n){var r;if(null==t)throw new i("Could not acquire "+XTechne.className+" instance");if(null==n)throw new i("Could not acquire display surface");this.xtechne=t,this.displaySurface=n,EventDispatcher.prototype.apply(e.prototype),r=this,this.addEventListener("loginSuccess",function(e){return t.startDesktop()}),this.addEventListener("loginError",function(e){return r.displayError(e)}),this.createPanel(),Waves.attach(this.submitButton,["waves-button","waves-float","waves-light"])}var t;return e.className="XTechne login manager",e.xtechne=null,e.displaySurface=null,e.panel=null,e.box=null,e.loginForm=null,e.usernameInput=null,e.passwordInput=null,e.submitButton=null,t=!1,e.prototype.createPanel=function(){var e,t;return this.panel=document.createElement("div"),this.panel.classList.add("xtechneLoginContainer"),this.displaySurface.appendChild(this.panel),this.box=document.createElement("div"),this.box.classList.add("xtechneLoginBox"),this.panel.appendChild(this.box),t='<form action="" id="loginFormContainer"> <label for="userInputBox" class="noselect"> Username <input type="text" name="username" id="userInputBox" autocomplete="off" autofocus> </label> <label for="passwordInputBox" class="noselect"> Password <input type="password" name="password" id="passwordInputBox" autocomplete="off"> </label> <button type="submit" name="loginButton" id="loginButton" class="material button blue">Login</button> </form>',this.box.insertAdjacentHTML("beforeend",t),this.loginForm=document.getElementById("loginFormContainer"),this.usernameInput=document.getElementById("userInputBox"),this.passwordInput=document.getElementById("passwordInputBox"),this.submitButton=document.getElementById("loginButton"),e=this,this.loginForm.onsubmit=function(t){return t.preventDefault(),e.login()}},e.prototype.__get_user_hash__=function(e,t){return null==e?!1:null==t?!1:r.getJSON("etc/passwd.json",t)},e.prototype.displayError=function(e){var t;return console.warn(e.message),this.submitButton.disabled=!0,this.submitButton.classList.add("error"),t=this,setTimeout(function(){return t.submitButton.disabled=!1,t.submitButton.classList.remove("error")},1200)},e.prototype.login=function(){var e,n,r;return t===!0?!1:(r=this.usernameInput.value.toLowerCase(),this.usernameInput.value=r,n=String(CryptoJS.SHA3(this.passwordInput.value)),e=this,r.length>0&&e.passwordInput.value.length>0?this.__get_user_hash__(r,function(i){var o,s,a,l;for(a=null,o=0,s=i.length;s>o;o++)l=i[o],l.user===r&&(a=l.hash);return null==a||a!==n?(e.dispatchEvent({type:"loginError",message:"Bad credentials for user "+r}),!1):(t=!0,e.submitButton.disabled=!0,e.dispatchEvent({type:"loginSuccess",message:"User "+r+" logged in successfully"}),e.panel.classList.add("dismissing"),!0)}):this.dispatchEvent({type:"loginError",message:"Username or password missing"}),!1)},e}()}),require.register("src/Xjs/XTechneStartup",function(e,t,n){var r,i;r=t("src/Exceptions/XException"),n.exports=i=function(){function e(t,n){if(null==t)throw new r("Could not acquire "+XTechne.className+" instance");if(null==n)throw new r("Could not acquire display surface");this.xtechne=t,this.displaySurface=n,EventDispatcher.prototype.apply(e.prototype),this.addEventListener("startup",function(e){return t.startLogin()}),this.displaySplash()}return e.className="XTechneStartup",e.xtechne=null,e.displaySurface=null,e.panel=null,e.osName=null,e.prototype.displaySplash=function(){var e,t;return this.panel=document.createElement("div"),this.panel.classList.add("xtechneStartupContainer"),t='<span id="XTechneStartupOsName" class="noselect">Omphal<span>OS</span></span>',this.panel.insertAdjacentHTML("beforeend",t),this.osName=document.getElementById("XTechneStartupOsName"),this.displaySurface.appendChild(this.panel),e=this,setTimeout(function(){return e.xtechne.clearSurface(e.displaySurface),e.dispatchEvent({type:"startup",message:"Startup splash finished"})},6e3)},e}()});