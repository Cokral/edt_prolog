/* main.pl
 *
    swipl -s main.pl
 *
 * @changelog
 * 39d2aa2 Guillaume Clochard      Wed Jan 11 08:30:02 2017 +0100  Création main.pl
 */

:- include('./instance.pl').
:- include('./utils.pl').
:- include('./planifier.pl').

/**
 * planification(-Cs).
 *
 * @arg Cs   Liste de créneaux
 */
planification(Cs) :-
    findall(S, seance(S, _, _, _), Ss),

    % on trie les séances, les plus contraintes à la fin
    predsort(beforeSeance, Ss, Ss2),

    % on inverse car planifier/2 commence par la fin et on veut placer d'abord
    % les séances les moins contraintes (ie. les débuts de matière)
    reverse(Ss2, Ss3),

    % et voilà une planification possible
    planifier(Ss3, Cs).

:- initialization main.

main :- planification(Cs), afficherPlanification(Cs), halt.
main :- halt(1).
