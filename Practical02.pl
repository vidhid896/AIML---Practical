% Practical 2: Arithmetic, Factorial and Fibonacci
% Run using SWI-Prolog.

% Basic arithmetic examples:
add(A, B, Result) :- Result is A + B.
subtract(A, B, Result) :- Result is A - B.
multiply(A, B, Result) :- Result is A * B.
divide(A, B, Result) :-
    B =\= 0,
    Result is A / B.

% Factorial using recursion.
factorial(0, 1).
factorial(N, Result) :-
    integer(N),
    N > 0,
    N1 is N - 1,
    factorial(N1, R1),
    Result is N * R1.

% Fibonacci: fib(N, Value), where fib(0)=0 and fib(1)=1.
fib(0, 0).
fib(1, 1).
fib(N, Value) :-
    integer(N),
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fib(N1, V1),
    fib(N2, V2),
    Value is V1 + V2.

% Generate the first N Fibonacci numbers (starting from 0).
fibonacci_series(N, Series) :-
    N >= 0,
    fibonacci_list(0, N, Series).

fibonacci_list(_, 0, []).
fibonacci_list(Index, Count, [Value|Rest]) :-
    Count > 0,
    fib(Index, Value),
    NextIndex is Index + 1,
    NextCount is Count - 1,
    fibonacci_list(NextIndex, NextCount, Rest).

% Example queries:
% ?- add(10, 5, R).
% ?- factorial(5, R).             % R = 120
% ?- fibonacci_series(7, S).      % S = [0,1,1,2,3,5,8]
