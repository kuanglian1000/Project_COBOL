       IDENTIFICATION DIVISION.
       PROGRAM-ID. INDEXEDFILE-SEQUENTIALREAD.
      *> 示範如何循序讀取 Indexed file
      *> 在任1個索引鍵上.
      *> DEFAULT KEY IS VideoCode.(不須另外新增KOR, key of reference.)
      *> 若選擇VideoTitle, 則須另外新增KOR

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT VideoFile ASSIGN TO "IDXVIDEO.DAT"
             ORGANIZATION IS INDEXED
             ACCESS MODE IS DYNAMIC
             RECORD KEY IS VideoCode
             ALTERNATE RECORD KEY IS VideoTitle
               WITH DUPLICATES
             FILE STATUS IS VideoStatus.

       DATA DIVISION.
       FILE SECTION.
       FD  VideoFile.
       01  VideoRecord.
           88  EndOfFile       VALUE HIGH-VALUE.
           03  VideoCode       PIC 9(5).
           03  VideoTitle      PIC X(40).
           03  SupplierCode    PIC 99.
       
       WORKING-STORAGE SECTION.
       01  VideoStatus PIC X(2).

       01  RequireSequence PIC 9.
           88  VideoCodeSequence   VALUE 1.
           88  VideoTitleSequence  VALUE 2.
       
       01  Prn-VideoRecord.
           03  Prn-VideoCode       PIC 9(5).
           03  Prn-VideoTitle      PIC BBBBX(40).
           03  Prn-SupplierCode    PIC BBBB99.
       
       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT VideoFile.

           DISPLAY "Enter Key : 1=VideoCode, 2=VideoTitleSequence -> " 
             WITH NO ADVANCING.
           ACCEPT RequireSequence.

      *>   Create KOR for VideoTitle(alternate record key)
           IF VideoTitleSequence
              MOVE SPACES TO VideoTitle
              START VideoFile KEY IS GREATER THAN VideoTitle
                   INVALID KEY DISPLAY "(INVALID) STATUS:", VideoStatus
              END-START
           END-IF

      *>   Read Indexed file sequentially by READ..NEXT RECORD
           READ VideoFile NEXT RECORD
               AT END SET EndOfFile TO TRUE
           END-READ
           PERFORM UNTIL EndOfFile
               MOVE VideoCode TO Prn-VideoCode
               MOVE VideoTitle TO Prn-VideoTitle
               MOVE SupplierCode TO Prn-SupplierCode
               DISPLAY Prn-VideoRecord
               READ VideoFile NEXT RECORD
                   AT END SET EndOfFile TO TRUE
               END-READ
           END-PERFORM

           CLOSE VideoFile.
           STOP RUN.