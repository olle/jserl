-module(jserl_websocket).

%% Behaviours
-behaviour(cowboy_websocket_handler).

% Cowboy Websocket Handler callbacks
-export([init/3,
	 websocket_init/3,
	 websocket_handle/3,
	 websocket_info/3,
	 websocket_terminate/3]).

%% ===================================================================
%% Cowboy Websocket Handler callbacks
%% ===================================================================

init({tcp, http}, Req, _Opts) ->
   {upgrade, protocol, cowboy_websocket}.

websocket_init(_TransportName, Req, _Opts) ->
    erlang:start_timer(1000, self(), <<"Hello!">>),
    {ok, Req, undefined_state}.

websocket_handle({text, Msg}, Req, State) ->
    {reply, {text, << "That's what she said! ", Msg/binary >>}, Req, State};
websocket_handle(_Data, Req, State) ->
    {ok, Req, State}.

websocket_info({timeout, _Ref, Msg}, Req, State) ->
    erlang:start_timer(1000, self(), <<"How' you doin'?">>),
    {reply, {text, Msg}, Req, State};
websocket_info(_Info, Req, State) ->
    {ok, Req, State}.

websocket_terminate(_Reason, _Req, _State) ->
    ok.

%% ===================================================================
%% Public API
%% ===================================================================

%% ===================================================================
%% Private functions
%% ===================================================================
