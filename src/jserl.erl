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
