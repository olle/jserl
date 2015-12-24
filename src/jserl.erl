-module(jserl).

%% Public API
-export([start/0]).
-export([spawn/0]).
-export([processes/0]).

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
  {ok, Pid} = jserl_server:spawn(),
  Pid.

processes() ->
  {ok, Procs} = jserl_server:processes(),
  Procs.

%% ===================================================================
%% Private functions
%% ===================================================================
