-module(jserl_websocket).

% Cowboy Websocket Handler callbacks
-export([init/2]).
-export([websocket_handle/3]).
-export([websocket_info/3]).

%% ===================================================================
%% Cowboy Websocket Handler callbacks
%% ===================================================================

init(Req, _Opts) ->
  {cowboy_websocket, Req, []}.

websocket_handle({text, <<"processes">>}, Req, State) ->
  % TODO: Replace this mockup!
  SPid = list_to_binary(pid_to_list(self())),
  In1 = {[{pid, SPid}]},
  Json = jiffy:encode([In1]),
  {reply, {text, Json}, Req, State};
websocket_handle({text, <<"spawn">>}, Req, State) ->
  % TODO: Replace this mockup!
  SPid = list_to_binary(pid_to_list(self())),
  In1 = {[{pid, SPid}]},
  Json = jiffy:encode([In1]),
  {reply, {text, Json}, Req, State};
websocket_handle({text, Msg}, Req, State) ->
  {reply, {text, << "That's what she said! ", Msg/binary >>}, Req, State};
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
