/* instance.pl

@changelog
f8e54ce Thomas Coquereau        Mon Jan 2 15:35:42 2017 +0100   ADD jours min et max pour le suiv
837a2ac Guillaume Clochard      Mon Jan 2 11:37:16 2017 +0100   Ajout nom des séances
569cfb8 Guillaume Clochard      Mon Jan 2 10:09:13 2017 +0100   Ajout tests unitaires incompatibles/2
47400e0 Guillaume Clochard      Mon Jan 2 08:42:36 2017 +0100   Ajout incompatibles(Groupe1, Groupe2)
9443ae1 Guillaume Clochard      Mon Jan 2 08:03:18 2017 +0100   Convertion # --> %
00c0db5 Guillaume Clochard      Mon Jan 2 07:44:25 2017 +0100   Ajout groupeSeance et profSeance
a57af32 Guillaume Clochard      Mon Jan 2 06:38:22 2017 +0100   Ajout description prédicats
88a4bd3 Guillaume Clochard      Sun Jan 1 21:28:08 2017 +0100   Fix casse des constantes
7c83339 Thomas Coquereau        Thu Dec 29 10:39:47 2016 +0100  ADD suit
935d80e Thomas Coquereau        Thu Dec 29 10:31:46 2016 +0100  ADD seances
a4a8108 Guillaume Clochard      Thu Dec 15 12:55:21 2016 +0100  Début instanciation
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Groupes                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/**
 * groupe(Groupe, Effectif)
 *
 * @arg Groupe      Nom du groupe
 * @arg Effectif    Nombre d'étudiants dans le groupe
 **/
groupe(info,      62).
groupe(id,        24).
groupe(silr,      38).
groupe(silr1,     18).
groupe(silr2,     20).
groupe(silr_para, 14).
groupe(silr_code, 24).

/**
 * incompatibles(Groupe1, Groupe2)
 *
 * Définit l'incompatibilité entre 2 groupes (si il y a des étudiants en commun)
 *
 * @arg Groupe1     Nom du groupe 1
 * @arg Groupe2     Nom du groupe 2
 */
incomp(id, info).
incomp(silr, info).
incomp(silr1, silr).
incomp(silr1, info).
incomp(silr2, silr).
incomp(silr2, info).
incomp(silr_para, silr1).
incomp(silr_para, silr2).
incomp(silr_para, silr).
incomp(silr_para, info).
incomp(silr_code, silr1).
incomp(silr_code, silr2).
incomp(silr_code, silr).
incomp(silr_code, info).

% reflexive
incompatibles(X, X) :- !.

% symétrique
incompatibles(X, Y) :- incomp(X, Y), !.
incompatibles(X, Y) :- incomp(Y, X), !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Matières                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/**
 * matiere(Matiere)
 *
 * @arg Matiere     Nom de la matière
 **/
matiere(ia).
matiere(projet_ia).
matiere(analyse_donnees).
matiere(reseau).
matiere(parallelisme).
matiere(code).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                   Profs                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/**
 * prof(Prof)
 *
 * @arg Prof     Nom de l'enseignant
 **/
prof(martinez).
prof(lecapitaine).
prof(raschia).
prof(kuntz).
prof(lehn).
prof(parrein).
prof(picarougne).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                   Plages                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Selon les conseils de M. Le Capitaine, nous avons modifié les plages horaires

/**
 * plage(Id, Start:string, End:string)
 *
 * @arg Id      Id de la plage horaire
 * @arg Start   Heure de début de la plage
 * @arg End     Heure de fin de la plage
 */
plage(1, "08h00", "09h30").
plage(2, "09h45", "11h15").
plage(3, "11h30", "13h00").
plage(4, "14h00", "15h30").
plage(5, "15h45", "17h15").
plage(6, "17h30", "19h00").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                    Jour                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/**
 * date(IdJour, IdMois)
 *
 * @arg IdJour  Id du jour
 * @arg IdMois  Id du mois
 */
date(1,1).
date(2,1).
date(3,1).
date(4,1).
date(5,1).

/**
 * dateBefore(J1, M1, J2, M2)
 *
 * Test si date 1 < date 2
 *
 * @arg J1  Jour date 1
 * @arg M1  Mois date 1
 * @arg J2  Jour date 2
 * @arg M2  Mois date 2
 */
dateBefore( _, M1,  _, M2) :- M1 < M2, !.
dateBefore(J1, M1, J2, M2) :- M1 = M2, J1 < J2, !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Type de cours                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/**
 * typeCours(Type)
 *
 * @arg Type  Un type de cours
 */
typeCours(cm).
typeCours(td).
typeCours(tp).
typeCours(ds).
typeCours(mp).
typeCours(tp_para).
typeCours(tp_rez).
typeCours(ds_machine).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                   Salle                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/**
 * salle(Nom, Effectif)
 *
 * @arg Nom         Nom de la salle
 * @arg Effectif    Nombre de place disponibles
 **/
salle(a1, 300).
salle(a2, 200).
salle(b001, 26).
salle(c008, 50).
salle(c009, 26).
salle(c007, 10).
salle(e101, 24).
salle(e102, 24).
salle(e103, 24).
salle(e104, 24).
salle(e202, 50).

/**
 * accueille(Salle, TypeCours)
 *
 * @arg Salle       Nom d'une salle
 * @arg TypeCours   Type de cours que la salle accueille
 */
accueille(a1, cm).
accueille(a1, ds).
accueille(a2, cm).
accueille(a2, ds).
accueille(b001, tp).
accueille(b001, mp).
accueille(b001, ds_machine).
accueille(c008, cm).
accueille(c008, td).
accueille(c008, ds).
accueille(c009, tp).
accueille(c009, tp_para).
accueille(c009, mp).
accueille(c009, ds_machine).
accueille(c007, tp_rez).
accueille(e101, cm).
accueille(e101, td).
accueille(e102, cm).
accueille(e102, td).
accueille(e103, td).
accueille(e104, td).
accueille(e202, cm).
accueille(e202, td).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  Séances                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/**
 * seances(Id, TypeCours, Matiere, Nom)
 *
 * @arg Id          Id de la séance
 * @arg TypeCours   Type de cours de la séance
 * @arg Matiere     Matiere à laquelle la séance appartient
 * @arg Nom         Nom de la séance
 */
% Séances ia
seance(1, cm, ia, 'CM').
seance(2, td, ia, 'TD 1 - SILR2').
seance(3, tp, ia, 'TP 1 - SILR2').
seance(4, td, ia, 'TD 1 - ID').
seance(5, tp, ia, 'TP 1 - ID').
seance(6, td, ia, 'TD 1 - SILR').
seance(7, tp, ia, 'TP 1 - SILR1').

% Séances Projet ia
seance(8, tp, projet_ia, 'TP - SILR2').
seance(9, tp, projet_ia, 'TP - ID').
seance(10, tp, projet_ia, 'TP - SILR').

% Séances Analyse de données
seance(11, cm, analyse_donnees, 'CM').
seance(12, td, analyse_donnees, 'TD').

% Séances Réseau
seance(13, cm, reseau, 'CM').
seance(14, tp, reseau, 'TP - SILR1').
seance(15, tp, reseau, 'TP - SILR2').

% Séances Parallélisme
seance(16, cm, parallelisme, 'CM').
seance(17, td, parallelisme, 'TD').

% Séances Code
seance(18, cm, code, 'CM').
seance(19, tp, code, 'TP').

/**
 * groupeSeance(Groupe, Seance)
 *
 * Définit la participation d'un groupe à une séance
 *
 * @arg Groupe      Nom du groupe
 * @arg Seance      Id de la séance
 */
% Séances ia
groupeSeance(info, 1).
groupeSeance(silr2, 2).
groupeSeance(silr2, 3).
groupeSeance(id, 4).
groupeSeance(id, 5).
groupeSeance(silr1, 6).
groupeSeance(silr1, 7).

% Séances Projet ia
groupeSeance(silr2, 8).
groupeSeance(id, 9).
groupeSeance(silr1, 10).

% Séances Analyse de données
groupeSeance(id, 11).
groupeSeance(id, 12).

% Séances Réseau
groupeSeance(silr, 13).
groupeSeance(silr1, 14).
groupeSeance(silr2, 15).

% Séances Parallélisme
groupeSeance(silr_para, 16).
groupeSeance(silr_para, 17).

% Séances Code
groupeSeance(silr_code, 18).
groupeSeance(silr_code, 19).

/**
 * profSeance(Prof, Seance)
 *
 * Définit la participation d'un enseignant à une séance
 *
 * @arg Prof        Nom de l'enseignant
 * @arg Seance      Id de la séance
 */
% Séances ia
profSeance(martinez, 1).
profSeance(martinez, 2).
profSeance(martinez, 3).
profSeance(lecapitaine, 4).
profSeance(lecapitaine, 5).
profSeance(rashia, 6).
profSeance(rashia, 7).

% Séances Projet ia
profSeance(martinez, 8).
profSeance(lecapitaine, 9).
profSeance(raschia, 10).

% Séances Analyse de données
profSeance(kuntz, 11).
profSeance(lecapitaine, 12).

% Séances Réseau
profSeance(lehn, 13).
profSeance(lehn, 14).
profSeance(parrein, 15).

% Séances Parallélisme
profSeance(martinez, 16).
profSeance(martinez, 17).

% Séances Code
profSeance(picarougne, 18).
profSeance(picarougne, 19).

/**
 * suitSeance(Seance_suivante, Seance_suivie)
 *
 * On remarque que le prédicat nous permet également d'implémenter la relation
 * de suite entre les matière (dernière séance matière 1 - première séance
 * matière 2)
 *
 * @arg Seance_suivante     Id de la séance qui suit
 * @arg Seance_suivie       Id de la séance suivit
 */

suitSeance(8, 2).
suitSeance(8, 3).
suitSeance(9, 4).
suitSeance(9, 5).
suitSeance(10, 6).
suitSeance(10, 7).
suitSeance(12, 11).
suitSeance(14, 13).
suitSeance(15, 13).
suitSeance(17, 16).
suitSeance(19, 18).

/**
 * suitSeance(Seance_suivante, Seance_suivie, tempsMin, tempsMax)
 *
 * @arg Seance_suivante     Id de la séance qui suit
 * @arg Seance_suivie       Id de la séance suivit
 * @arg tempsMin     		Nombre de jours min avant la prochaine séance
 * @arg tempsMax       		Nombre de jours max avant la prochaine séance
 */

suitSeance(2, 1, 1, 1).
suitSeance(3, 1, 1, 2).
suitSeance(4, 1, 2, 5).
suitSeance(5, 1, 1, 3).
suitSeance(6, 1, 2, 2).
suitSeance(7, 1, 1, 5).
