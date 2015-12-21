-module(jserl_app).

%% Behaviours
-behaviour(application).

%% Application callbacks
-export([start/2]).
-export([stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

%% @private
start(_StartType, _StartArgs) ->
  Dispatch = cowboy_router:compile([
    {'_', [
        {"/",            cowboy_static, {priv_file, jserl, "jserl.html"}}
      , {"/favicon.ico", cowboy_static, {priv_file, jserl, "favicon.ico"}}
      , {"/jserl.js",    cowboy_static, {priv_file, jserl, "jserl.js"}}
      , {"/jserl/",      jserl_websocket, []}
    ]}
  ]),
  {ok, _} = cowboy:start_http(jserl_http_listener, 1,
    [{port, 8911}],
    [{env, [{dispatch, Dispatch}]}]),
  jserl_sup:start_link().

%% @private
stop(_State) ->
    ok.
