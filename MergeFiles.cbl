       IDENTIFICATION DIVISION.
       PROGRAM-ID. MERGEFILES.
      *> MERGE 無法排除重複項目, 只單純把資料合併
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT StudentFile ASSIGN TO "Student.DAT"
             ORGANIZATION IS LINE SEQUENTIAL.

           SELECT TranFile ASSIGN TO "TRANS-forInsert.DAT"
             ORGANIZATION IS LINE SEQUENTIAL.

           SELECT NewStudentFile ASSIGN TO "STUDENTs-Merged.dat"
             ORGANIZATION IS LINE SEQUENTIAL.

           SELECT WorkFile ASSIGN TO "WORK.TMP".

       DATA DIVISION.
       FILE SECTION.
       FD  StudentFile.
       01  StudentRec PIC X(30).

       FD  TranFile.
       01  TranRec PIC X(30).

       FD  NewStudentFile.
       01  NewStudentRec PIC X(30).

       SD  WorkFile.
       01  WorkRec.
           03  wStudentId  PIC X(7).
           03  FILLER      PIC X(23).

       PROCEDURE DIVISION.
       BEGIN.
           MERGE WorkFile
               ON ASCENDING KEY wStudentId
               USING TranFile, StudentFile
               GIVING NewStudentFile.
           STOP RUN.


       
