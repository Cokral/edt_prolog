
################################################################################
#                               Groupes                                        #
################################################################################

groupe(INFO,      62).
groupe(ID,        24).
groupe(SILR,      38).
groupe(SILR1,     18).
groupe(SILR2,     20).
groupe(SILR_PARA, 14).
groupe(SILR_CODE, 24).

groupe_appartient(ID, INFO).
groupe_appartient(SILR, INFO).
groupe_appartient(SILR1, SILR).
groupe_appartient(SILR2, SILR).
groupe_appartient(SILR_PARA, SILR).
groupe_appartient(SILR_CODE, SILR).

################################################################################
#                               Matières                                       #
################################################################################

matiere(IA).
matiere(PROJET_IA).
matiere(ANALYSE_DONNEES).
matiere(RESEAU).
matiere(PARALLELISME).
matiere(CODE).

################################################################################
#                                   Profs                                      #
################################################################################

prof(MARTINEZ).
prof(LECAPITAINE).
prof(RASCHIA).
prof(KUNTZ).
prof(LEHN).
prof(PARREIN).
prof(PICAROUGNE).

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

typeCours(CM).
typeCours(TD).
typeCours(TP).
typeCours(DS).
typeCours(MP).
typeCours(TP_PARA).
typeCours(TP_REZ).
typeCours(DS_MACHINE).

################################################################################
#                                   Salle                                      #
################################################################################

salle(A1, 300).
salle(A2, 200).
salle(B001, 26).
salle(C008, 50).
salle(C009, 26).
salle(C007, 10).
salle(E101, 24).
salle(E102, 24).
salle(E103, 24).
salle(E104, 24).
salle(E202, 50).

accueille(A1, CM).
accueille(A1, DS).
accueille(A2, CM).
accueille(A2, DS).
accueille(B001, TP).
accueille(B001, MP).
accueille(B001, DS_MACHINE).
accueille(C008, CM).
accueille(C008, TD).
accueille(C008, DS).
accueille(C009, TP).
accueille(C009, TP_PARA).
accueille(C009, MP).
accueille(C009, DS_MACHINE).
accueille(C007, TP_REZ).
accueille(E101, CM).
accueille(E101, TD).
accueille(E102, CM).
accueille(E102, TD).
accueille(E103, TD).
accueille(E104, TD).
accueille(E202, CM).
accueille(E202, TD).

################################################################################
#                                  Séances                                     #
################################################################################

# Séances IA #
seance(1, CM, MARTINEZ, IA, INFO).
seance(2, TD, MARTINEZ, IA, SILR2).
seance(3, TP, MARTINEZ, IA, SILR2).
seance(4, TD, LECAPITAINE, IA, ID).
seance(5, TP, LECAPITAINE, IA, ID).
seance(6, TD, RASCHIA, IA, SILR1).
seance(7, TP, RASCHIA, IA, SILR1).

# Séances Projet IA # 
seance(8, TP, MARTINEZ, PROJET_IA, SILR2).
seance(9, TP, LECAPITAINE, PROJET_IA, ID).
seance(10, TP, RASCHIA, PROJET_IA, SILR1).

# Séances Analyse de données # 
seance(11, CM, KUNTZ, ANALYSE_DONNEES, ID).
seance(12, TD, LECAPITAINE, ANALYSE_DONNEES, ID).

# Séances Réseau #
seance(13, CM, LEHN, RESEAU, SILR).
seance(14, TP, LEHN, RESEAU, SILR1).
seance(15, TP, PARREIN, RESEAU, SILR2).

# Séances Parallélisme #
seance(16, CM, MARTINEZ, PARALLELISME, SILR_PARA).
seance(17, TD, MARTINEZ, PARALLELISME, SILR_PARA).

# Séances Code #
seance(18, CM, PICAROUGNE, CODE, SILR_CODE).
seance(19, TP, PICAROUGNE, CODE, SILR_CODE).


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