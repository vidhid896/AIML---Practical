% Practical 11: Map Coloring as a Constraint Satisfaction Problem
% Australia map-coloring example.

color(red).
color(green).
color(blue).

different(A, B) :- A \= B.

map_coloring([WA, NT, SA, Q, NSW, V, T]) :-
    color(WA), color(NT), color(SA),
    color(Q), color(NSW), color(V), color(T),

    different(WA, NT),
    different(WA, SA),
    different(NT, SA),
    different(NT, Q),
    different(SA, Q),
    different(SA, NSW),
    different(SA, V),
    different(Q, NSW),
    different(NSW, V).

% Tasmania (T) has no land border in this simplified map and may use any color.
% Example query:
% ?- map_coloring(Colors).
