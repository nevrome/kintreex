# kintreex

kintreex is an early prototype of a pedigree exploration [expert system](https://en.wikipedia.org/wiki/Expert_system) written in [prolog](https://en.wikipedia.org/wiki/Prolog). 

It contains an [R script](matrix_to_prolog_rules.R) to translate percental relationship matrizes to prolog facts of the form `first_degree(personA, personB), second_degree(personA, personC), ...` and a prolog file [`rules.pl`](rules.pl) with a set of (untested) rules like `father_of(personA,personB):- male(personA), first_degree(personA,personB).` that should apply in this system.

To use it you can load your facts file and the kintreex rules file in an interactive prolog session and explore the possible pedigrees by asking the expert system questions. For this you have to install a prolog implementation like e.g. [SWI-Prolog](https://www.swi-prolog.org/download/stable).

### Charles II example

[`example_charlesii`](example_charlesii) contains an example application prepared by Joscha Gretzinger based on the complex pedigree of [Charles II of Spain](https://en.wikipedia.org/wiki/Charles_II_of_Spain). You can start the prolog interpreter in this directory with

```
swipl -s pedigree.pl
```

and then start to ask questions

```
father_of(X, anne).
father_of(philipiii, anne).
distinct(sister_of(X,philipiv)). % only distinct solutions
findall(X,distinct(sister_of(X,philipiv)),L). % show all solutions 
```

and finally exit the interpreter console with

```
halt.
```
