/* utils.pl

*/

/**
 * indiceSeance(+S, -I).
 *
 * Retourne l'indice de la séance dans sa matière
 *

                    S0               I = 0
                    |
                ----------
                |        |
                |        |
                S1       S2          I = 1
                         |
                     ---------
                     |       |
                     |       |
                     S3      S4      I = 2
                     |       |
                     ---------
                         |
                         S5          I = 3

 *
 * @arg S   Id de séance
 * @arg I   L'indice
 */
indiceSeance(S, 0) :- \+ suitSeance(S, _), \+ suitSeance(S, _, _, _), !.
indiceSeance(S, N) :-
    (suitSeance(S, S1); suitSeance(S, S1, _, _)),
    !,
    indiceSeance(S1, N1),
    N is N1 + 1,
    !.

/**
 * beforeSeance(-Order, +S1, +S2).
 *
 * R est unifié à < si S1 a un indice plus petit que S2, > sinon
 *
 * @arg Order
 * @arg S1      Id de séance
 * @arg S2      Id de séance
 */
beforeSeance(R, S1, S2) :-
    indiceSeance(S1, N1),
    indiceSeance(S2, N2),
    N2 > N1 -> R = <; R = > .


/**
 * afficherSeance(+S)
 *
 * @arg S
 */
afficherSeance(S) :-
    seance(S, TypeCours, Mat, Nom),
    write('Séance:\t\t'),
    write(S), write(' "'), write(Nom), write('"'),
    write(' - '), write(TypeCours),
    write(' - '), write(Mat).

/**
 * afficherMoment(+J, +M, +H)
 *
 * @arg J
 * @arg M
 * @arg H
 */
afficherMoment(J, M, H) :-
    plage(H, Start, End),
    write('Date:\t\t'),
    write(J), write('/'), write(M),
    write(' '), write(Start), write('-'), write(End).

/**
 * afficherGroupe(+Gs)
 *
 * @arg Gs   liste de groupes
 */
afficherGroupe([G]) :-
    write(G),
    !.
afficherGroupe([G, G2|Gs]) :-
    write(G), write(', '),
    afficherGroupe([G2|Gs]).

/**
 * afficherGroupes(+S)
 *
 * @arg S   Une séance
 */
afficherGroupes(S) :-
    findall(G, groupeSeance(G, S), Gs), % tous les groupes de la séance
    write('Groupes:\t'),
    afficherGroupe(Gs).

/**
 * afficherProf(+Ps)
 *
 * @arg Ps   liste d'enseignants
 */
afficherProf([P]) :-
    write(P),
    !.
afficherProf([P, P2|Ps]) :-
    write(P), write(', '),
    afficherProf([P2|Ps]).

/**
 * afficherProfs(+S)
 *
 * @arg S   Une séance
 */
afficherProfs(S) :-
    findall(P, profSeance(P, S), Ps), % tous les profs de la séance
    write('Profs:\t\t'),
    afficherProf(Ps).

/**
 * afficherSalle(+L)
 *
 * @arg L Une salle
 */
afficherSalle(L) :-
    salle(L, Nb),
    write('Salle:\t\t'), write(L), write('('), write(Nb), write(')').

/**
 * afficherPlanification(+Cs)
 *
 * Affiche la planification dans l'ordre chronologique
 *
 * @arg Cs  Une liste de créneaux
 */
afficherPlanification([]) :- !.
afficherPlanification(Cs) :-
    date(J, M),
    plage(H, _, _),
    member(C, Cs),
    C = [S, H, J, M, L],
    write('--------------------------------------------------------------'), nl,
    afficherSeance(S), nl,
    afficherMoment(J, M, H), nl,
    afficherGroupes(S), nl,
    afficherProfs(S), nl,
    afficherSalle(L), nl,
    delete(Cs, C, Cs2),
    afficherPlanification(Cs2),
    !.



