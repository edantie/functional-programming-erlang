-module(e124).
-export([perimeter/1, area/1, enclose/1, bits/1, bits_tail/1]).

%% {circle, {X,Y}, R}
%% {rectangle, {X,Y}, H, W}
%% {triangle, {X,Y}, A, B, C}
%%
%% {X,Y} : center of object
%% R : Radius
%% H : Height
%% W : Width
%%
%% A : Length of the first side of a triangle
%% B : Length of the second side of a triangle
%% C : Length of the third side of a triangle
%%

%% perimeter
%% Define a function perimeter/1 which takes a shape and returns the perimeter of the shape.
perimeter({circle, {_X,_Y}, R}) ->
	2 * math:pi() * R;

perimeter({rectangle, {_X,_Y}, H, W}) ->
	2 * (W+H);

perimeter({triangle, {_X, _Y}, A, B, C }) ->
	A + B + C.

%% area
area({rectangle, W, H}) ->
    W * H;

area({circle, {_X,_Y}, R}) ->
    math:pi() * math:pow(R, 2);

area({triangle, {X,Y}, A, B, C}) ->
    % Heron
    S = perimeter({triangle, {X,Y}, A, B, C}) / 2,
    math:sqrt(S * (S - A) * (S - B) * (S - C)).

%% enclose
%% Define a function enclose/1 that takes a shape an returns the smallest enclosing rectangle of the shape.
enclose({rectangle, {X,Y}, W, H}) ->
	{rectangle, {X,Y}, W, H};

enclose({circle, {X,Y}, R}) ->
	{rectangle, {X,Y}, 2 * R, 2 * R };

enclose({triangle, {X,Y}, A, B, C}) ->
	M = max(max(A, B), C),
	{rectangle, {X,Y}, M, 2 * area({triangle, {X,Y}, A, B, C}) / M}.

%% bits
%% Define a function bits/1 that takes a positive integer N and returns the sum of the bits in the binary representation. For example bits(7) is 3 and bits(8) is 1.
%% direct recursive
bits(0) ->
	0;
bits(N) when N>0 ->
	bits(N div 2) + (N rem 2).

%% tail recursive version
%% Better for not overloading the stack
bits_tail({0,R}) ->
	R;
bits_tail({N,R}) ->
	bits_tail({N div 2, R + (N rem 2)});
bits_tail(N) ->
	bits_tail({N,0}).
