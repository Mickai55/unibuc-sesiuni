all_a([]).
all_a([a|Tail]) :- all_a(Tail).

trans_a_b([],[]).
trans_a_b([a|InputTail],[b|OutputTail]) :- 
    trans_a_b(InputTail,OutputTail).

/** examples

?- all_a([a,a,a,a]).
?- all_a([a,a,A,a]).
?- all_a([a,b,a,a]).
?- trans_a_b([a,a,a],L).
?- trans_a_b([a,a,a],[b]).

*/
