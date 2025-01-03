% Square n x n of charactes

printLine(0,_).
printLine(1,Character) :- write(Character).
printLine(CurrentColumn,Character) :- write(Character), 
        NewColumn is CurrentColumn-1,
        printLine(NewColumn,Character).

printLine(0,_,_).
printLines(1,Rows,Character) :- printLine(Rows,Character).
printLines(CurrentRow, Rows, Character) :- 
        printLine(Rows,Character), nl, 
        NewRow is CurrentRow - 1,
        printLines(NewRow,Rows,Character).

square(Rows,Character) :- printLines(Rows,Rows,Character).

/** examples

?- square(5,'* ').
*/