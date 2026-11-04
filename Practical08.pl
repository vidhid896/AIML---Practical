% Practical 8: A* Search
% A* evaluates f(n) = g(n) + h(n).
% The graph is undirected and edge costs are positive.

edge(a,b,1). edge(a,c,4).
edge(b,d,2). edge(b,e,5).
edge(c,e,1). edge(d,f,3).
edge(e,f,2). edge(e,g,5).
edge(f,g,1).

heuristic(a,6).
heuristic(b,5).
heuristic(c,4).
heuristic(d,3).
heuristic(e,2).
heuristic(f,1).
heuristic(g,0).

connected(X,Y,C) :- edge(X,Y,C).
connected(X,Y,C) :- edge(Y,X,C).

a_star(Start, Goal, Path, Cost) :-
    heuristic(Start, H),
    a_star_search([[H,0,[Start]]], Goal, ReversePath, Cost),
    reverse(ReversePath, Path).

a_star_search([[_,Cost,[Goal|Rest]]|_], Goal, [Goal|Rest], Cost).
a_star_search(Open, Goal, Path, Cost) :-
    select([_,G,[Current|Rest]], Open, Remaining),
    findall([F2,G2,[Next,Current|Rest]],
        ( connected(Current,Next,Step),
          \+ member(Next,[Current|Rest]),
          G2 is G + Step,
          heuristic(Next,H),
          F2 is G2 + H
        ),
        Children),
    append(Remaining, Children, NewOpen),
    sort(NewOpen, SortedOpen),
    a_star_search(SortedOpen, Goal, Path, Cost).

% Example query:
% ?- a_star(a, g, Path, Cost).
