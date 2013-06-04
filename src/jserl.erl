%%% 
%%% Websocket handler, should initialize socket and spawn a session
%%% for each connection - is could be re-connected, this is of course
%%% a bit of a security matter too.
%%% 
%%% Spawned sessions then allow for rpc and messaging between jserl
%%% public API and the JS "process". Will be interesting.
%%%
%%% `jserl_session` - module for processes controlling the
%%%                   connection between a JS client and the Erlang
%%%                   backend.
%%%
%%% `jserl_process` - module for jserl-processes, a decorated process
%%%                   that is represented with a public API also on
%%%                   the JS side (spawning, listing, messaging etc).
%%% 

-module(jserl).

%% Behaviours
-behaviour(application).
-behaviour(supervisor).

%% Application callbacks
-export([start/2, stop/1]).

%% Supervisor callbacks
-export([init/1]).

%% Public API
-export([start/0,
         spawn/0,
	 processes/0]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

%% @private
start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile(
		 [{'_', [
			 {"/", cowboy_static,
			  [{directory, {priv_dir, jserl, []}}, 
			   {file, "jserl.html"},
			   {mimetypes, [{<<".html">>, [<<"text/html">>]}]}]},
			 
			 {"/jserl.js", cowboy_static,
			  [{directory, {priv_dir, jserl, []}},
			   {file, "jserl.js"}, 
			   {mimetypes, [{<<".js">>, [<<"application/javascript">>]}]}]},
			 
			 {"/jserl", jserl_websocket, []}
			]}]),
    cowboy:start_http(
      jserl_http_listener,
      3,
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
    application:start(crypto),
    application:start(ranch),
    application:start(cowboy),
    application:start(jserl),
    ok.

spawn() ->
    ok. %% TODO: Spawn jserl process.

processes() ->
    []. %% TODO: List jserl processes.

%% ===================================================================
%% Private functions
%% ===================================================================
