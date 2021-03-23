       IDENTIFICATION DIVISION.
       PROGRAM-ID. SEQUENTIALFILE-INSERTRECORDS.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT StudentRecords ASSIGN TO "STUDENTS-forInsert.dat"
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL.

           SELECT TransRecords ASSIGN TO "TRANS-forInsert.DAT"
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL.

           SELECT NewStudentRecords ASSIGN TO "STUDENTs-forInsert.new"
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  StudentRecords.
       01  StudentRecord.
           88  EndOfStudentFile value high-values.
           03  StudentId pic x(7).
           03  FILLER pic x(23).

       FD  TransRecords.
       01  TransRecord.
           88  EndOfTransFile value high-values.
           03  TransStudentId pic x(7).
           03  FILLER pic x(23).

       FD  NewStudentRecords.
       01  NewStudentRecord PIC x(30).
       
       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT StudentRecords.
           OPEN INPUT TransRecords.
           OPEN OUTPUT NewStudentRecords.

           READ StudentRecords
               AT END SET EndOfStudentFile TO TRUE
           END-READ

           READ TransRecords
               AT END SET EndOfTransFile TO TRUE
           END-READ

           PERFORM UNTIL (EndOfStudentFile) AND (EndOfTransFile)
               EVALUATE TRUE
                   WHEN (TransStudentId > StudentId)
                       WRITE NewStudentRecord FROM StudentRecord
                       READ StudentRecords
                           AT END SET EndOfStudentFile TO TRUE
                       END-READ
                   WHEN (TransStudentId < StudentId)
                       WRITE NewStudentRecord FROM TransRecord
                       READ TransRecords
                           AT END SET EndOfTransFile TO TRUE
                       END-READ
                   WHEN (TransStudentId = StudentId)
                       DISPLAY "ERROR - " TransStudentId " ALREADY EXISTS IN FILE"
                       READ TransRecords
                           AT END SET EndOfTransFile TO TRUE
                       END-READ
               END-EVALUATE
           END-PERFORM

           CLOSE StudentRecords.
           CLOSE TransRecords.
           CLOSE NewStudentRecords.
           
           STOP RUN.