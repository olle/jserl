(function(global) {
  'use strict';

  var ws = new WebSocket('ws://localhost:8911/jserl/');

  ws.onopen = function (msg) {
    console.log('web socket opened', msg);
  };

  ws.onmessage = function (msg) {
    console.info('message arrived', msg);
  };

  // PUBLIC API

  var jserl = global.jserl = {};

  jserl.VERSION = '0.1.0';

  jserl.spawn = function() {
    // TODO: Spawn process on server.
  };

  jserl.processes = function() {
		ws.send('processes');
    //return []; // TODO: Return list of processes.
  };

})(window || {}); // Don't break just yet.
