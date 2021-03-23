       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST.
       author. KL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  wsNum1 PIC S9(3)V9(2).
       01  wsNum2 PIC P9(5).

       01  wsNum3 PIC 9(1) VALUE zero.
       01  wsNum4 PIC S9(1).

       01 WS-DESCRIPTION.
           05 WS-DATE1 VALUE '20140831'.
               10 WS-YEAR PIC X(4).
               10 WS-MONTH PIC X(2).
               10 WS-DATE PIC X(2).
           05 WS-DATE2 REDEFINES WS-DATE1 PIC 9(6).
           05 WS-DATE3 REDEFINES WS-DATE1 PIC A(8).

       01  WS-CNT PIC 9 VALUE 0.

       PROCEDURE DIVISION.
      *> This is a comment line.
      *> Comment line also.
           DISPLAY "Test Running.".

           SUBTRACT -1 FROM wsNum3 giving wsNum3.
           MOVE -2 TO wsNum4
           DISPLAY "wsNum3 IS " wsNum3.
           DISPLAY "wsNum4 IS " wsNum4.

           MOVE 156 TO wsNum1.
           MOVE 256.98 TO wsNum2.
           DISPLAY "wsNum1 IS " wsNum1.
           DISPLAY wsNum2.

           DISPLAY "BEFORE: " WS-DATE1 "," WS-DATE2 "," WS-DATE3.
           MOVE "20210319" TO WS-DATE1.
           DISPLAY "AFTER: " WS-DATE1 "," WS-DATE2 "," WS-DATE3.

           PERFORM B-PARA WITH TEST BEFORE UNTIL WS-CNT = 5.
           INITIALIZE WS-CNT.
           PERFORM B-PARA WITH TEST AFTER UNTIL WS-CNT = 5.
           
           STOP RUN.
       
       B-PARA.
           DISPLAY "WS-CNT:" WS-CNT.
           ADD 1 TO WS-CNT.
