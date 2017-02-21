-module(onefifteen).
-export([exxor/2,maxThree/3,howManyEqual/3]).

exxor(false,true) ->
	true;
exxor(true,false) ->
	true;
exxor(_,_) ->
	false.

maxThree(A,B,C) ->
	max(max(A,B),C).

howManyEqual(X,X,X) ->
	3;
howManyEqual(X,_,X) ->
	2;
howManyEqual(_,X,X) ->
	2;
howManyEqual(X,X,_) ->
	2;
howManyEqual(_,_,_) ->
	0.
