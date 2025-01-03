
element_at([Head|_],1,Head).
element_at([_|List],Index,Result) :-
    NewIndex is Index - 1,
    element_at(List,NewIndex,Result).

/** examples

?- element_at([tiger, dog, teddy_bear, horse, cow], 3, X). 
?- element_at([a, b, c, d], 27, X).
*/