%% -*- mode: erlang; tab-width: 4; indent-tabs-mode: nil; st-rulers: [132] -*-
%% vim: ts=4 sw=4 ft=erlang et
%%% % @format
%%%-------------------------------------------------------------------
%%% @author Andrew Bennett <potatosaladx@gmail.com>
%%% @copyright 2014-2022, Andrew Bennett
%%% @doc
%%%
%%% @end
%%% Created :  19 Nov 2018 by Emil Falk <emil.falk@textalk.se>
%%%-------------------------------------------------------------------

-ifndef(JOSE_COMPAT_HRL).

%% this implies OTP 21 or higher
-ifdef(OTP_RELEASE).
-define(COMPAT_CATCH(Class, Reason, Stacktrace), Class:Reason:Stacktrace).
-define(COMPAT_GET_STACKTRACE(Stacktrace), Stacktrace).

-if(?OTP_RELEASE >= 23).
-define(JOSE_CRYPTO_OTP_23, 1).
-endif.
-else.
-define(COMPAT_CATCH(Class, Reason, _), Class:Reason).
-define(COMPAT_GET_STACKTRACE(_), erlang:get_stacktrace()).
-endif.

-define(JOSE_COMPAT_HRL, 1).

-endif.
