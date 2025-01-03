% Vectori

scalarMult(_,[],[]).
scalarMult(N,[InHead|InTail],[OutHead|OutTail]) :-
        OutHead is N * InHead,
        scalarMult(N,InTail,OutTail).

dot([],[],0).
dot([InHead1|InTail1],[InHead2|InTail2],N) :- 
	dot(InTail1,InTail2,M),
        N is (InHead1 * InHead2) + M.

max([Max],Max).

max([Head|Tail],Max) :- 
        max(Tail,TailMax),
        Head > TailMax,
        Max = Head.

max([Head|Tail],Max) :- 
        max(Tail,TailMax),
        Head =< TailMax,
        Max = TailMax.
    
/** <examples>

?- scalarMult(3,[2,7,4],Result). 
?- dot([2,5,6],[3,4,1],Result).
?- max([4,2,6,8,1],Result).

*/