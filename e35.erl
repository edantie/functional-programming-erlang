%%%-------------------------------------------------------------------
%%% @author edantie
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. Mar 2017 13:49
%%%-------------------------------------------------------------------
-module(e35).
-author("edantie").

%% API
-export([test/0]).


doubleAll([]) -> [];
doubleAll([X | Xs]) ->
  [2 * X | doubleAll(Xs)].

doubleAllMap(List) -> lists:map(fun double/1, List).
double(N) -> 2 * N.

evens([]) -> [];
evens([X | Xs]) when X rem 2 == 0 ->
  [X | evens(Xs)];
evens([_ | Xs]) ->
  evens(Xs).


evensFilter(List) -> lists:filter(fun isEven/1, List).

isEven(N) ->
  case N rem 2 of
    0 -> true;
    _ -> false
  end.

product([]) -> 1;
product([X | Xs]) -> X * product(Xs).

productReduce(L) -> lists:foldl(fun(X, Product) -> X * Product end, 1, L).

%zip([1,3,5,7], [2,4]) = [ {1,2}, {3,4} ]

zip([], _) ->
  [];
zip(_, []) ->
  [];
zip([X | Xs], [Y | Ys]) ->
  [{X, Y} | zip(Xs, Ys)].

% zip_with(fun(X,Y) -> X+Y end, [1,3,5,7], [2,4]) = [ 3, 7 ]
zip_with(_Fun, _, []) -> [];
zip_with(_Fun, [], _) -> [];
zip_with(Fun, [X | Xs], [Y | Ys]) ->
  [Fun(X, Y) | zip_with(Fun, Xs, Ys)].


% c) Re-define the function zip_with/3 using zip and lists:map
% High order function version.
zip_with_map(Fun, Xs, Ys) ->
  lists:map(fun({X, Y}) -> Fun(X, Y) end, zip(Xs, Ys)).

zip_rewritten(Xs, Ys) ->
  zip_with_map(fun(X, Y) -> {X, Y} end, Xs, Ys).

test() ->
  L = [1, 2, 3, 4],
  DoubleList = doubleAll(L),
  DoubleList = doubleAllMap(L),

  Even = evens(L),
  Even = evensFilter(L),

  Product = product(L),
  Product = productReduce(L),

  L1 = [1, 3, 5, 7],
  L2 = [2, 4],
  ZIP = [{1, 2}, {3, 4}],

  ZIP = zip(L1, L2),

  [3, 7] = zip_with(fun(X, Y) -> X + Y end, L1, L2),
  [3, 7] = zip_with_map(fun(X, Y) -> X + Y end, L1, L2),

  ZIP = zip_rewritten(L1, L2),
  success.