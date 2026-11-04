% Practical 3: Append, Reverse, Member Search and Length
% Run using SWI-Prolog.

% Append two lists.
my_append([], List, List).
my_append([Head|Tail], List, [Head|Result]) :-
    my_append(Tail, List, Result).

% Reverse a list using an accumulator.
my_reverse(List, Reversed) :-
    reverse_acc(List, [], Reversed).

reverse_acc([], Accumulator, Accumulator).
reverse_acc([Head|Tail], Accumulator, Reversed) :-
    reverse_acc(Tail, [Head|Accumulator], Reversed).

% Check whether an element is present.
my_member(Element, [Element|_]).
my_member(Element, [_|Tail]) :-
    my_member(Element, Tail).

% Find list length recursively.
my_length([], 0).
my_length([_|Tail], Length) :-
    my_length(Tail, TailLength),
    Length is TailLength + 1.

% Example queries:
% ?- my_append([1,2], [3,4], R).
% ?- my_reverse([a,b,c], R).
% ?- my_member(b, [a,b,c]).
% ?- my_length([10,20,30], N).
