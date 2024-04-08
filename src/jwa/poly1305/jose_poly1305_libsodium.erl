%%%-----------------------------------------------------------------------------
%%% Copyright (c) Andrew Bennett
%%%
%%% This source code is licensed under the MIT license found in the
%%% LICENSE.md file in the root directory of this source tree.
%%%
%%% @author Andrew Bennett <potatosaladx@gmail.com>
%%% @copyright (c) Andrew Bennett
%%% @doc
%%%
%%% @end
%%% Created :  07 Sep 2022 by Andrew Bennett <potatosaladx@gmail.com>
%%%-----------------------------------------------------------------------------
%%% % @format
-module(jose_poly1305_libsodium).

-behaviour(jose_provider).
-behaviour(jose_poly1305).

%% jose_provider callbacks
-export([provider_info/0]).
%% jose_poly1305 callbacks
-export([
    poly1305_mac/2
]).

%%%=============================================================================
%%% jose_provider callbacks
%%%=============================================================================

-spec provider_info() -> jose_provider:info().
provider_info() ->
    #{
        behaviour => jose_poly1305,
        priority => normal,
        requirements => [
            {app, libsodium},
            libsodium_crypto_onetimeauth_poly1305
        ]
    }.

%%%=============================================================================
%%% jose_poly1305 callbacks
%%%=============================================================================

-spec poly1305_mac(Message, OneTimeKey) -> Tag when
    Message :: jose_poly1305:message(),
    OneTimeKey :: jose_poly1305:poly1305_one_time_key(),
    Tag :: jose_poly1305:poly1305_tag().
poly1305_mac(Message, OneTimeKey) when bit_size(OneTimeKey) =:= 256 ->
    libsodium_crypto_onetimeauth_poly1305:crypto_onetimeauth_poly1305(Message, OneTimeKey).
