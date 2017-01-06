/* planifier.pl

*/

/**
 * typesCoursIdentiques(X, Y).
 *
 * @arg X Un type de cours
 * @arg Y Un type de cours
 */
typesCoursIdentiques(X, X).

/**
 * memeMomentCreneau(H, J, M, C).
 *
 * Définit si les deux créneaux sont au même moment.
 *
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg C   Un créneau [S, H, J, M, L]
 */
memeMomentCreneau(H, J, M, [_, H2, J2, M2, _]) :- H = H2, J = J2, M = M2, !.

/**
 * memeProf(P, C).
 *
 * Définit si P est le prof du créneau C.
 *
 * @arg P   L'enseignant
 * @arg C   Un créneau [S, H, J, M, L]
 */
memeProf(P, [S, _, _, _, _]) :-
    profSeance(P2, S),
    P2 = P,
    !.

/**
 * groupeIncompatibleCreneau(G, C).
 *
 * Définit si G est incompatible avec le groupe de C. 
 *
 * @arg G   Le groupe
 * @arg C   Un créneau [S, H, J, M, L]
 */
groupeIncompatibleCreneau(G, [S, _, _, _, _]) :-
    groupeSeance(G2, S),
    incompatibles(G, G2),
    !.

/**
 * creneauValide(P, G, H, J, M, Cs).
 *
 * Définit si un cours n'est pas incompatible au moment donné avec les autres
 * cours de la liste de créneaux.
 * 
 * @arg P   L'enseignant
 * @arg G   Le groupe
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg Cs  Un créneau [S, H, J, M, L]
 */
creneauValideCreneau(P, G, H, J, M, C) :- (\+ memeMomentCreneau(H, J, M, C), !);
                                    (
                                        \+ groupeIncompatibleCreneau(G, C),
                                        \+ memeProf(P, C),
                                        !
                                    ).

/**
 * creneauValide(P, G, H, J, M, [Cs]).
 *
 * Définit si un creneau est valide (Pas de conflit de groupe ou d'enseignant).
 *
 * @arg P   L'enseignant
 * @arg G   Le groupe
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg Cs  Liste de créneaux [S, H, J, M, L]
 */
creneauValide(_, _, _, _, _, []):- !.
creneauValide(P, G, H, J, M, [C|Cs]):-
    creneauValideCreneau(P, G, H, J, M, C),
    creneauValide(P, G, H, J, M, Cs),
    !.

/**
 * effectifGroupes(+Gs, -S)
 *
 * @arg Gs  Liste de groupes
 * @arg S   Somme des effectifs des groupes
 */
effectifGroupes([], 0) :- !.
effectifGroupes([G], S) :- groupe(G, S), !.
effectifGroupes([G|Gs], S) :-
    effectifGroupes(Gs, S1),
    groupe(G, S2),
    S is S1 + S2,
    !.

/**
 * planifier(+Ss, -Cs).
 *
 * @arg S   Listes des séances à planifier
 * @arg C   Listes des créneaux construits
 */
planifier([], Cs).

planifier(Ss, Cs) :-

    member(S, Ss),  % la séance
    seance(S, TypeS, _, _),

    plage(H, _, _), % une plage horaire
    date(J, M),     % une date

    salle(L, TailleL),  % une salle
    accueille(L, TypeL),

    findall(G, groupeSeance(G, S), Gs), % tous les groupes de la séance
    findall(P, profSeance(P, S), Ps),   % tous les enseignants de la séance

    % Tests des conditions

    typesCoursIdentiques(TypeS, TypeL), % type de salle valide

    % taille de salle valide
    effectifGroupes(Gs, S),
    S <= TailleL,

    profDisponible(P, H, J, M, Cs), % enseignant dispo à ce moment

    C is [S, H, J, M, L],
    append([C], Cs, Cs2), % On retient le nouveau créneau

    delete(Ss, S, Ss2), % On enlève la séance traitée

    planifier(Ss2, Cs2).


%planifier(Ss, Cs) :- findall(S, seance(S, _, _, _), Ss).


