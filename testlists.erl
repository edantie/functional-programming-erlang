%%%-------------------------------------------------------------------
%%% @author edantie
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. Feb 2017 20:58
%%%-------------------------------------------------------------------
-module(testlists).
-author("edantie").

%% API
-export([productList/1, productListDirect/1, maximumList/1, maximumListDirect/1, testing/0]).

productList(L) ->
  productList(L, 1).

productList([], S) ->
  S;

productList([X | Xs], S) ->
  productList(Xs, X * S).

productListDirect([]) ->
  1;

productListDirect([X | Xs]) ->
  X * productListDirect(Xs).


maximumList(L) when L /= [] ->
  maximumList(L, 0).

maximumList([], M) ->
  M;

maximumList([X | Xs], M) ->
  case max(X, M) of
    M ->
      maximumList(Xs, M);
    X ->
      maximumList(Xs, X)
  end.

maximumListDirect([X | []]) ->
  X;
maximumListDirect([X | Xs]) ->
  max(X, maximumListDirect(Xs)).

testing() ->
  L = [1, 2, 3, 4, 5, 6, 7, 8, 9],

  362880 = productListDirect(L),
  362880 = productList(L),

  %maximumList([]), % Exception
  9 = maximumList(L),
  9 = maximumListDirect(L),

  success
.