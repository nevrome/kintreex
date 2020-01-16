:- include('rules.pl').

/* parents */
male(dad).
female(mom).
female(child).
first_degree(dad, child).
first_degree(child, dad).
first_degree(mom, child).
first_degree(child, mom).

:- begin_tests(parents).
test('father_of') :- father_of(dad, child).
test('father_of') :- father_of(X, child), X == dad.
test('mother_of') :- mother_of(mom, child).
test('mother_of') :- mother_of(X, child), X == mom.
test('parent_of', [true, nondet]) :- parent_of(dad, child).
test('parent_of', [true, nondet]) :- parent_of(mom, child).
test('parents_of') :- parents_of(X, Y, child), X == mom, Y == dad.
:- end_tests(parents).

run_tests(parents).

