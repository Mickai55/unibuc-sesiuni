num_aparitii([],_,0).
num_aparitii([H|T], X, R):- num_aparitii(T,X,P), (X = H, R is P + 1 ; X \= H, R = P).

lista_cifre1(X, [X]):- X < 10.
lista_cifre1(Nr, [C|L]):- Nr > 9, C is Nr mod 10, Nr1 is Nr div 10, lista_cifre1(Nr1,L).
lista_cifre(Nr, L):- lista_cifre1(Nr, L1), reverse(L1, L).

permcirc([],[]).
permcirc([H|T],L) :- append(T,[H],L).

lpermcirc(L,L,[L]).
lpermcirc(L,M,[M|LP]) :- L\=M,permcirc(M,N),lpermcirc(L,N,LP).
listpermcirc(L,LP) :- permcirc(L,M),lpermcirc(L,M,LP).


elimina([],_,[]).
elimina([X|T],X, Tt):- elimina(T,X,Tt).
elimina([X|T], Y, [X|Tt]):- X \= Y, elimina(T, Y, Tt).

multime([],[]).
multime([H|T],[H|L]) :- elimina(T,H,M),multime(M,L).

emult([]).
emult([H|T]) :- emult(T),not(member(H,T)).

inters([],_,[]).
inters(_,[],[]).
inters([H|L1], L2, R):- not(member(H,L2)), inters(L1,L2,R).
inters([H|L1], L2, [H|R]):- member(H,L2), inters(L1,L2,R).

diff([],_,[]).
diff(_,[],[]).
diff([H|L1], L2, R):- member(H,L2), diff(L1,L2,R).
diff([H|L1], L2, [H|R]):- not(member(H,L2)), diff(L1,L2,R).

element_ori_multime(_,[],[]).
element_ori_multime(X,[H|T],[(X,H)|R]):- element_ori_multime(X,T,R).

prod_cartezian([],_,[]).
prod_cartezian([H1|T1],L2, R):-
    element_ori_multime(H1,L2,R1),
    prod_cartezian(T1,L2,R2),
    append(R1,R2,R).

srd(nil,[]).
srd(arb(R,S,D), L):- srd(S,Ls), srd(D,Ld), append(Ls,[R|Ld], L).

rsd(nil,[]).
rsd(arb(R,S,D), L):- rsd(S,Ls), rsd(D,Ld), append([R|Ls],Ld, L).

sdr(nil,[]).
sdr(arb(R,S,D), L):- sdr(S,Ls), sdr(D,Ld), append(Ls,Ld, L1),append(L1,[R],L).


% arb(1,arb(2,nil,arb(3,nil,nil)),arb(4,arb(5,nil,nil),arb(6,nil,nil)))


listafrunze(nil,[]).
listafrunze(arb(F,nil,nil),[F]).
listafrunze(arb(_,S,D),L) :- (S\=nil;D\=nil),!,listafrunze(S,M),listafrunze(D,N),append(M,N,L).
