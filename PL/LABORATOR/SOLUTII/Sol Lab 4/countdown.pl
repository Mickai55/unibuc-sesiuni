:- include('words.pl').

/* slip word in letters */
word_letters(Word,Letters) :- atom_chars(Word,Letters).

/* delete first occurrence of an element from a list */
remove_first(Element,[Element|Tail],Tail).
remove_first(Element,[Head|Tail],[Head|Result]) :- 
            remove_first(Element,Tail,Result).
/* the same as select(X,L,R) */			
			

/* check if a list covers another list */

cover([],_).
cover([Head|Tail], List2) :- 
            select(Head,List2,Result), 
            cover(Tail,Result).

/* find a word Word of length Score with letters in ListLetters */
solution(ListLetters, Word, Score) :- 
    word(Word),
    word_letters(Word,Letters),
    length(Letters, Score),
    cover(Letters,ListLetters).

search_solution(_,'no solution',0).
search_solution(ListLetters,Word,X) :- solution(ListLetters,Word,X).
search_solution(ListLetters,Word,X) :- Y is X-1, search_solution(ListLetters,Word,Y).

topsolution(ListLetters,Word) :- length(ListLetters, Score),
    search_solution(ListLetters,Word,Score).
	

