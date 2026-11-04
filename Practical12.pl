% Practical 12: N-Queens using Backtracking
% queens(N, Positions): Positions gives the row of the queen in each column.
% Example: queens(4, Positions).

queens(N, Positions) :-
    numlist(1, N, Columns),
    place_queens(Columns, [], Positions).

place_queens([], Positions, Positions).
place_queens([Column|Rest], Placed, Positions) :-
    between(1, 100, Row),
    % Restrict rows to 1..N using the number of columns.
    length([Column|Rest], Remaining),
    length(Placed, AlreadyPlaced),
    N is Remaining + AlreadyPlaced,
    Row =< N,
    safe(Row, Placed, 1),
    place_queens(Rest, [Row|Placed], Positions).

safe(_, [], _).
safe(Row, [PreviousRow|Rest], Distance) :-
    Row =\= PreviousRow,
    abs(Row - PreviousRow) =\= Distance,
    NextDistance is Distance + 1,
    safe(Row, Rest, NextDistance).

% Example query:
% ?- queens(4, Positions).
% One valid result is [3,1,4,2] (ordering may differ).
