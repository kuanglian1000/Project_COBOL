       IDENTIFICATION DIVISION.
       PROGRAM-ID. INDEXEDFILE-DIRECTREAD.

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
           03  VideoCode       PIC 9(5).
           03  VideoTitle      PIC X(40).
           03  SupplierCode    PIC 99.
       
       WORKING-STORAGE SECTION.
       01  VideoStatus PIC X(2).
           88  RECORDFOUND VALUE "00".

       01  RequiredKey           PIC 9.
           88 VideoCodeKey      VALUE 1.
           88 VideoTitleKey     VALUE 2.

       01  Prn-VideoRecord.
           03  Prn-VideoCode       PIC 9(5).
           03  Prn-VideoTitle      PIC BBBBX(40).
           03  Prn-SupplierCode    PIC BBBB99.
           
       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT VideoFile.

           DISPLAY "CHOOSE YOUR FAVORITE KEY VIDEOCODE = 1, VIDEOTITLE = 2:"
             WITH NO ADVANCING.
           ACCEPT RequiredKey.

           IF VideoCodeKey
              DISPLAY "ENTER VIDEO CODE(5 DIGITS) : " WITH NO ADVANCING
              ACCEPT VideoCode
              READ VideoFile
               KEY IS VideoCode
               INVALID KEY DISPLAY "(key=CODE)STATUS : " , VideoStatus
              END-READ
           END-IF

           IF VideoTitleKey
              DISPLAY "ENTER VIDEO TITLE(40 CHARS) : " WITH NO ADVANCING
              ACCEPT VideoTitle
              READ VideoFile
               KEY IS VideoTitle
               INVALID KEY DISPLAY "(key=TITLE)STATUS : " , VideoStatus
              END-READ              
           END-IF

           IF RECORDFOUND
               MOVE VideoCode TO Prn-VideoCode
               MOVE VideoTitle TO Prn-VideoTitle
               MOVE SupplierCode TO Prn-SupplierCode
               DISPLAY Prn-VideoRecord
           ELSE
               DISPLAY "..NOTHING FOUND.."
           END-IF.

           CLOSE VideoFile.
           STOP RUN.
