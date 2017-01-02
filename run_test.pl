/* run_test.pl

Joue les tests unitaires importés

@changelog
569cfb8 Guillaume Clochard      Mon Jan 2 10:09:13 2017 +0100   Ajout tests unitaires incompatibles/2
*/
:- include('./tests/instance.pl').

:- initialization main.

main :- run_tests, halt.
main :- halt(1).
