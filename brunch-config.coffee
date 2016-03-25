module.exports =
paths:
    watched: ['app', 'vendor']
files:
    javascripts:
        joinTo:
            'js/app.js': /^app/,
            'js/vendor.js': /^vendor/
    stylesheets:
        joinTo:
            'css/app.css': /^app/
            'css/vendor.css': /^vendor/
    templates:
        joinTo: 'js/app.js'
