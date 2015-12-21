-module(jserl_sup).

%% Behaviours
-behaviour(supervisor).

%% Supervisor callbacks
-export([init/1]).

%% Public API
-export([start_link/0]).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

%% @private
init([]) ->
  Procs = [],
  {ok, { {one_for_one, 5, 10}, Procs} }.

%% ===================================================================
%% Public API
%% ===================================================================

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).
