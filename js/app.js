!function(){"use strict";var e="undefined"==typeof window?global:window;if("function"!=typeof e.require){var t={},n={},i={},r={}.hasOwnProperty,s=function(e,t){var n=i[e]||i[e+"/index.js"];return n||e},o=/^\.\.?(\/|$)/,a=function(e,t){for(var n,i=[],r=(o.test(t)?e+"/"+t:t).split("/"),s=0,a=r.length;a>s;s++)n=r[s],".."===n?i.pop():"."!==n&&""!==n&&i.push(n);return i.join("/")},l=function(e){return e.split("/").slice(0,-1).join("/")},c=function(t){return function(n){var i=a(l(t),n);return e.require(i,t)}},u=function(e,t){var i={id:e,exports:{}};return n[e]=i,t(i.exports,c(e),i),i.exports},p=function(e,i){null==i&&(i="/");var o=s(e,i);if(r.call(n,o))return n[o].exports;if(r.call(t,o))return u(o,t[o]);var l=a(o,"./index");if(r.call(n,l))return n[l].exports;if(r.call(t,l))return u(l,t[l]);throw new Error('Cannot find module "'+e+'" from "'+i+'"')};p.alias=function(e,t){i[t]=e},p.register=p.define=function(e,n){if("object"==typeof e)for(var i in e)r.call(e,i)&&p.register(i,e[i]);else t[e]=n},p.list=function(){var e=[];for(var n in t)r.call(t,n)&&e.push(n);return e},p.brunch=!0,p._cache=n,e.require=p}}(),require.register("Kernel",function(e,t,n){var i,r,s,o,a;r=t("src/Exceptions/KernelPanic"),o=t("src/HTMLUtils/NodeTester"),s=t("src/IO/KeyboardListener"),a=t("src/IO/TTYManager"),n.exports=i=function(){function e(e){if(null==e)throw new r(this,"Could not acquire display, aborting");return this.displaySurface=e,this.createTTYs(),this}return e.className="Kernel",e.version="0.1",e.displaySurface=null,e.keyboardListener=null,e.TTYManager=null,e.prototype.createTTYs=function(){return this.TTYManager=new a(this,this.displaySurface,7)},e.prototype.getTTY=function(e){return this.TTYManager.getTTY(e)},e.prototype.hideTTYs=function(){return this.TTYManager.hideTTYs()},e.prototype.showTTY=function(e){return this.TTYManager.showTTY(e)},e.prototype.clearTTY=function(e){return this.TTYManager.clearTTY(e)},e.prototype.emitException=function(e,t){var n,i;if(null==t&&(t=!1),i=this.TTYManager.getTTY(1),null==i)throw new IOException("Could not acquire TTY");if(n=(new Date).toLocaleTimeString(),this.write(i,"["+n+"] %(F:yellow)Kernel exception%(F): "+e),t===!0)throw new Error(e)},e.prototype.emitMessage=function(e,t){var n,i;if(null==t&&(t=1),i=this.TTYManager.getTTY(t),null==i)throw new IOException("Could not acquire TTY");return n=(new Date).toLocaleTimeString(),this.write(i,"["+n+"] Message: "+e)},e.prototype.boot=function(){return this.write(this.getTTY(1),"Kernel version "+e.version),this.write(this.getTTY(1),"%(F:green)Welcome!%(F)"),this.write(this.getTTY(1),"Starting keyboard listener..."),this.keyboardListener=new s(this),this.keyboardListener.registerTTYCombos(),this.write(this.getTTY(1),"Loading single-user configuration...")},e.prototype.write=function(e,t){return null==e?(this.emitException("Could not find write target"),!1):o.isDOM(e)?(t=t.replace(/%\(([FB]){1}\:([\w\d]+)*\)/g,'<span class="$1 $2" data-color="$2">'),t=t.replace(/%\([FB]{1}\)/g,"</span>"),e.insertAdjacentHTML("beforeend","<span>"+t+"</span>"),!0):!1},e}()}),require.register("OS",function(e,t,n){var i,r,s,o;i=t("Kernel"),o=t("src/Xjs/XTechne"),s=t("src/Exceptions/OSException"),n.exports=r=function(){function e(e){return this.kernel=new i(e),this}return e.className="OmphalOS",e.version="0.1",e.versionName="Artemis",e.kernel=null,e.displayManager=null,e.prototype.boot=function(){if(null==this.kernel)throw new s("Could not start kernel. This is bad.");if(this.kernel.showTTY(1),this.kernel.write(this.kernel.getTTY(1),e.className+" version "+e.version+' "'+e.versionName+'"'),this.kernel.boot(),this.kernel.write(this.kernel.getTTY(1),"Starting "+o.className+" on TTY7..."),this.displayManager=new o(this.kernel,this.kernel.getTTY(7)),null==this.displayManager)throw new s(this,"Could not connect to "+o.className);return this.displayManager.init()},e}()}),require.register("src/Apps/Hermes/Hermes",function(e,t,n){var i,r,s,o=function(e,t){function n(){this.constructor=e}for(var i in t)a.call(t,i)&&(e[i]=t[i]);return n.prototype=t.prototype,e.prototype=new n,e.__super__=t.prototype,e},a={}.hasOwnProperty;s=t("src/Xjs/XTechneWindow"),r=t("src/Nomos/Nomos"),n.exports=i=function(e){function t(e){t.__super__.constructor.call(this,e,"Hermes",{size:{w:"500px",h:"400px"}}),this.initContent(),this.show()}return o(t,e),t.className="Hermes",t.layout=null,t.logo=null,t.text=null,t.prototype.initContent=function(){return this.layout=r.createLayout({type:"flex",direction:"column"}),this.logo=r.createImage("usr/share/icons/apps/hermes.svg","200px","200px"),this.text=r.createText(t.className+" - File browser","18px"),null!=this.logo&&this.layout.appendChild(this.logo),null!=this.text&&this.layout.appendChild(this.text),this.window.appendChild(this.layout)},t}(s)}),require.register("src/Exceptions/GenericException",function(e,t,n){var i;n.exports=i=function(){function e(e,t){var n,i;if(null==e)throw new Error(t);i=e.getTTY(1),n=(new Date).toLocaleString(),e.write(i,"[ "+n+" ] Generic exception: "+t)}return e.className="GenericException",e}(),i.prototype=Object.create(Error.prototype),i.prototype.name="GenericException"}),require.register("src/Exceptions/IOException",function(e,t,n){var i;n.exports=i=function(){function e(e){var t;throw t=(new Date).toLocaleTimeString(),document.getElementsByTagName("body")[0].innerHTML="[ "+t+" ] IO exception: "+e,new Error(e)}return e.className="IOException",e}(),i.prototype=Object.create(Error.prototype),i.prototype.name="IOException"}),require.register("src/Exceptions/KernelException",function(e,t,n){var i,r,s=function(e,t){function n(){this.constructor=e}for(var i in t)o.call(t,i)&&(e[i]=t[i]);return n.prototype=t.prototype,e.prototype=new n,e.__super__=t.prototype,e},o={}.hasOwnProperty;i=t("src/Exceptions/GenericException"),n.exports=r=function(e){function t(e,n){var i,r;t.__super__.constructor.call(this,n),r=e.getTTY(1),i=(new Date).toLocaleString(),e.write(r,"[ "+i+" ] Kernel exception: "+n)}return s(t,e),t.className="KernelException",t}(i),r.prototype=Object.create(Error.prototype),r.prototype.name="KernelException"}),require.register("src/Exceptions/KernelPanic",function(e,t,n){var i;n.exports=i=function(){function e(e,t){var n,i,r,s;if(null==e)throw new Error(t);if(null==e.TTYs||0===e.TTYs.length)throw new Error(t);for(s=e.TTYs[0],r=(new Date).toLocaleTimeString(),n=i=2;7>=i;n=++i)e.clearTTY(n);e.showTTY(1),e.write(s,"[ "+r+" ] %(F:red)Kernel panic%(F): "+t)}return e.className="KernelPanic",e}(),i.prototype=Object.create(Error.prototype),i.prototype.name="KernelPanic"}),require.register("src/Exceptions/OSException",function(e,t,n){var i;n.exports=i=function(){function e(e){var t;throw t=(new Date).toLocaleTimeString(),document.getElementsByTagName("body")[0].innerHTML="[ "+t+" ] System exception: "+e,new Error(e)}return e.className="OSException",e}(),i.prototype=Object.create(Error.prototype),i.prototype.name="OSException"}),require.register("src/Exceptions/XException",function(e,t,n){var i,r,s=function(e,t){function n(){this.constructor=e}for(var i in t)o.call(t,i)&&(e[i]=t[i]);return n.prototype=t.prototype,e.prototype=new n,e.__super__=t.prototype,e},o={}.hasOwnProperty;i=t("src/Exceptions/GenericException"),n.exports=r=function(e){function t(e){var n;t.__super__.constructor.call(this,e),n=document.getElementsByTagName("body")[0],n.innerHTML=e}return s(t,e),t.className="XException",t}(i),r.prototype=Object.create(Error.prototype),r.prototype.name="XException"}),require.register("src/HTMLUtils/NodeTester",function(e,t,n){var i;n.exports=i=function(){function e(){}return e.className="NodeTester",e.isNode=function(e){return null==e?!1:typeof e==typeof{}?e instanceof Node:typeof e==typeof{}&&"number"==typeof e.nodeType&&"string"==typeof e.nodeName},e.isDOM=function(e){return null==e?!1:HTMLElement===typeof{}?e instanceof HTMLElement:typeof e==typeof{}&&null!==e&&1===e.nodeType&&"string"==typeof e.nodeName},e}()}),require.register("src/IO/KeyboardListener",function(e,t,n){var i,r;i=t("src/Exceptions/IOException"),n.exports=r=function(){function e(t){if(null==t)throw new i("Somehow, could not acquire kernel. This is bad.");return this.kernel=t,null==window.keypress.Listener&&this.kernel.emitException("Cannot initialize keyboard listener",!0),this.listener=new window.keypress.Listener,this.kernel.write(this.kernel.getTTY(1),e.className+" version "+e.version),this}return e.className="KeyboardListener",e.version="0.1",e.kernel=null,e.listener=null,e.prototype.register=function(e,t,n,i){return null==e||null==t?(this.kernel.emitException("Cannot register new key listener: Invalid combo or callback"),!1):(null==n&&(n=!0),null==i&&(i=!0),this.listener.register_combo({keys:e,on_keydown:t,is_unordered:n,is_solitary:i}),!0)},e.prototype.unregister=function(e){return null==e?(this.kernel.emitException("Cannot unregister unknown key combo"),!1):(this.listener.unregister_combo(e),!0)},e.prototype.registerTTYCombos=function(){var e,t,n,r;if(null==this.kernel)throw new i("Somehow, could not acquire kernel. This is bad.");for(e=this.kernel,r=[],t=n=1;7>=n;t=++n)r.push(this.register("meta alt "+t,function(t){return e.showTTY(t.which-48)}));return r},e}()}),require.register("src/IO/TTYManager",function(e,t,n){var i,r,s;i=t("src/Exceptions/IOException"),r=t("src/HTMLUtils/NodeTester"),n.exports=s=function(){function e(e,t,n){var r,s,o,a;if(null==e)throw new i("Somehow, could not acquire kernel. This is bad.");if(this.kernel=e,null==t)throw new i("Could acquire display surface");for(this.displaySurface=t,this.TTYs=new Array,r=s=1,o=n;o>=1?o>=s:s>=o;r=o>=1?++s:--s)a=document.createElement("div"),a.classList.add("tty"),a.setAttribute("data-id",r),t.appendChild(a),this.TTYs.push(a),this.kernel.write(a,"[TTY"+r+"]")}return e.className="TTYManager",e.kernel=null,e.displaySurface=null,e.TTYs=null,e.activeTTY=1,e.prototype.getTTY=function(e){return null==e||1>e||e>7?void this.kernel.emitException("TTY"+e+" does not exist"):this.TTYs[e-1]},e.prototype.hideTTYs=function(){var e,t,n,i;for(n=this.TTYs,e=0,t=n.length;t>e;e++)i=n[e],i.classList.remove("active");return!0},e.prototype.showTTY=function(e){if(null==e)return this.kernel.emitException("Invalid TTY id"),!1;if("number"==typeof e){if(e===this.activeTTY)return!1;if(1>e||e>7)return this.kernel.emitException("TTY"+e+" does not exist"),!1;this.hideTTYs(),this.TTYs[e-1].classList.add("active"),this.activeTTY=e}else{if(!r.isDOM(e))return!1;this.hideTTYs(),e.classList.add("active"),this.activeTTY=e.getAttribute("data-id")}return!0},e.prototype.clearTTY=function(e){var t;for(t=this.getTTY(e);t.lastChild;)t.removeChild(t.lastChild);return!0},e}()}),require.register("src/JSUtils/AjaxHelper",function(e,t,n){var i;n.exports=i=function(){function e(){}return e.className="AjaxHelper",e.getJSON=function(e,t){var n;return null==e?(console.warn("no url"),null):null==t?(console.warn("no callback"),null):(e.match(/^.+(.json)$/)||(e+=".json"),n=new XMLHttpRequest,n.open("GET",e,!0),n.onload=function(){var e;return n.status>=200&&n.status<400?(e=JSON.parse(n.responseText),t(e)):console.warn("error getting data")},n.onerror=function(e){return warn(e)},n.send())},e}()}),require.register("src/JSUtils/Position",function(e,t,n){var i;n.exports=i=function(){function e(){}return e.className="Position",e.getPosition=function(e){var t,n,i,r;if(null==e)return null;for(t=0,i=0;e;)"BODY"===e.tagName?(n=e.scrollLeft||document.documentElement.scrollLeft,r=e.scrollTop||document.documentElement.scrollTop,t+=e.offsetLeft-n+e.clientLeft,i+=e.offsetTop-r+e.clientTop):(t+=e.offsetLeft-e.scrollLeft+e.clientLeft,i+=e.offsetTop-e.scrollTop+e.clientTop),e=e.offsetParent;return{x:t,y:i}},e}()}),require.register("src/Nomos/Nomos",function(e,t,n){var i;n.exports=i=function(){function e(){}return e.className="Nomos framework",e.createImage=function(e,t,n){var i;return null==e?null:(i=document.createElement("img"),i.classList.add("nomosImage"),i.src=e,null!=t&&(i.style.width=t),null!=n&&(i.style.height=n),i)},e.createText=function(e,t){var n;return null==e?null:(n=document.createElement("span"),n.classList.add("nomosTextNode"),n.innerHTML=e,null!=t&&(n.style.fontSize=t),n)},e.createLayout=function(e){var t;return null==e?null:null==e.type?null:(t=document.createElement("div"),t.classList.add("nomosLayout"),t.classList.add(e.type),null!=e.direction&&t.classList.add(e.direction),t)},e}()}),require.register("src/Xjs/XTechne",function(e,t,n){var i,r,s,o,a;i=t("src/Exceptions/XException"),a=t("src/Xjs/XTechneStartup"),o=t("src/Xjs/XTechneLogin"),s=t("src/Xjs/XTechneDesktop"),n.exports=r=function(){function e(e,t){if(null==e)throw new i("Somehow, could not acquire kernel. This is bad.");if(null==t)throw new i("Could not acquire display surface. Aborting");this.kernelInstance=e,this.displaySurface=t}return e.className="XTechne display manager",e.kernelInstance=null,e.displaySurface=null,e.displayContainer=null,e.startupManager=null,e.loginManager=null,e.desktopManager=null,e.prototype.init=function(){return this.kernelInstance.showTTY(this.displaySurface),this.kernelInstance.write(this.displaySurface,"Loading display..."),this.displaySurface.classList.add("xinstance"),this.displayContainer=document.createElement("div"),this.displayContainer.classList.add("xtechneContainer"),Waves.init(),this.clearScreen(),this.displaySurface.appendChild(this.displayContainer),this.startupManager=new a(this,this.displayContainer)},e.prototype.startLogin=function(){return this.loginManager=new o(this,this.displayContainer)},e.prototype.startDesktop=function(){var e;return e=this,this.loginManager.removeEventListener("loginSuccess"),this.loginManager.removeEventListener("loginError"),setTimeout(function(){return e.clearSurface(e.loginManager.displaySurface),delete e.loginManager,e.loginManager=null,e.desktopManager=new s(e,e.displayContainer)},600)},e.prototype.clearSurface=function(e){if(null==e)return this.kernel.emitException("Could not find XTechne surface"),!1;for(;e.lastChild;)e.removeChild(e.lastChild)},e.prototype.clearScreen=function(){for(;this.displaySurface.lastChild;)this.displaySurface.removeChild(this.displaySurface.lastChild)},e}()}),require.register("src/Xjs/XTechneDesktop",function(e,t,n){var i,r,s,o,a;r=t("src/Exceptions/XException"),o=t("src/Xjs/XTechnePanel"),i=t("src/JSUtils/AjaxHelper"),a=t("src/Xjs/XTechneStackingManager"),n.exports=s=function(){function e(e,n){var i;if(null==e)throw new r("Could not acquire "+XTechne.className+" instance");if(null==n)throw new r("Could not acquire display surface");this.xtechne=e,this.displayContainer=n,this.displaySurface=document.createElement("div"),this.displaySurface.classList.add("xtechneDesktopContainer"),this.displaySurface.classList.add("hidden"),this.displayContainer.appendChild(this.displaySurface),i=t("OS"),this.initDesktop()}return e.className="XTechneDesktop",e.xtechne=null,e.displayContainer=null,e.displaySurface=null,e.stackManager=null,e.panels=null,e.prototype.initDesktop=function(){var e;return e=this,this.stackManager=new a,i.getJSON("etc/xtechne/desktoprc",function(t){var n,i,r,s,a;for(window.xDesktop=e,e.panels=new Array,a=t.panels,n=0,i=a.length;i>n;n++)r=a[n],s=new o(e,e.displaySurface,r),s.initContent(r.contents),e.panels.push(s);return null!=t.theme&&null!=t.theme.backgroundImage&&(e.displaySurface.style.backgroundImage="url('"+t.theme.backgroundImage+"')"),e.displaySurface.classList.remove("hidden")})},e}()}),require.register("src/Xjs/XTechneLogin",function(e,t,n){var i,r,s;r=t("src/Exceptions/XException"),i=t("src/JSUtils/AjaxHelper"),n.exports=s=function(){function e(t,n){var i;if(null==t)throw new r("Could not acquire "+XTechne.className+" instance");if(null==n)throw new r("Could not acquire display surface");this.xtechne=t,this.displaySurface=n,EventDispatcher.prototype.apply(e.prototype),i=this,this.addEventListener("loginSuccess",function(e){return t.startDesktop()}),this.addEventListener("loginError",function(e){return i.displayError(e)}),this.createPanel(),Waves.attach(this.submitButton,["waves-button","waves-float","waves-light"])}var t;return e.className="XTechne login manager",e.xtechne=null,e.displaySurface=null,e.panel=null,e.box=null,e.loginForm=null,e.usernameInput=null,e.passwordInput=null,e.submitButton=null,t=!1,e.prototype.createPanel=function(){var e,t;return this.panel=document.createElement("div"),this.panel.classList.add("xtechneLoginContainer"),this.displaySurface.appendChild(this.panel),this.box=document.createElement("div"),this.box.classList.add("xtechneLoginBox"),this.panel.appendChild(this.box),t='<form action="" id="loginFormContainer"> <label for="userInputBox" class="noselect"> Username <input type="text" name="username" id="userInputBox" autocomplete="off" autofocus> </label> <label for="passwordInputBox" class="noselect"> Password <input type="password" name="password" id="passwordInputBox" autocomplete="off"> </label> <button type="submit" name="loginButton" id="loginButton" class="material button blue">Login</button> </form>',this.box.insertAdjacentHTML("beforeend",t),this.loginForm=document.getElementById("loginFormContainer"),this.usernameInput=document.getElementById("userInputBox"),this.passwordInput=document.getElementById("passwordInputBox"),this.submitButton=document.getElementById("loginButton"),e=this,this.loginForm.onsubmit=function(t){return t.preventDefault(),e.login()}},e.prototype.__get_user_hash__=function(e,t){return null==e?!1:null==t?!1:i.getJSON("etc/passwd",t)},e.prototype.displayError=function(e){var t;return console.warn(e.message),this.submitButton.disabled=!0,this.submitButton.classList.add("error"),t=this,setTimeout(function(){return t.submitButton.disabled=!1,t.submitButton.classList.remove("error")},1200)},e.prototype.login=function(){var e,n,i;return t===!0?!1:(i=this.usernameInput.value.toLowerCase(),this.usernameInput.value=i,n=String(CryptoJS.SHA3(this.passwordInput.value)),e=this,i.length>0&&e.passwordInput.value.length>0?this.__get_user_hash__(i,function(r){var s,o,a,l;for(a=null,s=0,o=r.length;o>s;s++)l=r[s],l.user===i&&(a=l.hash);return null==a||a!==n?(e.dispatchEvent({type:"loginError",message:"Bad credentials for user "+i}),!1):(t=!0,e.submitButton.disabled=!0,e.dispatchEvent({type:"loginSuccess",message:"User "+i+" logged in successfully"}),e.panel.classList.add("dismissing"),!0)}):this.dispatchEvent({type:"loginError",message:"Username or password missing"}),!1)},e}()}),require.register("src/Xjs/XTechnePanel",function(e,t,n){var i,r,s,o;i=t("src/Exceptions/XException"),o=t("src/Xjs/XTechneWindow"),s=t("src/Xjs/XTechnePanelItem"),n.exports=r=function(){function e(e,t,n){if(null==e)throw new i("Could not acquire "+XTechneDesktop.className+" instance");if(null==t)throw new i("Could not acquire display surface");this.xdesktop=e,this.displaySurface=t,this.container=document.createElement("nav"),null==n?this.container.classList.add("xtechneDesktopPanel"):this.container.classList.add(n.type),this.displaySurface.appendChild(this.container)}return e.className="XTechnePanel",e.xdesktop=null,e.displaySurface=null,e.container=null,e.elements=null,e.prototype.initContent=function(e){var t,n,i,r,o,a;for(this.elements=new Array,t=this,a=[],r=0,o=e.length;o>r;r++)i=e[r],n=new s(this,i),null!=n&&(this.container.appendChild(n.wrapper),n.initTooltip(),a.push(this.elements.push(n)));return a},e.prototype.getElementFromTarget=function(e){var t,n,i,r;for(r=this.elements,t=0,n=r.length;n>t;t++)if(i=r[t],i.domTarget===e)return i},e.prototype.getElementFromWindow=function(e){var t,n,i,r;for(r=this.elements,t=0,n=r.length;n>t;t++)if(i=r[t],null!=i.menu&&i.menu.window===e)return i},e.prototype.actionToString=function(e){return null==e?"":(e=e.split("exec ")[1],null==e?"":e=e.slice(0,1).toUpperCase()+e.slice(1).toLowerCase())},e.prototype.handleClick=function(e){var n,i,r,s;return r=this.getElementFromTarget(e.srcElement),null==r&&console.warn("Unknown panel item "+e.srcElement),"startMenuToggle"===r.action&&null!=r.menu?r.menu.toggle():r.action.match(/^exec .+$/)?r.isOpen?(s=this.xdesktop.stackManager.findByTarget(r),null!=s?s.isHidden()?s.show():s.minimize():r.setOpen(!1)):(i=r.action.split("exec ")[1],i=i.slice(0,1).toUpperCase()+i.slice(1).toLowerCase(),n=t("src/Apps/"+i+"/"+i),this.xdesktop.stackManager.register(r,new n(this.displaySurface)),r.setOpen(!0)):void 0},e}()}),require.register("src/Xjs/XTechnePanelItem",function(e,t,n){var i,r,s;s=t("src/Xjs/XTechneWindow"),i=t("src/JSUtils/Position"),n.exports=r=function(){function e(e,t){var n;return null==e?void console.warn("Cannot acquire panel instance"):null==t.type?void console.warn("Missing panelItem type for "+JSON.stringify(t)):(n=this,this.panel=e,this.type=t.type,this.wrapper=document.createElement("div"),this.wrapper.classList.add("xtechneDesktopPanelItemWrapper"),this.domTarget=document.createElement("div"),this.domTarget.classList.add(this.type),this.wrapper.appendChild(this.domTarget),"xtechneDesktopPanelSeparator"!==this.type&&(this.domTarget.style.backgroundImage="url('"+t.iconSrc+"')",this.domTarget.onclick=function(e){return n.panel.handleClick(e)},Waves.attach(this.domTarget,["waves-light"])),null!=t.onClickAction&&(this.action=t.onClickAction),void(null!=this.action&&"startMenuToggle"===this.action&&this.createStartMenu()))}return e.className="XTechnePanelItem",e.type="",e.panel=null,e.wrapper=null,e.domTarget=null,e.tooltip=null,e.action=null,e.menu=null,e.isOpen=!1,e.prototype.initTooltip=function(){var e,t;return e=this,t=this.panel.actionToString(this.action),""!==t?(this.tooltip=document.createElement("span"),this.tooltip.classList.add("tooltip"),this.tooltip.innerHTML=t,this.wrapper.appendChild(this.tooltip)):void 0},e.prototype.createStartMenu=function(){var e;return this.domTarget.id="startMenuToggler",this.menu=new s(this.panel.displaySurface,"Start",{position:{left:"0",right:null,top:null,bottom:"50px"},size:{w:"400px",h:"600px"},borders:!1,background:"#282828",stack:9999}),e=this,this.menu.window.addEventListener("blur",function(t){var n;return n=e.panel.getElementFromWindow(t.srcElement),n.menu.hide()})},e.prototype.setOpen=function(e){return this.isOpen=e,e?this.domTarget.classList.add("open"):this.domTarget.classList.remove("open")},e}()}),require.register("src/Xjs/XTechneStackingManager",function(e,t,n){var i;n.exports=i=function(){function e(){this.stack=new Array}return e.className="XTechneStackingManager",e.stack=null,e.prototype.register=function(e,t){return null==t?void console.warn("Cannot acquire window frame"):null==t?void console.warn("Cannot acquire window frame"):(this.stack.push({target:e,frame:t}),this.updateStack())},e.prototype.unregister=function(e){var t,n,i,r,s;for(null==e&&console.warn("Cannot acquire window frame"),t=-1,r=this.stack,n=0,i=r.length;i>n;n++){if(s=r[n],s.frame===e){t++;break}t++}return-1!==t?this.stack.splice(t,1):void 0},e.prototype.updateStack=function(){var e,t,n,i,r,s,o;for(e=0,o=1,i=this.stack,r=[],t=0,n=i.length;n>t;t++)s=i[t],document.contains(s.frame.window)||(s.target.setOpen(!1),this.stack.splice(e,1),this.updateStack()),s.frame.style.zIndex=o,e++,r.push(o+=100);return r},e.prototype.findByTarget=function(e){var t,n,i,r,s;for(t=0,r=this.stack,n=0,i=r.length;i>n;n++){if(s=r[n],s.target===e&&document.contains(s.frame.window))return s.frame;t++}},e.prototype.findByFrame=function(e){var t,n,i,r,s;for(t=0,r=this.stack,n=0,i=r.length;i>n;n++)s=r[n],s.frame===e&&s.target,t++},e}()}),require.register("src/Xjs/XTechneStartup",function(e,t,n){var i,r,s;i=t("src/Exceptions/XException"),r=t("src/Xjs/XTechne"),n.exports=s=function(){function e(t,n){if(null==t)throw new i("Could not acquire "+r.className+" instance");if(null==n)throw new i("Could not acquire display surface");this.xtechne=t,this.displaySurface=n,EventDispatcher.prototype.apply(e.prototype),this.addEventListener("startup",function(e){return t.startLogin()}),this.displaySplash()}return e.className="XTechneStartup",e.xtechne=null,e.displaySurface=null,e.panel=null,e.osName=null,e.prototype.displaySplash=function(){var e,n,i;return e=t("OS"),this.panel=document.createElement("div"),this.panel.classList.add("xtechneStartupContainer"),i='<span id="XTechneStartupOsName" class="noselect">Omphal<span>OS</span> <span id="XTechneStartupOsDetails" class="noselect">v'+e.version+" "+e.versionName+"</span> </span>",this.panel.insertAdjacentHTML("beforeend",i),this.osName=document.getElementById("XTechneStartupOsName"),this.displaySurface.appendChild(this.panel),n=this,setTimeout(function(){return n.xtechne.clearSurface(n.displaySurface),n.dispatchEvent({type:"startup",message:"Startup splash finished"})},6e3)},e}()}),require.register("src/Xjs/XTechneWindow",function(e,t,n){var i;n.exports=i=function(){function e(e,t,n){return null==e?void console.warn("No surface"):null==t?void console.warn("No name"):null==n?void console.warn("No style"):(this.displaySurface=e,this.name=t,this.window=document.createElement("div"),this.window.classList.add("xtechneWindow"),this.window.tabIndex=0,this.style=n,this.style.borders===!1&&this.window.classList.add("borderless"),this.hide(),void this.init(!(this.style.borders===!1)))}return e.className="XTechneWindow",e.displaySurface=null,e.name="",e.window=null,e.bar=null,e.minimizeButton=null,e.maximizeButton=null,e.closeButton=null,e.style=null,e.draggie=null,e.isMaximized=!1,e.prototype.init=function(e){return this.setSize(),this.setPosition(),this.setBackground(),this.setStack(),this.displaySurface.appendChild(this.window),e?this.initBorders():void 0},e.prototype.setSize=function(e){return null!=e?(this.window.style.width=e.w,this.window.style.height=e.h):null!=this.style.size&&null!=this.style.size.w&&null!=this.style.size.h?(this.window.style.width=this.style.size.w,this.window.style.height=this.style.size.h):void 0},e.prototype.setPosition=function(e){var t,n;if(null!=e){if(null!=e.left&&(this.window.style.left=e.left),null!=e.right&&(this.window.style.right=e.right),null!=e.top&&(this.window.style.top=e.top),null!=e.bottom)return this.window.style.bottom=e.bottom}else{if(null==this.style.position)return t=window.innerWidth/2-parseInt(this.window.style.width)/2,n=window.innerHeight/2-parseInt(this.window.style.height)/2,this.window.style.left=t+"px",this.window.style.top=n+"px";if(null!=this.style.position.left&&(this.window.style.left=this.style.position.left),null!=this.style.position.right&&(this.window.style.right=this.style.position.right),null!=this.style.position.top&&(this.window.style.top=this.style.position.top),null!=this.style.position.bottom)return this.window.style.bottom=this.style.position.bottom}},e.prototype.setBackground=function(){return null!=this.style.background?this.window.style.background=this.style.background:void 0},e.prototype.setStack=function(){return null!=this.style.stack?this.window.style.zIndex=this.style.stack:void 0},e.prototype.initBorders=function(){var e,t;return this.bar=document.createElement("div"),this.bar.classList.add("bar"),this.bar.classList.add("noselect"),t="<span class='windowBorderName'>"+this.name+"</span> <nav class='windowBorderControls'> <span class='windowBorderControl minimize'></span> <span class='windowBorderControl maximize'></span> <span class='windowBorderControl close'></span> </nav>",this.bar.insertAdjacentHTML("beforeend",t),this.window.appendChild(this.bar),this.draggie=new Draggabilly(this.window,{handle:".bar"}),this.minimizeButton=this.bar.getElementsByClassName("minimize")[0],e=this,this.minimizeButton.onclick=function(){return e.minimize()},this.maximizeButton=this.bar.getElementsByClassName("maximize")[0],this.maximizeButton.onclick=function(){return e.maximize()},this.closeButton=this.bar.getElementsByClassName("close")[0],this.closeButton.onclick=function(){return e.close()}},e.prototype.show=function(){var e;if(this.isHidden())return this.window.classList.remove("hidden"),this.window.classList.add("moving"),this.setSize(),this.setPosition(),e=this,setTimeout(function(){return e.window.classList.remove("moving"),e.window.focus()},400)},e.prototype.hide=function(){return this.window.classList.add("hidden"),this.window.blur()},e.prototype.toggle=function(){return this.isHidden?this.show():this.hide()},e.prototype.isHidden=function(){return this.window.classList.contains("hidden")},e.prototype.minimize=function(){var e,t,n;return this.window.classList.add("moving"),t="0%",n=xDesktop.stackManager.findByFrame(this.window),null!=n&&(t=n.domTarget.offsetLeft+n.domTarget.offsetWidth/2+"px"),this.setSize({w:"0px",h:"0px"}),this.setPosition({top:"100%",left:t}),this.hide(),e=this,setTimeout(function(){return e.window.classList.remove("moving")},400)},e.prototype.maximize=function(){var e;return this.window.classList.add("moving"),this.isMaximized?(this.setSize(),this.setPosition(),this.isMaximized=!1):(this.setSize({w:window.innerWidth+"px",h:window.innerHeight-40+"px"}),this.setPosition({top:0,left:0}),this.isMaximized=!0),e=this,setTimeout(function(){return e.window.classList.remove("moving")},400)},e.prototype.close=function(){var e;return e=this,this.minimizeButton.onclick=null,this.maximizeButton.onclick=null,this.closeButton.onclick=null,this.hide(),setTimeout(function(){return e.draggie.destroy(),e.draggie=null,e.displaySurface.removeChild(e.window),window.xDesktop.stackManager.updateStack()},400),null},e}()});
