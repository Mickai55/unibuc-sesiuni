% n-th Fibonacci number

fib(0, 1).
fib(1, 1).
fib(N, F) :-
        fib(1,1,1,N,F).

fib(_, F1, N, N, F1).
fib(F0, F1, I, N, F) :-
        F2 is F0 + F1,
        NextI is I + 1,
        fib(F1, F2, NextI, N, F).

/** examples
 
?- fib(1,X).
?- fib(5,X). 
?- fib(20,X).
?- fib(50,X).
*/