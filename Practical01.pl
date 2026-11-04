% Practical 1: Student-Course Knowledge Base
% Run using SWI-Prolog.

% Facts
student(riya).
student(aman).
student(neha).

course(prolog).
course(python).
course(machine_learning).

enrolled(riya, prolog).
enrolled(riya, python).
enrolled(aman, machine_learning).
enrolled(neha, prolog).

% Rules
studies(Student, Course) :-
    enrolled(Student, Course).

classmate(Student1, Student2, Course) :-
    enrolled(Student1, Course),
    enrolled(Student2, Course),
    Student1 \= Student2.

% Example queries:
% ?- student(riya).
% ?- enrolled(riya, Course).
% ?- studies(aman, machine_learning).
% ?- classmate(riya, neha, prolog).
