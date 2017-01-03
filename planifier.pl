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
 * profDisponibleCreneau(P, H, J, M, C).
 *
 * Définit si un enseignant est disponible au moment indiqué malgré le
 * créneau donné
 *
 * @arg P   L'enseignant
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg C   Un créneau [S, H, J, M, L]
 */
profDisponibleCreneau(_, H, _, _, [_, H2, _, _, _]) :- H \= H2, !.
profDisponibleCreneau(_, _, J, _, [_, _, J2, _, _]) :- J \= J2, !.
profDisponibleCreneau(_, _, _, M, [_, _, _, M2, _]) :- M \= M2, !.
profDisponibleCreneau(P, _, _, _, [S, _, _, _, _]) :-
    profSeance(P2, S),
    P2 \= P,
    !.

/**
 * profDisponible(P, H, J, M, Cs).
 *
 * Définit si un enseignant est disponible au moment indiqué malgré la liste
 * de créneaux donnée
 *
 * @arg P   L'enseignant
 * @arg H   La plage horaire
 * @arg J   Le jour
 * @arg M   Le mois
 * @arg Cs  Liste de créneaux [S, H, J, M, L]
 */
profDisponible(_, _, _, _, []) :- !.
profDisponible(P, H, J, M, [C|Cs]) :-
    profDisponibleCreneau(P, H, J, M, C),
    profDisponible(P, H, H, M, Cs),
    !.

/**
 * planifier(+Ss, -Cs).
 *
 * @arg S   Listes des séances à planifier
 * @arg C   Listes des créneaux construits
 */
% planifier([], Cs).

% planifier(Ss, Cs) :-

    % member(S, Ss),  % la séance
    % seance(S, TypeS, _, _),

    % plage(H, _, _), % une plage horaire
    % date(J, M),     % une date

    % salle(L, TailleL),  % une salle
    % accueille(L, TypeL),

    % findall(G, groupeSeance(G, S), Gs), % tous les groupes de la séance
    % findall(P, profSeance(P, S), Ps),   % tous les enseignants de la séance

    % % Tests des conditions

    % typesCoursIdentiques(TypeS, TypeL), % salle valide

    % profDisponible(P, H, J, M, Cs), % enseignant dispo à ce moment

    % C is [S, H, J, M, L],
    % append([C], Cs, Cs2), % On retient le nouveau créneau

    % delete(Ss, S, Ss2), % On enlève la séance traitée

    % planifier(Ss2, Cs2).


%planifier(Ss, Cs) :- findall(S, seance(S, _, _, _), Ss).


