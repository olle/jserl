(function(global) {
  'use strict';

	var response = function () {};

  var ws = new WebSocket('ws://localhost:8911/jserl/');

  ws.onopen = function (msg) {
    console.log('web socket opened', msg);
  };

  ws.onmessage = function (msg) {
    console.info('message arrived', msg);
		response = function () { return msg.data; };
  };

  // PUBLIC API

  var jserl = global.jserl = {};

  jserl.VERSION = '0.1.0';

  jserl.spawn = function() {
    // TODO: Spawn process on server.
  };

  jserl.processes = function() {
		ws.send('processes');
		return setTimeout(function () {
			response.call();
		}, 123);
    //return []; // TODO: Return list of processes.
  };

})(window || {}); // Don't break just yet.
