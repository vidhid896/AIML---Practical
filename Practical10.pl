% Practical 10: Simulated Annealing (deterministic demonstration)
% Maximize f(X) = 25 - (X - 5)^2 for X in 0..10.
% A worse move may be accepted depending on temperature.
% random_between/3 is provided by SWI-Prolog's library(random).

:- use_module(library(random)).

objective(X, Score) :-
    Score is 25 - (X - 5) * (X - 5).

neighbor(X, Next) :-
    ( X > 0, X < 10 ->
        random_between(0,1,Direction),
        (Direction = 0 -> Next is X - 1 ; Next is X + 1)
    ; X =:= 0 -> Next = 1
    ; Next = 9
    ).

simulated_annealing(Initial, Best) :-
    objective(Initial, InitialScore),
    anneal(Initial, InitialScore, 10.0, 0.90, 0.1, Best, _).

anneal(Current, CurrentScore, Temperature, Cooling, Minimum, Best, BestScore) :-
    ( Temperature < Minimum ->
        Best = Current,
        BestScore = CurrentScore
    ;
        neighbor(Current, Next),
        objective(Next, NextScore),
        Difference is NextScore - CurrentScore,
        ( Difference >= 0 ->
            Chosen = Next, ChosenScore = NextScore
        ;
            Probability is exp(Difference / Temperature),
            random_float(RandomValue),
            ( RandomValue < Probability ->
                Chosen = Next, ChosenScore = NextScore
            ;
                Chosen = Current, ChosenScore = CurrentScore
            )
        ),
        NewTemperature is Temperature * Cooling,
        anneal(Chosen, ChosenScore, NewTemperature, Cooling, Minimum, Best, BestScore)
    ).

% Example query:
% ?- simulated_annealing(0, Best).
% The result may vary because the algorithm uses random choices.
