
################################################################################
#                               Groupes                                        #
################################################################################

groupe(info,      62).
groupe(id,        24).
groupe(silr,      38).
groupe(silr1,     18).
groupe(silr2,     20).
groupe(silr_para, 14).
groupe(silr_code, 24).

groupe_appartient(id, info).
groupe_appartient(silr, info).
groupe_appartient(silr1, silr).
groupe_appartient(silr2, silr).
groupe_appartient(silr_para, silr).
groupe_appartient(silr_code, silr).

################################################################################
#                               Matières                                       #
################################################################################

matiere(ia).
matiere(projet_ia).
matiere(analyse_donnees).
matiere(reseau).
matiere(parallelisme).
matiere(code).

################################################################################
#                                   Profs                                      #
################################################################################

prof(martinez).
prof(lecapitaine).
prof(raschia).
prof(kuntz).
prof(lehn).
prof(parrein).
prof(picarougne).

################################################################################
#                                   Plages                                     #
################################################################################

# Selon les conseils de M. Le Capitaine, nous avons modifié les plages horaires

plage(1, 08.00, 09.50).
plage(2, 09.75, 11.25).
plage(3, 11.50, 13.00).
plage(4, 14.00, 15.50).
plage(5, 15.75, 17.25).
plage(6, 17.50, 19.00).

################################################################################
#                                    Jour                                      #
################################################################################

jour(1).
jour(2).
jour(3).
jour(4).
jour(5).

################################################################################
#                               Type de cours                                  #
################################################################################

typeCours(cm).
typeCours(td).
typeCours(tp).
typeCours(ds).
typeCours(mp).
typeCours(tp_para).
typeCours(tp_rez).
typeCours(ds_machine).

################################################################################
#                                   Salle                                      #
################################################################################

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

################################################################################
#                                  Séances                                     #
################################################################################

# Séances ia #
seance(1, cm, martinez, ia, info).
seance(2, td, martinez, ia, silr2).
seance(3, tp, martinez, ia, silr2).
seance(4, td, lecapitaine, ia, id).
seance(5, tp, lecapitaine, ia, id).
seance(6, td, raschia, ia, silr1).
seance(7, tp, raschia, ia, silr1).

# Séances Projet ia #
seance(8, tp, martinez, projet_ia, silr2).
seance(9, tp, lecapitaine, projet_ia, id).
seance(10, tp, raschia, projet_ia, silr1).

# Séances Analyse de données #
seance(11, cm, kuntz, analyse_donnees, id).
seance(12, td, lecapitaine, analyse_donnees, id).

# Séances Réseau #
seance(13, cm, lehn, reseau, silr).
seance(14, tp, lehn, reseau, silr1).
seance(15, tp, parrein, reseau, silr2).

# Séances Parallélisme #
seance(16, cm, martinez, parallelisme, silr_para).
seance(17, td, martinez, parallelisme, silr_para).

# Séances Code #
seance(18, cm, picarougne, code, silr_code).
seance(19, tp, picarougne, code, silr_code).


# suit( ID_suivante, ID_suivie )
suit(2, 1).
suit(3, 1).
suit(4, 1).
suit(5, 1).
suit(6, 1).
suit(7, 1).
suit(8, 2).
suit(8, 3).
suit(9, 4).
suit(9, 5).
suit(10, 6).
suit(10, 7).
suit(12, 11).
suit(14, 13).
suit(15, 13).
suit(17, 16).
suit(19, 18).
