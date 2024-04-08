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
%%% Created :  07 Jan 2016 by Andrew Bennett <potatosaladx@gmail.com>
%%%-----------------------------------------------------------------------------
%%% % @format
-module(jose_jwa_curve25519).

-behaviour(jose_provider).
-behaviour(jose_curve25519).

%% jose_provider callbacks
-export([provider_info/0]).
%% jose_curve25519 callbacks
-export([
    eddsa_keypair/0,
    eddsa_keypair/1,
    eddsa_secret_to_public/1,
    ed25519_sign/2,
    ed25519_verify/3,
    ed25519ctx_sign/3,
    ed25519ctx_verify/4,
    ed25519ph_sign/2,
    ed25519ph_sign/3,
    ed25519ph_verify/3,
    ed25519ph_verify/4,
    x25519_keypair/0,
    x25519_keypair/1,
    x25519_secret_to_public/1,
    x25519_shared_secret/2
]).

%%%=============================================================================
%%% jose_provider callbacks
%%%=============================================================================

-spec provider_info() -> jose_provider:info().
provider_info() ->
    #{
        behaviour => jose_curve25519,
        priority => low,
        requirements => [
            {app, crypto},
            crypto,
            {app, jose},
            jose_jwa_ed25519,
            jose_jwa_x25519
        ]
    }.

%%%=============================================================================
%%% jose_curve25519 callbacks
%%%=============================================================================

% EdDSA
eddsa_keypair() ->
    jose_jwa_ed25519:keypair().

eddsa_keypair(Seed) when
    is_binary(Seed)
->
    jose_jwa_ed25519:keypair(Seed).

eddsa_secret_to_public(SecretKey) when
    is_binary(SecretKey)
->
    jose_jwa_ed25519:secret_to_pk(SecretKey).

% Ed25519
ed25519_sign(Message, SecretKey) when
    is_binary(Message) andalso
        is_binary(SecretKey)
->
    jose_jwa_ed25519:ed25519_sign(Message, SecretKey).

ed25519_verify(Signature, Message, PublicKey) when
    is_binary(Signature) andalso
        is_binary(Message) andalso
        is_binary(PublicKey)
->
    try
        jose_jwa_ed25519:ed25519_verify(Signature, Message, PublicKey)
    catch
        _:_ ->
            false
    end.

% Ed25519ctx
ed25519ctx_sign(Message, SecretKey, Context) when
    is_binary(Message) andalso
        is_binary(SecretKey) andalso
        is_binary(Context) andalso
        byte_size(Context) =< 255
->
    jose_jwa_ed25519:ed25519ctx_sign(Message, SecretKey, Context).

ed25519ctx_verify(Signature, Message, PublicKey, Context) when
    is_binary(Signature) andalso
        is_binary(Message) andalso
        is_binary(PublicKey) andalso
        is_binary(Context) andalso
        byte_size(Context) =< 255
->
    try
        jose_jwa_ed25519:ed25519ctx_verify(Signature, Message, PublicKey, Context)
    catch
        _:_ ->
            false
    end.

% Ed25519ph
ed25519ph_sign(Message, SecretKey) when
    is_binary(Message) andalso
        is_binary(SecretKey)
->
    jose_jwa_ed25519:ed25519ph_sign(Message, SecretKey).

ed25519ph_sign(Message, SecretKey, Context) when
    is_binary(Message) andalso
        is_binary(SecretKey) andalso
        is_binary(Context) andalso
        byte_size(Context) =< 255
->
    jose_jwa_ed25519:ed25519ph_sign(Message, SecretKey, Context).

ed25519ph_verify(Signature, Message, PublicKey) when
    is_binary(Signature) andalso
        is_binary(Message) andalso
        is_binary(PublicKey)
->
    try
        jose_jwa_ed25519:ed25519ph_verify(Signature, Message, PublicKey)
    catch
        _:_ ->
            false
    end.

ed25519ph_verify(Signature, Message, PublicKey, Context) when
    is_binary(Signature) andalso
        is_binary(Message) andalso
        is_binary(PublicKey) andalso
        is_binary(Context) andalso
        byte_size(Context) =< 255
->
    try
        jose_jwa_ed25519:ed25519ph_verify(Signature, Message, PublicKey, Context)
    catch
        _:_ ->
            false
    end.

% X25519
x25519_keypair() ->
    jose_jwa_x25519:keypair().

x25519_keypair(Seed) when
    is_binary(Seed)
->
    jose_jwa_x25519:keypair(Seed).

x25519_secret_to_public(SecretKey) when
    is_binary(SecretKey)
->
    jose_jwa_x25519:sk_to_pk(SecretKey).

x25519_shared_secret(MySecretKey, YourPublicKey) when
    is_binary(MySecretKey) andalso
        is_binary(YourPublicKey)
->
    jose_jwa_x25519:x25519(MySecretKey, YourPublicKey).
