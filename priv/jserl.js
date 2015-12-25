(function(global) {
  'use strict';

  var ws = new WebSocket('ws://0.0.0.0:8911/jserl/');

  ws.onopen = function(evt) {
    console.log('web socket opened', evt);
  };
  ws.onclose = function(evt) {
    console.log('web socket closed', evt);
  };
  ws.onerror = function(evt) {
    console.log('web socket errored', evt);
  };

  var callback = null;

  ws.onmessage = function(evt) {
    (callback || function(data) {
      console.log(JSON.stringify(data));
    })(JSON.parse(evt.data));
    callback = null;
  };

  // PUBLIC API

  var jserl = global.jserl = {};

  jserl.VERSION = '0.1.0';

  jserl.spawn = function(_callback) {
    callback = _callback;
    ws.send('spawn');
  };

  jserl.processes = function(_callback) {
    callback = _callback;
    ws.send('processes');
  };

})(window || {}); // Don't break just yet.
