successor(Number,[x|Number]).

plus(Number1, Number2, Result) :-
    append(Number1,Number2, Result).

times([],_,[]) .
times([x|Number1], Number2, Result) :-
    times(Number1,Number2,Result2),
    append(Result2,Number2, Result).

/** examples 

?- successor([x,x,x],Result).
?- successor([],Result).
?- plus([x, x], [x, x, x, x], Result).
?- times([x, x], [x, x, x, x], Result).
?- times([x, x, x, x], [x, x, x, x], Result).
*/