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


:- begin_tests(memeMomentCreneau).

test("memeMomentCreneau est faux si le mois est différent") :-
    C = [1, 1, 1, 2, a1],
    \+ memeMomentCreneau(1, 1, 1, C).

test("memeMomentCreneau est faux si le jour est différent") :-
    C = [1, 1, 2, 1, a1],
    \+ memeMomentCreneau(1, 1, 1, C).

test("memeMomentCreneau est faux si l'heure est différente") :-
    C = [1, 2, 1, 1, a1],
    \+ memeMomentCreneau(1, 1, 1, C).

test("memeMomentCreneau est vrai sinon") :-
    C = [1, 1, 1, 1, a1],
    memeMomentCreneau(1, 1, 1, C).

:- end_tests(memeMomentCreneau).


:- begin_tests(memeProf).

test("memeProf est vrai si la séance concerne le prof ") :-
    C = [1, 1, 1, 1, a1],
    memeProf(martinez, C).

test("memeProf est faux sinon") :-
    C = [11, 1, 1, 1, a1],
    \+ memeProf(martinez, C).

:- end_tests(memeProf).


:- begin_tests(groupeIncompatibleCreneau).

test("groupeIncompatibleCreneau est vrai si le groupe est incompatible avec
    le groupe de la séance ") :-
    C = [1, 1, 1, 1, a1],
    groupeIncompatibleCreneau(id, C).

test("groupeIncompatibleCreneau est faux sinon") :-
    C = [11, 1, 1, 1, a1],
    \+ groupeIncompatibleCreneau(silr2, C).

:- end_tests(groupeIncompatibleCreneau).


:- begin_tests(creneauValideCreneau).

test("creneauValideCreneau est faux si prof incompatible et meme moment") :-
    C = [11, 1, 1, 1, a1],
    \+ creneauValideCreneau(kuntz, silr2, 1, 1, 1, C).

test("creneauValideCreneau est faux si groupe incompatible et meme moment") :-
    C = [11, 1, 1, 1, a1],
    \+ creneauValideCreneau(martinez, id, 1, 1, 1, C).

test("creneauValideCreneau est vrai sinon") :-
    C = [11, 1, 1, 1, a1],
    % moment différent
    creneauValideCreneau(martinez, silr2, 1, 1, 2, C),
    % prof et groupe différent
    creneauValideCreneau(martinez, silr2, 1, 1, 1, C).

:- end_tests(creneauValideCreneau).


:- begin_tests(creneauValide).

test("creneauValide est vrai si il n'y a pas de créneaux") :-
    creneauValide(martinez, silr2, 1, 1, 2, []).

test("creneauValide est vrai si il n'y a que des créneaux valides") :-
    C1 = [11, 1, 1, 1, a1],
    C2 = [12, 1, 1, 1, a1],
    C3 = [1, 2, 1, 1, a1],
    C4 = [11, 1, 1, 3, a1],
    creneauValide(martinez, silr2, 1, 1, 1, [C1, C2, C3, C4]).

test("creneauValide est faux si il y a au moins un créneau problématique") :-
    C0 = [1, 1, 1, 1, a1],
    C1 = [11, 1, 1, 1, a1],
    C2 = [12, 1, 1, 1, a1],
    C3 = [1, 2, 1, 1, a1],
    C4 = [11, 1, 1, 3, a1],
    \+ creneauValide(martinez, silr2, 1, 1, 1, [C1, C2, C0, C3, C4]).

:- end_tests(creneauValide).


:- begin_tests(effectifGroupes).

test("effectifGroupes renvoit 0 si pas de groupes") :- effectifGroupes([], 0).
test("effectifGroupes renvoit le bon effectif") :-
    effectifGroupes([id, silr], 62).

:- end_tests(effectifGroupes).
