-module(lycosmessenger_app).

-behaviour(application).

-export([start/2, stop/1]).

% To import functions from another module
-import(routing,[routes/0]). 

start(_Type, _Args) ->
	Dispatch = cowboy_router:compile(routes()),    

    {ok, _} = cowboy:start_http(http,100, [{port, 10003}],[{env, [{dispatch, Dispatch}]}
              ]),
	lycosmessenger_sup:start_link().

stop(_State) ->
	ok.
