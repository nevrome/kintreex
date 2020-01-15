/* Facts */
male(philipdrei).
male(philipvier).
/*male(LouisXIV).
male(CharlesII.
male(LeopoldI).*/
female(margaret).
female(mariaanna).
female(anne).
/*female(Elisabeth).
female(Mariana).
female(MariaTheresa).
female(MargaretTheresa).*/

first_degree(philipdrei, margaret).
first_degree(philipdrei, anne).
first_degree(philipdrei, philipvier).
first_degree(philipdrei, mariaAnna).
first_degree(philipvier, anne).
 
/* Rules */
father_of(X,Y):- male(X), first_degree(X,Y).

mother_of(X,Y):- female(X), first_degree(X,Y).


