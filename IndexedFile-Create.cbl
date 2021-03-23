       IDENTIFICATION DIVISION.
       PROGRAM-ID. INDEXEDFILE-CREATE.
      *> Create an indexed file from a sequential file.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT VideoFile ASSIGN TO "IDXVIDEO.DAT"
             ORGANIZATION IS INDEXED
             ACCESS MODE IS RANDOM
             RECORD KEY IS VideoCode
      *>     問題出在這裡, ALTERNATE RECORD 少寫關鍵字 KEY..
             ALTERNATE RECORD KEY IS VideoTitle
               WITH DUPLICATES
             FILE STATUS IS VideoStatus.

           SELECT SeqVideoFile ASSIGN TO "SEQVIDEO.DAT"
             ORGANIZATION IS LINE SEQUENTIAL.
       
       DATA DIVISION.
       FILE SECTION.
       FD  VideoFile.
       01  VideoRecord.
           03  VideoCode   PIC 9(5).
           03  VideoTitle  PIC X(40).
           03  VideoSupplierCode   PIC 99.

       FD  SeqVideoFile.
       01  SeqVideoRecord.
           88  EndOfFile VALUE HIGH-VALUE.
           03  SeqVideoCode    PIC 9(5).
           03  SeqVideoTitle   PIC X(40).
           03  SeqVideoSupplierCode    PIC 99.

       WORKING-STORAGE SECTION.
       01  VideoStatus PIC X(2).

       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT SeqVideoFile.
           OPEN OUTPUT VideoFile.

           READ SeqVideoFile
               AT END SET EndOfFile TO TRUE
           END-READ.
           PERFORM UNTIL EndOfFile
               WRITE VideoRecord FROM SeqVideoRecord
                   INVALID KEY DISPLAY "(INVALID KEY) Record Status = ", VideoStatus
               END-WRITE
               READ SeqVideoFile
                   AT END SET EndOfFile TO TRUE
               END-READ
           END-PERFORM.

           CLOSE SeqVideoFile, VideoFile.
           STOP RUN.
       