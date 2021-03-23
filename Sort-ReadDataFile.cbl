       IDENTIFICATION DIVISION.
       PROGRAM-ID. SORT-READDATAFILE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT StudentFile ASSIGN TO "STUDENTS.DAT"
             ORGANIZATION IS LINE SEQUENTIAL.
           
           SELECT StudentFile-Male ASSIGN TO "STUDENTS-MALE.DAT"
             ORGANIZATION IS LINE SEQUENTIAL.

           SELECT WorkFile ASSIGN TO "WORK.TEMP".

       DATA DIVISION.
       FILE SECTION.
       FD  StudentFile.
       01  StudentRec  PIC X(30).
           88  EndOfStudentFile VALUE High-value.

       FD  StudentFile-Male.
       01  StudentRec-Male PIC X(30).

       SD  WorkFile.
       01  WorkRec.
           03  FILLER PIC X(7).
           03  wStudentName PIC X(10).
           03  FILLER PIC X(12).
           03  wGender PIC X.
               88  MaleStudent VALUE "M".

       PROCEDURE DIVISION.
       BEGIN.
           SORT WorkFile ON ASCENDING KEY wStudentName
               INPUT PROCEDURE IS GetMaleStudent
               GIVING StudentFile-Male.
           STOP RUN.

       GetMaleStudent.
           OPEN INPUT StudentFile
           
           READ StudentFile
               AT END SET EndOfStudentFile TO TRUE
           END-READ
           PERFORM UNTIL EndOfStudentFile
               MOVE StudentRec TO WorkRec
               IF MaleStudent
                   RELEASE WorkRec
               END-IF
               READ StudentFile
                   AT END SET EndOfStudentFile TO TRUE
               END-READ
           END-PERFORM

           CLOSE StudentFile.
