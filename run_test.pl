/* run_test.pl

Joue les tests unitaires importés

@changelog
3eb734e Guillaume Clochard      Tue Jan 10 09:45:05 2017 +0100  Ajout indiceSeance/2
2619d84 Guillaume Clochard      Tue Jan 3 17:20:55 2017 +0100   Ajout typesCoursIdentiques/569cfb8 Guillaume Clochard      Mon Jan 2 10:09:13 2017 +0100   Ajout tests unitaires incompatibles/2
*/
:- include('./tests/instance.pl').
:- include('./tests/utils.pl').
:- include('./tests/planifier.pl').

:- initialization main.

main :- run_tests, halt.
main :- halt(1).
