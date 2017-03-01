%%%-------------------------------------------------------------------
%%% @author edantie
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Feb 2017 07:45
%%%-------------------------------------------------------------------
-module(week2).
-author("edantie").

%% API

% call test to run tests
-export([index/1, test/0, find/2]).

% Used to read a file into a list of lines.
% Example files available in:
%   gettysburg-address.txt (short)
%   dickens-christmas.txt  (long)
% Get the contents of a text file into a list of lines.
% Each line has its trailing newline removed.
get_file_contents(Name) ->
  {ok, File} = file:open(Name, [read]),
  Rev = get_all_lines(File, []),
  lists:reverse(Rev).

% Auxiliary function for get_file_contents.
% Not exported.
get_all_lines(File, Partial) ->
  case io:get_line(File, "") of
    eof -> file:close(File),
      Partial;
    Line -> {Strip, _} = lists:split(length(Line) - 1, Line),
      get_all_lines(File, [Strip | Partial])
  end.


index(Name) ->
  Lines = toUpper(get_file_contents(Name)),
  ValidWords = convertToValidWords(Lines),

  _Indexed = generate_index(ValidWords, 1, []).

% Split a line into words and remove invalid words (commons or smalls ones)
convertToValidWords([]) ->
  [];
convertToValidWords([X | Xs]) ->
  Words = string:tokens(X, " .,;:\\\'\"-?!"),
  [keepValidWords(Words) | convertToValidWords(Xs)].

keepValidWords([]) -> "";
keepValidWords([X | Xs]) ->
  % 3 is to keep words longer than 3 characters
  case isValidWord(X, 3) of
    true -> [X | keepValidWords(Xs)];
    false -> keepValidWords(Xs)
  end.

% Check if a word is Valid: not common and more than a specified size
isValidWord(Word, MinLength) ->
  case (length(Word) =< MinLength) of
    true -> false;
    false -> isNotCommon(Word)
  end.

% Check if a word is common or not
% Words must be in upper case
isNotCommon(Word) ->
  case Word of
    "BECAUSE" -> false;
    "HAVE" -> false;
    "WHAT" -> false;
    "THEY" -> false;
    _ -> true
  end.

% change lines to Upper Case
toUpper([]) -> [];
toUpper([X | Xs]) ->
  [string:to_upper(X) | toUpper(Xs)].

% Generate index for each line
generate_index([], _Line, Acc) ->
  Acc;
generate_index([X | Xs], Line, Acc) ->
  generate_index(Xs, Line + 1, update_index(X, Line, Acc)).

% Core function: update the index (Stored in Index)
update_index([], _Line, Index) ->
  Index;
update_index([Word | Xs], Line, Index) ->
  % if word is in index
  case isWordInIndex(Word, Index) of
    true ->
      % Update index and continue with next line
      update_index(Xs, Line, update_index_word(Word, Line, Index));
    false ->
      % insert into index and continue with next line
      update_index(Xs, Line, insert_index_word(Word, Line, Index))
  end.

% Check if a word is already in index or not
isWordInIndex(_Word, []) ->
  false;
isWordInIndex(Word, [{Word, _} | _Xs]) ->
  true;
isWordInIndex(Word, [_X | Xs]) ->
  isWordInIndex(W, Xs).

% Insert a word into index
insert_index_word(Word, Line, Index) ->
  [{Word, [{Line, Line}]} | Index].

% Update a word into the index (add new line number)
update_index_word(_Word, _Line, []) ->
  [];
update_index_word(Word, Line, [{Word, Lines} | Xs]) ->
  % Word is found in list
  [{Word, update_index_word_with_line(Line, Lines)} | update_index_word(Word, Line, Xs)];
update_index_word(Word, Line, [X | Xs]) ->
  [X | update_index_word(Word, Line, Xs)].

% Update tuples of a word to add the line number Line into the tuple
update_index_word_with_line(Line, []) ->
  [{Line, Line}];
update_index_word_with_line(Line, [{Start, End} = X | Lines]) ->
  % If line number
  case Line =< End + 1 of
    true ->
      [{Start, Line} | Lines];
    false ->
      [X | update_index_word_with_line(Line, Lines)]
  end.

find(Word, Index) ->
  findWord(string:to_upper(Word), Index).

findWord(_Word, []) ->
  [];
findWord(Word, [{Word, _Lines} = Index | _Indexes]) ->
  Index;
findWord(Word, [_Index | Indexes]) ->
  findWord(Word, Indexes).


%% Thinking how you could make the data representation more efficient than the one you first chose. This might be efficient for lookup only, or for both creation and lookup.
%% Index word with real position in text : word it at X characters from start.

%% How to extend the solution:
%% Maybe it's possible to extend the

test() ->
%  INDEX = index("gettysburg-address.txt"),
  INDEX = index("dickens-christmas.txt"),
  {"MAKE",
    [{299,299},
      {340,341},
      {827,827},
      {989,989},
      {1460,1460},
      {1476,1476},
      {1755,1755},
      {1913,1913},
      {2018,2018},
      {2445,2445},
      {2702,2702},
      {2820,2820},
      {2824,2824},
      {3035,3035},
      {3109,3109},
      {3461,3461},
      {3754,3754}]} = find("make", INDEX),

  success.

