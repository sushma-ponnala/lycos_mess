-module(lycosmessenger_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
	Dispatch = cowboy_router:compile(routes()),    

    {ok, _} = cowboy:start_http(http,100, [{port, 10003}],[{env, [{dispatch, Dispatch}]}
              ]),
	lycosmessenger_sup:start_link().

stop(_State) ->
	ok.
	
routes() ->
	[
		{'_',[
                {"/", site_root_handler, []},
                {"/sample", sample_auth, []}
        ]}		
	]
.


