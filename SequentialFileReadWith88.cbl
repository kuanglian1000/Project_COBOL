       IDENTIFICATION DIVISION.
       PROGRAM-ID. SEQUENTIALFILEREADWITH88.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT StudentFile ASSIGN TO "Student.dat"
             ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  StudentFile.
       01  StudentDetails.
           88  EndOfStudentFile value high-values.
           03  StudentId   pic x(7).
           03  StudentName.
               05  FirstName pic x(8).
               05  LastName pic xx.
           03  DateOfBirth.
               05  YoBirth pic 9(4).
               05  MoBirth pic 9(2).
               05  DoBirth pic 9(2).
           03  CourseCode pic x(4).
           03  Gender pic x.
       
       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT StudentFile

           READ StudentFile
               AT END SET EndOfStudentFile TO TRUE
           END-READ

           PERFORM UNTIL EndOfStudentFile
               DISPLAY StudentId space StudentName space DateOfBirth space Gender
               READ StudentFile
                   AT END SET EndOfStudentFile TO TRUE
               END-READ
           END-PERFORM
           CLOSE StudentFile.
           STOP RUN.
       