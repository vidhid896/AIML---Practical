% Practical 9: Hill Climbing for numerical optimization
% Maximize f(X) = 25 - (X - 5)^2 over integer X values from 0 to 10.
% The algorithm moves to a better neighbouring state until no improvement exists.

value(X, F) :-
    F is 25 - (X - 5) * (X - 5).

best_neighbor(X, Best) :-
    XLeft is X - 1,
    XRight is X + 1,
    findall(F-N,
        (member(N,[XLeft,XRight]), N >= 0, N =< 10, value(N,F)),
        Candidates),
    keysort(Candidates, Sorted),
    reverse(Sorted, [_-Best|_]).

hill_climb(Current, Optimum) :-
    value(Current, CurrentValue),
    best_neighbor(Current, Neighbor),
    value(Neighbor, NeighborValue),
    ( NeighborValue > CurrentValue
    -> hill_climb(Neighbor, Optimum)
    ;  Optimum = Current
    ).

% Example query:
% ?- hill_climb(0, Best).
% Expected optimum: Best = 5.
