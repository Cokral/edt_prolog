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
