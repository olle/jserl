(function(global) {
	'use strict';

	var jserl = global['jserl'] = {};

	//var ws = new WebSocket('ws://localhost:8911/jserl/');
	//var socket = io('http://localhost:8911/jserl/');

	// ws.onopen = function (msg) {
	// 	console.log(msg);
	// };
  //
	// ws.onmessage = function (msg) {
	// 	//console.info(msg);
	// };

	// PUBLIC API

  // TODO: This should be set on connect!
	jserl.VERSION = '0.2.0';

	jserl.spawn = function() {
		// TODO: Spawn process on server.
	};

	jserl.processes = function() {
		return []; // TODO: Return list of processes.
	};

})(window || {}); // Don't break just yet.
