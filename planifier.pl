/* planifier.pl

*/

/**
 * typesCoursIdentiques(+X, +Y).
 *
 * @arg X Un type de cours
 * @arg Y Un type de cours
 */
typesCoursIdentiques(X, X).

/**
 * memeMomentCreneau(+H, +J, +M, +C).
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
 * memeSalle(+L, +C).
 *
 * Définit si L est une salle du créneau C
 *
 * @arg L   Une salle
 * @arg C   Un créneau [S, H, J, M, L]
 */
memeSalle(L, [_, _, _, _, L]) :- !.

/**
 * memeProfs(+P, +C).
 *
 * Définit si Ps sont des prof du créneau C.
 *
 * @arg Ps  Des enseignant
 * @arg C   Un créneau [S, H, J, M, L]
 */
memeProfs([P|_], [S, _, _, _, _]) :- profSeance(P2, S), P2 = P, !.
memeProfs([_|Ps], [S, H, J, M, L]) :- memeProfs(Ps, [S, H, J, M, L]), !.

/**
 * groupesIncompatibleCreneau(+Gs, +C).
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
 * momentBefore(+H1, +J1, +M1, +H2, +J2, +M2).
 *
 * Définit si la date 1 est bien après la date 2
 *
 * @arg H1  La plage horaire
 * @arg J1  Le jour
 * @arg M1  Le mois
 * @arg H2  La plage horaire
 * @arg J2  Le jour
 * @arg M2  Le mois
 */
momentBefore(_, J1, M1, _, J2, M2) :-
    dateBefore(J2, M2, J1, M1), % 2 se déroule un jour placé avant
    !.
momentBefore(H1, J1, M1, H2, J2, M2) :-
    J1 = J2,
    M1 = M2,
    H2 < H1, % S2 se déroule même jour, mais plage plus petite
    !.

/**
 * customSequenceValide(+J1, +M1, +J2, +M2, +Jmin, +Jmax).
 *
 * Définit si le créneau potentiel est conforme avec le séquencement voulu
 *
 * @arg J1   Le jour
 * @arg M1   Le mois
 * @arg J2   Le jour
 * @arg M2   Le mois
 * @arg Jmin Le nombre de jours minimum entre 1 et 2
 * @arg JMax Le nombre de jours maximum entre 1 et 2
 */
customSequenceValide(J1, M1, J2, M2, Jmin, Jmax) :-
    joursParMois(Nb),
    Offset is ((J1 + M1 * Nb) - (J2 + M2 * Nb)),
    Offset >= Jmin,
    Offset =< Jmax,
    !. % 1 se déroule bien entre JMin et Jmax jours après 2

/**
 * sequencementValideCreneau(+S, +H, +J, +M, +C).
 *
 * Définit si le créneau potentiel est conforme avec le séquencement voulu
 *
 * @arg S   Une séance
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg C   Un créneau [S, H, J, M, L]
 */
 % la séance n'est pas en lien avec le créneau transmis
sequencementValideCreneau(S, _, _, _, [S2, _, _, _, _]):-
    \+ suitSeance(S, S2),
    \+ suitSeance(S, S2, _, _),
    \+ suitSeance(S2, S),
    \+ suitSeance(S2, S, _, _),
    !.
sequencementValideCreneau(S, H, J, M, [S2, H2, J2, M2, _]) :-
    suitSeance(S, S2), % S suit S2
    momentBefore(H, J, M, H2, J2, M2),
    !.
sequencementValideCreneau(S, H, J, M, [S2, H2, J2, M2, _]) :-
    suitSeance(S2, S), % S2 suit S
    momentBefore(H2, J2, M2, H, J, M),
    !.
sequencementValideCreneau(S, _, J, M, [S2, _, J2, M2, _]) :-
    suitSeance(S, S2, Jmin, Jmax), % S suit S2
    customSequenceValide(J, M, J2, M2, Jmin, Jmax),
    !.
sequencementValideCreneau(S, _, J, M, [S2, _, J2, M2, _]) :-
    suitSeance(S2, S, Jmin, Jmax), % S2 suit S
    customSequenceValide(J2, M2, J, M, Jmin, Jmax),
    !.

/**
 * creneauValideCreneau(+S, +Ps, +Gs, +H, +J, +M, +L, +C).
 *
 * Définit si un cours n'est pas incompatible au moment donné avec les autres
 * cours de la liste de créneaux.
 *
 * @arg Ps  Les enseignants
 * @arg Gs  Les groupes
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg L   La salle
 * @arg C   Un créneau [S, H, J, M, L]
 */
creneauValideCreneau(S, Ps, Gs, H, J, M, L, C) :-
    % le créneau valide le séquencement avec C
    sequencementValideCreneau(S, H, J, M, C),
    (
        % le créneau n'est pas au même moment que C
        (\+ memeMomentCreneau(H, J, M, C));
        % ou il ne concerne pas un même prof, des groupes incompatibles
        % ou une même salle
        (
            \+ groupesIncompatibleCreneau(Gs, C),
            \+ memeProfs(Ps, C),
            \+ memeSalle(L, C)
        )
    ),
    !.

/**
 * creneauValide(+S, +Ps, +Gs, +H, +J, +M, +L, +Cs).
 *
 * Définit si un creneau est valide (Pas de conflit avec les créneaux existants)
 *
 * @arg S   La séance
 * @arg Ps  Les enseignants
 * @arg Gs  Les groupes
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg L   La salle
 * @arg Cs  Liste de créneaux [S, H, J, M, L]
 */
creneauValide(_, _, _, _, _, _, _, []) :- !.
creneauValide(S, Ps, Gs, H, J, M, L, [C|Cs]) :-
    creneauValideCreneau(S, Ps, Gs, H, J, M, L, C),
    creneauValide(S, Ps, Gs, H, J, M, L, Cs),
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
 * planifier(+Ss, +Ds, -Cs).
 *
 * @arg Ss  Listes des séances à planifier
 * @arg Ds  Listes des créneaux déjà planifié
 * @arg Cs  Listes des créneaux construits
 */
planifier([], _, []) :- !.
planifier(Ss, Ds, [C|Cs]) :-

    member(S, Ss),      % La séance courante
    delete(Ss, S, Ss2), % On l'enlève de la liste

    planifier(Ss2, Ds, Cs), % on traite le sous-problème

    append(Ds, Cs, Cs2), % on crée une liste qui regroupe les créneaux existants

    % Création du créneau et tests ---------------------------------------------

    seance(S, TypeS, _, _),

    date(J, M),     % une date
    plage(H, _, _), % une plage horaire

    % une salle
    salle(L, TailleL),
    accueille(L, TypeL),
    typesCoursIdentiques(TypeS, TypeL), % type de salle valide

    findall(G, groupeSeance(G, S), Gs), % tous les groupes de la séance
    effectifGroupes(Gs, Effectif),
    Effectif =< TailleL, % taille de salle valide

    findall(P, profSeance(P, S), Ps),   % tous les enseignants de la séance

    % test des contraintes (profs, incompatibilité groupes, séquencement)
    % sur cette proposition de créneau
    creneauValide(S, Ps, Gs, H, J, M, L, Cs2),

    % Fin création du créneau et tests -----------------------------------------

    C = [S, H, J, M, L].

planifier(Ss, Cs) :- planifier(Ss, [], Cs).
