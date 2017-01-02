:- include('../instance.pl').

:- begin_tests(incompatibles).

test("l'incompatiblité est reflexive") :- incompatibles(info, info).
test("l'incompatiblité est symétrique") :-
    incompatibles(silr_para, info),
    incompatibles(info, silr_para).

:- end_tests(incompatibles).

