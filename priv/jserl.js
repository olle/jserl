;
(function(global) {

	var jserl = global['jserl'] = {};

	var ws = new WebSocket('ws://localhost:8911/jserl/');

	ws.onopen = function (msg) {
		console.log(msg);
	};

	ws.onmessage = function (msg) {
		//console.info(msg);
	}

	// PUBLIC API

	jserl.VERSION = '0.1.0';

	jserl.spawn = function() {
		// TODO: Spawn process on server.
	};

	jserl.processes = function() {
		return []; // TODO: Return list of processes.
	};

})(window || {}); // Don't break just yet.
