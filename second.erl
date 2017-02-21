-module (second).
-export([hypotenuse/2,perimeter/2,area/2]).

hypotenuse(A,B) ->
	first:square(A) + first:square(B).

perimeter(A,B) ->
	hypotenuse(A,B) + A + B.

area(A,B) ->
	first:area(A,B) / 2.

