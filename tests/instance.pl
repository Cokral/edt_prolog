/* tests/instance.pl

Tests des prédicats de `instance.pl`

@changelog
569cfb8 Guillaume Clochard      Mon Jan 2 10:09:13 2017 +0100   Ajout tests unitaires incompatibles/2
*/

:- include('../instance.pl').

:- begin_tests(incompatibles).

test("l'incompatiblité est reflexive") :- incompatibles(info, info).
test("l'incompatiblité est symétrique") :-
    incompatibles(silr_para, info),
    incompatibles(info, silr_para).

:- end_tests(incompatibles).

