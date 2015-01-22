{application, lycosmessenger, 
 [
	{description, "Lycos Messenger"},
	{vsn, "0.1.0"},
	{modules, [routing, request_hook_responder, lycosmessenger_sup, lycosmessenger_app, sample_auth]},
	{registered, []},
	{applications, [kernel,	stdlib,	goldrush, lager, jsx, cowboy, ibrowse, emysql, sync]},
	{mod, {lycosmessenger_app, []}},
	{env, [{http_port, 6789}, {max_connections, 2048}]}
]}.
