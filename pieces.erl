% Define a function pieces so that pieces(N) tells you the maximum number of pieces into which you can cut a piece of paper with N cuts.
% You can see an illustration of this problem at the top of this step.
% If you’d like to take this problem further, think about the 3-dimensional case. Into how many pieces can you cut a wooden block with N saw cuts?
% Taking it even further: What is the general problem in n dimensions?

-module (pieces).
-export([pieces/1, pieces3d/1]).

% https://oeis.org/A000124
pieces(0) -> 
	1;
pieces(N) when N > 0 ->
	pieces(N-1) + N.


% https://oeis.org/A000125
pieces3d(0) ->
	1;
pieces3d(N) when N>0->
	pieces3d(N-1)+pieces(N-1).
