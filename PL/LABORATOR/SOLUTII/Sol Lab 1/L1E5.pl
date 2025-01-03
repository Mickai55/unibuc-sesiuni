
/** GOT riddle 
Varys - "Power is a curious thing, my lord. Are you fond of riddles?" 
Tyrion - "Why? Am I about to hear one?" 
Varys - "Three great men sit in a room, a king, a priest and the rich man. 
         Between them stands a common sellsword. 
         Each great man bids the sellsword kill the other two. 
         Who lives? Who dies?" 
Tyrion - "Depends on the sellsword" 
*/


char(king).
char(priest).
char(richMan).

choice(god,priest). 
choice(rule,king). 
choice(gold, richMan).

is_killed(C,K1,K2) :- choice(C,T), char(K1), char(K2), K1 \= T, K2 \= T, K1\= K2.



