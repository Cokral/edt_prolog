/* tests/utils.pl
 *
 * @changelog
 * 58acf14 Guillaume Clochard      Tue Jan 10 10:11:59 2017 +0100  Ajout beforeSeance/3
 * 3eb734e Guillaume Clochard      Tue Jan 10 09:45:05 2017 +0100  Ajout indiceSeance/2
 */
:- include('../utils.pl').

:- begin_tests(indiceSeance).

test("indiceSeance renvoie 0 si la séance ne suit rien") :-
    indiceSeance(1, 0).

test("indiceSeance renvoie le nombre de séances précédentes sinon") :-
    indiceSeance(2, 1),
    indiceSeance(8, 2).

:- end_tests(indiceSeance).

:- begin_tests(beforeSeance).

test("beforeSeance renvoie < si S1 est avant S2") :-
    beforeSeance(<, 1, 2).

test("beforeSeance renvoie > si S2 est après S1") :-
    beforeSeance(>, 8, 2).

test("beforeSeance renvoie > si S2 au même indice que S1") :-
    beforeSeance(>, 2, 2).

:- end_tests(beforeSeance).
