/* tests/instance.pl
*
 * Tests des prédicats de `instance.pl`
 *
 * @changelog
 * 5f85b31 Guillaume Clochard      Tue Jan 10 08:44:36 2017 +0100  Fix tests sequencement
 * 2117e90 Guillaume Clochard      Mon Jan 9 21:24:55 2017 +0100   Début instance semestre
 * 0a74c23 Guillaume Clochard      Tue Jan 3 14:41:09 2017 +0100   Add dateBefore/4
 * 62e1e1b Guillaume Clochard      Mon Jan 2 10:19:27 2017 +0100   Ajout changelogs
 * 569cfb8 Guillaume Clochard      Mon Jan 2 10:09:13 2017 +0100   Ajout tests unitaires incompatibles/2
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

