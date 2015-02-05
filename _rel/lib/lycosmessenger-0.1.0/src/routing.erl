-module(routing).

-export([routes/0]).

routes() ->
% Host1 = {"/", site_root_handler, []},
Host2 = {"/sample", sample_auth, []},
Host3 = {"/user/login", login_handler, []}, 
Host4 = {"/user/registration", registration_handler, []}, 
Host5 = {"/user/checkphone", checkphone_handler, []}, 
Host6 = {"/user/updatephone", updatephone_handler, []}, 
Host7 = {"/message/send", message_send_handler, []}, 
Host8 = {"/message/history", message_history_handler, []}, 
Host9 = {"/message/update", message_update_handler, []}, 
Host10 = {"/contact/searchcontact", search_contact_handler, []}, 
Host11 = {"/contact/addcontact", add_contact_handler, []}, 
Host12 = {"/contact/updatecontact", update_contact_handler, []}, 
Host13 = {"/upload/file", upload_file_handler, []}, 

Routes = [Host2, Host3, Host4, Host5, Host6, Host7, Host8, Host9, Host10, Host11, Host12, Host13],
[{'_',Routes}].  