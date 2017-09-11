'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');
require('./css/bootswatch.css')
// require('./blog.css');
var mlBridge = require('./js/milsymbolBridge.js')
// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./elm/Main.elm');
var mountNode = document.getElementById('main');

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
var app = Elm.Main.embed(mountNode);


app.ports.prepareSymbol.subscribe(function (symbolDescription) {

    //First, get the milSymbol
    var dataportDataMiddle = mlBridge.processSymbol(symbolDescription);
    
    //Return the data to Elm
    app.ports.getSymbol.send(dataportDataMiddle);
    
  });
