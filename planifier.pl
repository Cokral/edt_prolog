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
 * memeProfs(P, C).
 *
 * Définit si Ps sont des prof du créneau C.
 *
 * @arg Ps  Des enseignant
 * @arg C   Un créneau [S, H, J, M, L]
 */
memeProfs([P|_], [S, _, _, _, _]) :- profSeance(P2, S), P2 = P, !.
memeProfs([_|Ps], [S, H, J, M, L]) :- memeProfs(Ps, [S, H, J, M, L]), !.

/**
 * groupesIncompatibleCreneau(Gs, C).
 *
 * Définit si Gs sont incompatibles avec le groupe de C.
 *
 * @arg Gs  Les groupes
 * @arg C   Un créneau [S, H, J, M, L]
 */
groupesIncompatibleCreneau([G|_], [S, _, _, _, _]) :-
    groupeSeance(G2, S),
    incompatibles(G, G2),
    !.
groupesIncompatibleCreneau([_|Gs], [S, H, J, M, L]) :-
    groupesIncompatibleCreneau(Gs, [S, H, J, M, L]),
    !.

/**
 * sequencementValideCreneau(S, H, J, M, C).
 *
 * Définit si le créneau potentiel est conforme avec le séquencement voulu
 *
 * @arg S   Une séance
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg C   Un créneau [S, H, J, M, L]
 */
% la séance n'en pas en lien avec le créneau transmis
sequencementValideCreneau(S, _, _, _, [S2, _, _, _, _]):-
    \+ suitSeance(S, S2),
    \+ suitSeance(S, S2, _, _),
    !.
sequencementValideCreneau(S, H, J, M, [S2, H2, J2, M2, _]):-
    suitSeance(S, S2),
    (dateBefore(J2, M2, J, M); H2 < H),
    !.
sequencementValideCreneau(S, H, J, M, [S2, H2, J2, M2, _]):-
    suitSeance(S2, S),
    (dateBefore(J, M, J2, M2); H < H2),
    !.
sequencementValideCreneau(S, _, J, M, [S2, _, J2, M2, _]):-
    suitSeance(S, S2, Jmin, Jmax),
    joursParMois(Nb),
    Offset is ((J + M * Nb) - (J2 + M2 * Nb)),
    Offset >= Jmin,
    Offset =< Jmax,
    !.
sequencementValideCreneau(S, _, J, M, [S2, _, J2, M2, _]):-
    suitSeance(S2, S, Jmin, Jmax),
    joursParMois(Nb),
    Offset is ((J2 + M2 * Nb) - (J + M * Nb)),
    Offset >= Jmin,
    Offset =< Jmax,
    !.

% TODO faire dans l'autre sens

/**
 * creneauValideCreneau(P, Gs, H, J, M, C).
 *
 * Définit si un cours n'est pas incompatible au moment donné avec les autres
 * cours de la liste de créneaux.
 *
 * @arg Ps  Les enseignants
 * @arg Gs  Les groupes
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg Cs  Un créneau [S, H, J, M, L]
 */
creneauValideCreneau(S, Ps, Gs, H, J, M, C) :-
    % le créneau valide le séquencement avec C
    sequencementValideCreneau(S, H, J, M, C),
    (
        % le créneau n'est pas au même moment que C
        (\+ memeMomentCreneau(H, J, M, C));
        % ou il ne concerne pas le même prof et un group incompatible que C
        (\+ groupesIncompatibleCreneau(Gs, C), \+ memeProfs(Ps, C))
    ),
    !.

/**
 * creneauValide(S, Ps, G, H, J, M, [Cs]).
 *
 * Définit si un creneau est valide (Pas de conflit de groupe ou d'enseignant).
 *
 * @arg S   La séance
 * @arg Ps  Les enseignants
 * @arg Gs  Les groupes
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg Cs  Liste de créneaux [S, H, J, M, L]
 */
creneauValide(_, _, _, _, _, _, []) :- !.
creneauValide(S, Ps, Gs, H, J, M, [C|Cs]) :-
    creneauValideCreneau(S, Ps, Gs, H, J, M, C),
    creneauValide(S, Ps, Gs, H, J, M, Cs),
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
planifier([], _).

planifier(Ss, Cs) :-

    member(S, Ss),  % la séance
    seance(S, TypeS, _, _),

    plage(H, _, _), % une plage horaire
    date(J, M),     % une date

    salle(L, TailleL),  % une salle
    accueille(L, TypeL),

    findall(G, groupeSeance(G, S), Gs), % tous les groupes de la séance
    findall(P, profSeance(P, S), Ps),   % tous les enseignants de la séance

    % Tests des conditions ----------------------------------------------------

    typesCoursIdentiques(TypeS, TypeL), % type de salle valide

    % taille de salle valide
    effectifGroupes(Gs, Effectif),
    Effectif =< TailleL,

    % test des contraintes sur cette proposition de créneau
    creneauValide(S, Ps, Gs, H, J, M, Cs),

    % Fin tests des conditions ------------------------------------------------

    C = [S, H, J, M, L],
    append([C], Cs, Cs2), % On retient le nouveau créneau

    delete(Ss, S, Ss2), % On enlève la séance traitée

    planifier(Ss2, Cs2).

planification(Cs) :-
   findall(S, seance(S, _, _, _), Ss),
   planifier(Ss, Cs).


