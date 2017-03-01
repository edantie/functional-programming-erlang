%%%-------------------------------------------------------------------
%%% @author edantie
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Feb 2017 09:15
%%%-------------------------------------------------------------------
-module(e218).
-author("edantie").

%% API
-export([join/2, member/2, concat/1, merge_sort/1, test/0, quick_sort/1, perms/1]).

%% "hel"++"lo" = "hello"

join([], L) ->
  L;
join(L, []) ->
  L;
join([X | Xs], L) ->
  [X | join(Xs, L)].


%% lists:concat(["goo","d","","by","e"]) = "goodbye"

concat([X | Xs]) ->
  concat(join(X, []), Xs).

concat(ACUM, []) ->
  ACUM;

concat(ACUM, [X | Xs]) ->
  concat(join(ACUM, X), Xs).


%Define a function member/2 that tests whether its first argument is a member of its second argument, which is a list.
member(_N, []) ->
  false;
member(N, [N | _Xs]) ->
  true;
member(N, [_X | Xs]) ->
  member(N, Xs).


%Merge sort: divide the list into two halves of (approximately) equal length, sort them (recursively) and then merge the results.

merge_sort([]) ->
  [];
merge_sort(A) ->
  S = length(A) div 2,
  {First, Last} = lists:split(S, A),
  merge_sort(First, Last).

merge_sort([], L) ->
  L;
merge_sort(L, []) ->
  L;

merge_sort([A | As] = L1, [B | Bs] = L2) ->
  case A < B of
    true ->
      [A | merge_sort(merge_sort(As, L2))];
    _ ->
      [B | merge_sort(merge_sort(Bs, L1))]
  end.


%Quicksort: split the list into two according to whether the items are smaller than (or equal to) or larger than the pivot,
% often taken to be the head element of the list; sort the two halves and join the results together.

quick_sort([]) ->
  [];

quick_sort([X | Xs]) ->
  {Less, Greater} = partitions(X, Xs, [], []),
  join(quick_sort(Less), [X | quick_sort(Greater)]).

partitions(_X, [], Less, Greater) ->
  {Less, Greater};
partitions(X, [L | Ls], Less, Greater) ->
  case X < L of
    true -> partitions(X, Ls, Less, [L | Greater]);
    false -> partitions(X, Ls, [L | Less], Greater)
  end.


% Insertion sort: sort the tail of the list and then insert the head of the list in the correct place.

%TODO

% A permutation of a list xs consists of the same elements in a (potentially) different order. Define a function that gives all the permutations of a list, in some order. For example:
% perms([]) = [[]]
% perms([1,2,3]) = [[1,2,3],[2,3,1],[3,1,2],[2,1,3],[1,3,2],[3,2,1]]

%TODO
perms([]) ->
  [[]];
perms([X | Xs] = L) ->
  perms(X, L).

perms(X, []) ->
  X;
perms(V, [X | Xs]) ->
  perms(Xs).


test() ->
  "goodbye" = join("good", "bye"),

  "goodbye" = concat(["goo", "d", "", "by", "e"]),

  true = member(2, [2, 0, 0, 1]),
  false = member(20, [2, 0, 0, 1]),

  L = [1, 2, 3, 4, 6, 5, 7, 4, 8, 3, 9],
  M = merge_sort(L),
  Q = quick_sort(L),
  M = Q
%  success
.