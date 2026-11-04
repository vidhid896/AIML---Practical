% Practical 6: Breadth-First Search (shortest path in an unweighted graph)
% Run using SWI-Prolog.

% Undirected graph edges.
edge(a, b). edge(b, a).
edge(a, c). edge(c, a).
edge(b, d). edge(d, b).
edge(c, d). edge(d, c).
edge(c, e). edge(e, c).
edge(d, f). edge(f, d).
edge(e, f). edge(f, e).
edge(f, g). edge(g, f).

% bfs(Start, Goal, Path) returns a shortest path.
bfs(Start, Goal, Path) :-
    bfs_queue([[Start]], Goal, ReversePath),
    reverse(ReversePath, Path).

bfs_queue([[Goal|Rest]|_], Goal, [Goal|Rest]).
bfs_queue([[Current|Rest]|Queue], Goal, Path) :-
    findall([Next,Current|Rest],
            (edge(Current, Next), \+ member(Next, [Current|Rest])),
            NewPaths),
    append(Queue, NewPaths, UpdatedQueue),
    bfs_queue(UpdatedQueue, Goal, Path).

% Example query:
% ?- bfs(a, g, Path).
