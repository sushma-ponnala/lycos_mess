-module(checkphone_handler).
		-export([init/3]).

		-export([welcome/2, terminate/3, allowed_methods/2]).
		-export([content_types_accepted/2]).
		init(_Transport, _Req, []) ->
			{upgrade, protocol, cowboy_rest}.
		allowed_methods(Req, State) ->  
		    {[<<"POST">>], Req, State}.  
		content_types_accepted(Req, State) ->
		{[{<<"application/json">>, welcome}], Req, State}.
		terminate(_Reason, _Req, _State) ->
			ok.
		welcome(Req, State) ->
		io:format(" from checkphone_handler"),
		 	{ok, ReqBody, Req2} = cowboy_req:body(Req), 	
		 	Req_Body_decoded = jsx:decode(ReqBody),
		 	[{<<"userName">>,UserName},{<<"phone">>,Phone}] = Req_Body_decoded,
		 	UserName1 = binary_to_list(UserName),
		 	io:format("UserName1 ~p ~n", [UserName1]),
		 	Phone1 = binary_to_list(Phone),
		 	io:format("Phone1 ~p ~n", [Phone1]),
		 	emysql:prepare(my_st, << "select * from lycusers where username = ? AND phone = ?">>),
		 	Result = emysql:execute(lycos_pool, my_st, [UserName1, Phone1]),
			io:format("Result is ~p ~n", [Result]),
			% {Status1, Size1, Data1, Response1, Data1, Angle12} = Result,
			% io:format("Response is ~p ~n", [Angle12]),
			% io:format("Response is ~p ~n", [Response1]),
			% io:format("Response is ~p ~n", [Response1]),
			% io:format("Size is ~p ~n", [Size1]),
			% io:format("Status is ~p ~n", [Status1]),
			Result12 = emysql:execute(lycos_pool, <<"select * from lycusers limit 1">>),
			io:format("Result12 is ~p ~n", [Result12]),




			Res1 = cowboy_req:set_resp_body(ReqBody, Req2),
			Res2 = cowboy_req:delete_resp_header(<<"content-type">>, Res1),
			Res3 = cowboy_req:set_resp_header(<<"content-type">>, <<"application/json">>, Res2),
			{true, Res3, State}.
































% % io:format("Initial Req from the request  is ~p ~n", [Req]),
% % io:format("Initial State from the request is ~p ~n", [State]),
% 	% Req_method = cowboy_req:method(Req),
% 	% io:format("Req_method is ~p ~n", [Req_method]),
% 	 {ok, <<Req_Body>>, {}} = cowboy_req:body(Req),

% 	io:format("Body is ~p ~n", [Req_Body]),
% 	Body = <<"<h1>This is a response for other methods</h1>">>,
% 	% io:format("Body is  ~p ~n",[Body]),
% 	{Body, Req, State}.
%      % Req1 = cowboy_http_req:body(Req),
% 	% io:format("Request is ~p ~n", [Req1]),
% 	% io:format("password ~p ~n",[Req]),
% 	% compile:file("/home/waheguru/erlang-projects/contentapi/src/mysql.erl"),
% 	% compile:file("/home/waheguru/erlang-projects/contentapi/src/mysql_conn.erl"),
% 	% mysql:start_link(p1, "localhost", "root", "password", "tracker"),
% 	% io:format("Request is ~p ~n",[p1]),
% 	% Result1 = mysql:fetch(p1, <<"SELECT * FROM maxcdnlogs limit 1">>),
% 	% io:format("Result1: ~p~n", [Result1]),
% 	 % mysql:start_link("localhost", "root", "password", "tracker"),
% 	% io:format("Request is ~p ~n",[Req]),


% 	% {Username, _} = cowboy_req:qs_val(<<"username">>, Req),
% 	% io:format("Username is  ~p ~n",[Username]),
% 	% {Password, _} = cowboy_req:qs_val(<<"password">>, Req),
% 	% io:format("Password is  ~p ~n",[Password]),
% 	% {Namespace, _} = cowboy_req:qs_val(<<"namespace">>, Req),
% 	% io:format("Namespace is  ~p ~n",[Namespace]),


% 	%%mysql query to execute
% 	% mysql:start_link(connection, 3306 , root, abc123, lycos),

% 	% io:format("password ~p ~n",[Password]),

% 	% {Username, _} =  cowboy_req:qs_val(<<"Username">>, Req),
% 	% {Password, _} =  cowboy_req:qs_val(<<"Password">>, Req),
% 	% {Namespace, _} = cowboy_req:qs_val(<<"Namespace">>, Req),

% 	% Body = "{ 'username':'"++binary_to_list(Username)++"'},{ 'password':'"++binary_to_list(Password)++"'},{ 'namespace':'"++binary_to_list(Namespace)++"'}",
% 	% io:format("Body is  ~p ~n",[Body]),
%     % {Body, Req, State}.