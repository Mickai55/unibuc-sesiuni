squareAux(N,N,N,C) :- write(C).
squareAux(I,N,N,C) :- write(C), nl, Aux is I+1, squareAux(Aux,1,N,C).
squareAux(I,J,N,C) :- write(C), Aux is J+1, squareAux(I,Aux,N,C).

square(N,C) :- squareAux(1,1,N,C).