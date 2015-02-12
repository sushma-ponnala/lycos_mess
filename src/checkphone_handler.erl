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
 	{ok, _ReqBody, Req2} = cowboy_req:body(Req), 
 	lager:log(info, [], " Req2 ~p ~n", [Req2]),


 	Req_Body_decoded = jsx:decode(_ReqBody),
 	io:format("Req_Body_decoded is ~p ~n ", [Req_Body_decoded]),
 	[{<<"userName">>,UserName},{<<"phone">>,Phone}] = Req_Body_decoded,

 	
 	UserName1 = binary_to_list(UserName),lager:log(info, [], " UserName1 ~p ~n", [UserName1]),
 	Phone1 = binary_to_list(Phone),
 	emysql:prepare(my_st, << "select * from lycusers where phone = ?">>),
 	Result = emysql:execute(lycos_pool, my_st, [Phone1]),
	Result_list = emysql:as_proplist(Result),
	% Result_length = length(Result_list),

	Res1Body = case length(Result_list) =:= 0 of
		true -> jsx:encode([{<<"query">>,0}, {<<"articles">>,<<"zero">>}]);
		false -> jsx:encode([{<<"query">>,1}, {<<"articles">>,<<"non-zero">>}])
	end,
	% Resp =  if Result_length =/= 0 -> "Phone number taken";
	% 		  true -> 	"phone number not taken"
	% 		end,
			% io:format("~p ~n Resp is ", [Resp]), 
	%ResponseBody=jsx:encode([{<<"query">>,Result_length}, {<<"articles">>, list_to_binary(Resp)}]),
	% Res1Body=,
	%lager:log(info, [], " ResponseBody ~p ~n", [ResponseBody]),



	
	% {ResponseBody, Req, State}.
	% ResBody = jsx:encode([{<<"status">>, <<"success">>}]),
	Res1 = cowboy_req:set_resp_body(Res1Body, Req2),
	Res2 = cowboy_req:delete_resp_header(<<"content-type">>, Res1),
	Res3 = cowboy_req:set_resp_header(<<"content-type">>, <<"application/json">>, Res2),
	{true, Res3, State}.


