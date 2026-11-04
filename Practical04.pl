% Practical 4: College Timetable Knowledge Base
% Run using SWI-Prolog.

% timetable(Day, Time, Subject, Faculty, Classroom).
timetable(monday, '09:00', artificial_intelligence, 'Dr Sharma', room_101).
timetable(monday, '10:00', mathematics, 'Prof Verma', room_102).
timetable(tuesday, '09:00', prolog, 'Dr Mehta', lab_1).
timetable(tuesday, '11:00', python, 'Prof Rao', lab_2).
timetable(wednesday, '10:00', machine_learning, 'Dr Sharma', room_103).
timetable(thursday, '12:00', prolog, 'Dr Mehta', lab_1).
timetable(friday, '09:00', mathematics, 'Prof Verma', room_102).

% Find the faculty teaching a subject.
faculty_for_subject(Subject, Faculty) :-
    timetable(_, _, Subject, Faculty, _).

% Find the classroom for a subject on a day.
classroom_for_subject(Day, Subject, Room) :-
    timetable(Day, _, Subject, _, Room).

% Find all subjects taught by a faculty member.
subject_by_faculty(Faculty, Subject) :-
    timetable(_, _, Subject, Faculty, _).

% Find the schedule for a particular day.
daily_schedule(Day, Time, Subject, Faculty, Room) :-
    timetable(Day, Time, Subject, Faculty, Room).

% Example queries:
% ?- faculty_for_subject(prolog, Who).
% ?- classroom_for_subject(tuesday, prolog, Room).
% ?- subject_by_faculty('Dr Sharma', Subject).
% ?- daily_schedule(monday, Time, Subject, Faculty, Room).
