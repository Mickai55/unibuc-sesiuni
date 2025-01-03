
reverse(X,Y) :- reverse(X,[],Y).

reverse([],X,X).
reverse([X|Y],Z,T) :- reverse(Y,[X|Z],T).

palindrome([]).
palindrome(X) :- reverse(X,X).

/** examples

?- palindrome([r,e,d,i,v,i,d,e,r]).
?- palindrome([1,2,3,4,3,2,1]).
?- palindrome([1,2,3,2,2,1]).

*/