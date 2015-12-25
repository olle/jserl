-module(jserl_websocket).

% Cowboy Websocket Handler callbacks
-export([init/2]).
-export([websocket_handle/3]).
-export([websocket_info/3]).

% Testing
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

%% ===================================================================
%% Cowboy Websocket Handler callbacks
%% ===================================================================

init(Req, _Opts) ->
  {cowboy_websocket, Req, []}.

websocket_handle({text, <<"processes">>}, Req, State) ->
  Procs = jserl:processes(),
  ProcsJSON = pids_to_json(Procs),
  {reply, {text, ProcsJSON}, Req, State};
websocket_handle({text, <<"spawn">>}, Req, State) ->
  Pid = jserl:spawn(),
  PidJSON = pid_to_json(Pid),
  {reply, {text, PidJSON}, Req, State};
websocket_handle(_Data, Req, State) ->
  {ok, Req, State}.

websocket_info(_Info, Req, State) ->
  {ok, Req, State}.

%% ===================================================================
%% Public API
%% ===================================================================

%% ===================================================================
%% Private functions
%% ===================================================================

pids_to_json([]) ->
  <<"[]">>;
pids_to_json(Procs) ->
  pids_to_json(Procs, []).

pids_to_json([Proc | Rest], []) ->
  PidJSON = pid_to_json(Proc),
  JSON = [PidJSON],
  pids_to_json(Rest, JSON);
pids_to_json([Proc | Rest], JSON) ->
  PidJSON = pid_to_json(Proc),
  JSON2 = JSON ++ [<<",">>, PidJSON],
  pids_to_json(Rest, JSON2);
pids_to_json([], JSON) ->
  erlang:iolist_to_binary([<<"[">>] ++ JSON ++ [<<"]">>]).

pid_to_json(Pid) ->
  LPid = pid_to_list(Pid),
  SPid = list_to_binary(LPid),
  Obj = {[{pid, SPid}]},
  jiffy:encode(Obj).

%% ===================================================================
%% EUnit Tests
%% ===================================================================

-ifdef(TEST).

pid_to_json_test() ->
  Pid = erlang:list_to_pid("<0.1.2>"),
  Actual = pid_to_json(Pid),
  Expected = <<"{\"pid\":\"<0.1.2>\"}">>,
  ?assertEqual(Expected, Actual).

pids_to_json_test() ->
  Pid1 = erlang:list_to_pid("<0.1.1>"),
  Pid2 = erlang:list_to_pid("<0.1.2>"),
  Pids = [Pid1, Pid2],
  Actual = pids_to_json(Pids),
  Expected = <<"[{\"pid\":\"<0.1.1>\"},{\"pid\":\"<0.1.2>\"}]">>,
  ?assertEqual(Expected, Actual).

-endif.
