-module(sample_auth).
-export([init/3]).

-export([content_types_provided/2]).
% -export([]).
-export([welcome/2, terminate/3, allowed_methods/2]).
% -export([]).

%% Init
init(_Transport, _Req, []) ->
	{upgrade, protocol, cowboy_rest}.

%% Callbacks
  allowed_methods(Req, State) ->  
    {[<<"GET">>, <<"POST">>], Req, State}.  

% content_types_accepted(Req, State) ->
% {[{{<<"application">>, <<"json">>, []}, welcome}], Req, State}.
content_types_provided(Req, State) ->
	{[		
		{<<"text/html">>, welcome}	
	], Req, State}.

terminate(_Reason, _Req, _State) ->
	ok.

%% API
welcome(Req, State) ->
io:format("into Welcome definition ************************************"),
	{Method, Req2} = cowboy_req:method(Req),
		io:format("Method is ~p ~n ", [Method]),
		io:format("Req2 is ~p ~n ", [Req2]),
		Req1 = cowboy_req:method(Req),
     % Req1 = cowboy_http_req:body(Req),
	io:format("Request is ~p ~n", [Req1]),
	% io:format("password ~p ~n",[Req]),
	% compile:file("/home/waheguru/erlang-projects/contentapi/src/mysql.erl"),
	% compile:file("/home/waheguru/erlang-projects/contentapi/src/mysql_conn.erl"),
	% mysql:start_link(p1, "localhost", "root", "password", "tracker"),
	% io:format("Request is ~p ~n",[p1]),
	% Result1 = mysql:fetch(p1, <<"SELECT * FROM maxcdnlogs limit 1">>),
	% io:format("Result1: ~p~n", [Result1]),
	 % mysql:start_link("localhost", "root", "password", "tracker"),
	% io:format("Request is ~p ~n",[Req]),


	% {Username, _} = cowboy_req:qs_val(<<"username">>, Req),
	% io:format("Username is  ~p ~n",[Username]),
	% {Password, _} = cowboy_req:qs_val(<<"password">>, Req),
	% io:format("Password is  ~p ~n",[Password]),
	% {Namespace, _} = cowboy_req:qs_val(<<"namespace">>, Req),
	% io:format("Namespace is  ~p ~n",[Namespace]),


	%%mysql query to execute
	% mysql:start_link(connection, 3306 , root, abc123, lycos),

	% io:format("password ~p ~n",[Password]),

	{Username, _} =  cowboy_req:qs_val(<<"Username">>, Req),
	{Password, _} =  cowboy_req:qs_val(<<"Password">>, Req),
	{Namespace, _} = cowboy_req:qs_val(<<"Namespace">>, Req),

	Body = "{ 'username':'"++binary_to_list(Username)++"'},{ 'password':'"++binary_to_list(Password)++"'},{ 'namespace':'"++binary_to_list(Namespace)++"'}",
	io:format("Body is  ~p ~n",[Body]),
    {Body, Req, State}.

    