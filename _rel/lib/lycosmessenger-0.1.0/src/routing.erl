-module(routing).

-export([routes/0]).

routes() ->
% Host1 = {"/", site_root_handler, []},
Host2 = {"/sample", sample_auth, []},
Routes = [ Host2],
[{'_',Routes}].