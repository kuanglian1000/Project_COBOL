       IDENTIFICATION DIVISION.
       PROGRAM-ID. Sub-Fickle.
      *>   (預設)示範 STATE MEMORY 功能, 它會保留上次呼叫的值      
      
       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  RunningTotal PIC 9(4) VALUE 150.

       LINKAGE SECTION.
       01  Num1 PIC 99.

       PROCEDURE DIVISION USING Num1.
       BEGIN.
           ADD Num1 TO RunningTotal.
           DISPLAY "The total (so far) is ", RunningTotal.
           END PROGRAM Sub-Fickle.
