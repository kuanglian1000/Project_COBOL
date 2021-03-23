       IDENTIFICATION DIVISION.
       PROGRAM-ID. SEQUENTIALFILE-TO-RELATIVEFILE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT RelativeFile ASSIGN TO "RelativeFile-IsHere.dat"
             ORGANIZATION IS RELATIVE
             ACCESS MODE IS RANDOM
             RELATIVE KEY IS SupplierKey
             FILE STATUS IS SupplierStatus.

           SELECT SequentialFile ASSIGN TO "RelativeFileData.dat"
             ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  RelativeFile.
       01  SupplierRecord.
           03  SupplierCode PIC 99.
           03  SupplierName PIC X(20).
           03  SupplierAddress PIC X(50).

       FD  SequentialFile.
       01  SupplierRecord-Seq.
           88  EndOfFile   VALUE HIGH-VALUE.
           03  SupplierCode-Seq PIC 99.
           03  SupplierName-Seq PIC X(20).
           03  SupplierAddress-Seq PIC X(50).

       WORKING-STORAGE SECTION.
       01  SupplierStatus PIC X(2).
       01  SupplierKey    PIC 99.

       PROCEDURE DIVISION.
       BEGIN.
           OPEN OUTPUT RelativeFile.
           OPEN INPUT SequentialFile.

           READ SequentialFile
               AT END SET EndOfFile TO TRUE
           END-READ

           PERFORM UNTIL EndOfFile
               MOVE SupplierRecord-Seq TO SupplierRecord
               MOVE SupplierCode-Seq TO SupplierKey
               WRITE SupplierRecord
                   INVALID KEY DISPLAY "SUPPLIER STATUS = " SupplierStatus
               END-WRITE
               READ SequentialFile
                   AT END SET EndOfFile TO TRUE
               END-READ
           END-PERFORM

           CLOSE RelativeFile, SequentialFile.

           STOP RUN.
