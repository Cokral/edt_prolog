
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
plage(2, 11.50, 13.00).
plage(2, 14.00, 15.50).
plage(2, 15.75, 17.25).
plage(2, 17.50, 19.00).

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


