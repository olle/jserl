-module(jserl).

%% Behaviours
-behaviour(application).
-behaviour(supervisor).

%% Application callbacks
-export([start/2]).
-export([stop/1]).

%% Supervisor callbacks
-export([init/1]).

%% Public API
-export([start/0]).
-export([spawn/0]).
-export([processes/0]).

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
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% @private
stop(_State) ->
    ok.

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

%% @private
init([]) ->
    {ok, { {one_for_one, 5, 10}, []} }.

%% ===================================================================
%% Public API
%% ===================================================================

start() ->
    ok = application:start(crypto),
    ok = application:start(ranch),
    ok = application:start(cowlib),
    ok = application:start(cowboy),
    ok = application:start(jserl),
    ok.

spawn() ->
    ok. %% TODO: Spawn jserl process.

processes() ->
    []. %% TODO: List jserl processes.

%% ===================================================================
%% Private functions
%% ===================================================================
