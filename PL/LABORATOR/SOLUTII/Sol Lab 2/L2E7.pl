
remove_duplicates([],[]).

remove_duplicates([Head|Tail], Result) :-
    member(Head,Tail),
    remove_duplicates(Tail,Result).

remove_duplicates([Head|Tail], [Head|Result]) :-
    not(member(Head,Tail)),
    remove_duplicates(Tail,Result).


/** examples

?- remove_duplicates([a, b, a, c, d, d], List).

*/