/* tests/planifier.pl

Tests des prédicats de `planifier.pl`

@changelog
*/

:- include('../planifier.pl').

:- begin_tests(typesCoursIdentiques).

test("typesCoursIdentiques est vrai si les types cours sont identiques") :-
    typesCoursIdentiques(cm, cm).

test("typesCoursIdentiques est faux les types cours sont différents") :-
    \+ typesCoursIdentiques(cm, td).

:- end_tests(typesCoursIdentiques).

:- begin_tests(profDisponibleCreneau).

test("profDisponibleCreneau est vrai si le mois est différent") :-
    C = [1, 1, 1, 2, a1],
    profDisponibleCreneau(martinez, 1, 1, 1, C).

test("profDisponibleCreneau est vrai si le jour est différent") :-
    C = [1, 1, 2, 1, a1],
    profDisponibleCreneau(martinez, 1, 1, 1, C).

test("profDisponibleCreneau est vrai si l'heure est différente") :-
    C = [1, 2, 1, 1, a1],
    profDisponibleCreneau(martinez, 1, 1, 1, C).

test("profDisponibleCreneau est vrai si la séance ne concerne pas le prof ") :-
    C = [11, 1, 1, 1, a1],
    profDisponibleCreneau(martinez, 1, 1, 1, C).

test("profDisponibleCreneau est faux sinon") :-
    C = [1, 1, 1, 1, a1],
    \+ profDisponibleCreneau(martinez, 1, 1, 1, C).

:- end_tests(profDisponibleCreneau).

:- begin_tests(profDisponible).

test("profDisponible est vrai si il n'y a pas de créneaux") :-
    profDisponible(martinez, 1, 1, 1, []).

test("profDisponible est vrai si il n'y a que des créneaux libres pour lui") :-
    C1 = [1, 1, 1, 2, a1],
    C2 = [1, 1, 2, 1, a1],
    C3 = [1, 2, 1, 1, a1],
    C4 = [11, 1, 1, 1, a1],
    profDisponible(martinez, 1, 1, 1, [C1, C2, C3, C4]).

test("profDisponible est faux si il y a au moins un créneau problématique") :-
    C0 = [1, 1, 1, 1, a1],
    C1 = [1, 1, 1, 2, a1],
    C2 = [1, 1, 2, 1, a1],
    C3 = [1, 2, 1, 1, a1],
    C4 = [11, 1, 1, 1, a1],
    \+ profDisponible(martinez, 1, 1, 1, [C1, C2, C0, C3, C4]).

:- end_tests(profDisponible).

:- begin_tests(effectifGroupes).

test("effectifGroupes renvoit 0 si pas de groupes") :- effectifGroupes([], 0).
test("effectifGroupes renvoit le bon effectif si pas de groupes") :-
    effectifGroupes([id, silr], 62).

:- end_tests(effectifGroupes).
