       IDENTIFICATION DIVISION.
       PROGRAM-ID. Sort-UserInput.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT StudentFile assign to "STUDENTs-Sorted.dat"
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL.
           
           SELECT WorkFile assign to "STUDENTs-WorkFile.tmp".

       DATA DIVISION.
       FILE SECTION.
       FD  StudentFile.
       01  StudentDetails  PIC X(30).

       SD  WorkFile.
       01  WorkRec.
           03  wStudentId  PIC X(7).
           03  FILLER  PIC X(23).

       PROCEDURE DIVISION.
       BEGIN.
           SORT WorkFile ON ASCENDING KEY wStudentId
               INPUT PROCEDURE IS GetStudentDetails
               GIVING StudentFile.
           STOP RUN.
       
       GetStudentDetails.
           DISPLAY "enter student details using template below."
           DISPLAY "enter no data to end."
           DISPLAY "Enter: Id, Name, Birthday, CourseCode, Sex"
           DISPLAY "Format:1234567YourName  YYYYMMDDcodeS"
           ACCEPT WorkRec.
           PERFORM UNTIL WorkRec = space
               RELEASE WorkRec
               ACCEPT WorkRec
           END-PERFORM.
           
           