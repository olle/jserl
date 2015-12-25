-module(jserl_process).

%% Behaviours
-behaviour(gen_server).

%% Callbacks for gen_server
-export([init/1]).
-export([terminate/2]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([code_change/3]).

%% Public API
-export([start_link/0]).

%% ===================================================================
%% Callbacks for gen_server
%% ===================================================================

%% @private
init(_Args) ->
  {ok, []}.

%% @private
terminate(_Reason, _State) ->
  ok.

%% @private
handle_call(_Request, _From, State) ->
  {noreply, State}.

%% @private
handle_cast(_Request, State) ->
  {noreply, State}.

%% @private
handle_info(_Info, State) ->
  {noreply, State}.

%% @private
code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%% ===================================================================
%% Public API
%% ===================================================================

start_link() ->
  gen_server:start_link(?MODULE, [], []).
