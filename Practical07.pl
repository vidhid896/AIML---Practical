% Practical 7: Greedy Best-First Search
% Selects the next node with the smallest heuristic value.
% This is a demonstration graph; heuristic values estimate distance to goal.

edge(a, b). edge(a, c).
edge(b, d). edge(b, e).
edge(c, f). edge(c, g).
edge(d, h). edge(e, h).
edge(f, h). edge(g, h).

heuristic(a, 7).
heuristic(b, 6).
heuristic(c, 4).
heuristic(d, 5).
heuristic(e, 3).
heuristic(f, 2).
heuristic(g, 1).
heuristic(h, 0).

greedy_best_first(Start, Goal, Path) :-
    greedy([[Start]], Goal, ReversePath),
    reverse(ReversePath, Path).

greedy([[Goal|Rest]|_], Goal, [Goal|Rest]).
greedy(Paths, Goal, Result) :-
    select_best_path(Paths, [Current|Rest], Remaining),
    findall([Next,Current|Rest],
            (edge(Current, Next), \+ member(Next, [Current|Rest])),
            NewPaths),
    append(Remaining, NewPaths, Updated),
    Updated \= [],
    greedy(Updated, Goal, Result).

select_best_path(Paths, Best, Remaining) :-
    findall(H-P, (member(P, Paths), P = [Node|_], heuristic(Node, H)), Pairs),
    keysort(Pairs, [_-Best|_]),
    select(Best, Paths, Remaining).

% Example query:
% ?- greedy_best_first(a, h, Path).
