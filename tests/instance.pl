/* tests/instance.pl

Tests des prédicats de `instance.pl`

@changelog
569cfb8 Guillaume Clochard      Mon Jan 2 10:09:13 2017 +0100   Ajout tests unitaires incompatibles/2
*/

:- include('../instance_old.pl').

:- begin_tests(incompatibles).

test("l'incompatiblité est reflexive") :- incompatibles(info, info).
test("l'incompatiblité est symétrique") :-
    incompatibles(silr_para, info),
    incompatibles(info, silr_para).

:- end_tests(incompatibles).

:- begin_tests(dateBefore).

test("dateBefore: 1/01 < 2/01") :- dateBefore(1, 1, 2, 1).
test("dateBefore: 2/01 > 1/01") :- \+ dateBefore(2, 1, 1, 1).

:- end_tests(dateBefore).

