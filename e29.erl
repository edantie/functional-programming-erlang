%%%-------------------------------------------------------------------
%%% @author edantie
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. Feb 2017 13:30
%%%-------------------------------------------------------------------
-module(e29).
-author("edantie").

%% API
-export([double/1, evens/1, test/0, median/1, modes/1]).


double([]) ->
  [];

double([X | Xs]) ->
  [2 * X | double(Xs)].


evens([]) ->
  [];

evens([X | Xs]) ->
  case (X rem 2) of
    0 -> [X | evens(Xs)];
    _ -> evens(Xs)
  end.


median(L) ->
  median(lists:sort(L), length(L) div 2, 0).

median([_X | Xs], Size, Count) when Size > Count ->
  median(Xs, Size, Count + 1);

median([X | _Xs], _Size, _Count) ->
  X.

modes([]) ->
  [];
modes(L) ->
  Sorted = lists:sort(L),
  modes(tl(Sorted), hd(Sorted), [], 1).

% modes ( ListToAnalyze, Element to analyze, Result so far, Counter for actual element so far)
modes([], E, R, Acc) ->
  [{E, Acc} | R];

modes([X | Xs], E, R, Acc) ->
  case X of
    E -> modes(Xs, X, R, Acc + 1);
    _ -> modes(Xs, X, [{E, Acc} | R], 1)
  end.


test() ->
  L = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
  [0, 2, 4, 6, 8, 10, 12, 14, 16, 18] = double(L),
  [0, 2, 4, 6, 8] = evens(L),
  5 = median(L),
  [{10, 2}, {1, 4}, {0, 5}] = modes([0, 1, 0, 1, 0, 1, 0, 10, 10, 1, 0]),
  [{9, 1}, {8, 1}, {7, 1}, {6, 1}, {5, 1}, {4, 1}, {3, 1}, {2, 1}, {1, 1}, {0, 1}] = modes(L),
  success
.

