% Distance between two points

distance((X1,Y1),(X2,Y2),Z) 
    :- Z is sqrt((X2 - X1) ** 2 + (Y2 - Y1) ** 2).

/** examples

?- distance((0,0),(3,4),X).
?- distance((-2.5,1),(3.5,-4),X).
*/