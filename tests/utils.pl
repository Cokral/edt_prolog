/* tests/utils.pl

*/
:- include('../utils.pl').

:- begin_tests(indiceSeance).

test("indiceSeance renvoie 0 si la séance ne suit rien") :-
    indiceSeance(1, 0).

test("indiceSeance renvoie le nombre de séances précédentes sinon") :-
    indiceSeance(2, 1).
    % indiceSeance(8, 2).

:- end_tests(indiceSeance).
