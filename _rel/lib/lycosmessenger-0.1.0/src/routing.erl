-module(routing).

-export([routes/0]).

routes() ->
% Host1 = {"/", site_root_handler, []},
Host2 = {"/sample", sample_auth, []},
Host3 = {"/user/login", sample_auth, []}, 
Host4 = {"/user/registration", sample_auth, []}, 
Host5 = {"/user/checkphone", sample_auth, []}, 
Host6 = {"/user/updatephone", sample_auth, []}, 
Host7 = {"/message/send", sample_auth, []}, 
Host8 = {"/message/history", sample_auth, []}, 
Host9 = {"/message/update", sample_auth, []}, 
Host10 = {"/contact/searchcontact", sample_auth, []}, 
Host11 = {"/contact/addcontact", sample_auth, []}, 
Host12 = {"/contact/updatecontact", sample_auth, []}, 
Host13 = {"/upload/file", sample_auth, []}, 

Routes = [Host2, Host3, Host4, Host5, Host6, Host7, Host8, Host9, Host10, Host11, Host12, Host13],
[{'_',Routes}]. 