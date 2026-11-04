% Practical 5: Student Performance Classification
% Marks are assumed to be between 0 and 100.
% Classification rules: topper >= 75, average >= 40 and < 75, fail < 40.

student_marks(riya, 92).
student_marks(aman, 68).
student_marks(neha, 35).
student_marks(karan, 78).
student_marks(sana, 49).

topper(Name) :-
    student_marks(Name, Marks),
    Marks >= 75.

average_student(Name) :-
    student_marks(Name, Marks),
    Marks >= 40,
    Marks < 75.

failed_student(Name) :-
    student_marks(Name, Marks),
    Marks < 40.

performance(Name, topper) :- topper(Name).
performance(Name, average) :- average_student(Name).
performance(Name, fail) :- failed_student(Name).

% Example queries:
% ?- topper(Who).
% ?- average_student(Who).
% ?- failed_student(Who).
% ?- performance(riya, Category).
