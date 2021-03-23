       IDENTIFICATION DIVISION.
       PROGRAM-ID. MULTIPLIER.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  Num1 PIC 9 VALUES ZEROES.
       01  Num2 PIC 9 VALUES ZEROES.
       01  Result PIC 99 VALUES ZEROES.

       PROCEDURE DIVISION.
       BEGIN.
      *>   DISPLAY "ENTER FIRST NUMBER (1 DIGIT):" WITH NO ADVANCING.
      *>   DISPLAY + [WITH NO ADVANCING]. 表示不加換行符號; 
      *>          沒+ [WITH NO ADVANCING]. 則會自動加換行符號.
           DISPLAY "ENTER FIRST NUMBER (1 DIGIT):" WITH NO ADVANCING.
           ACCEPT Num1.
           DISPLAY "ENTER second NUMBER (1 DIGIT):" WITH NO ADVANCING.
           ACCEPT Num2.
           MULTIPLY Num1 BY Num2 GIVING Result.
           DISPLAY "Result is = ", Result.
           STOP RUN.

       