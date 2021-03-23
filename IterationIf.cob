       IDENTIFICATION DIVISION.
       PROGRAM-ID. ITERATIONIF.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  Num1 PIC 9 VALUE ZEROS.
       01  Num2 PIC 9 VALUE ZEROS.
       01  Result PIC 99 VALUE ZEROS.
       01  Operator PIC X VALUE SPACE.

       PROCEDURE DIVISION.
       Calculator.
           PERFORM 3 TIMES
               DISPLAY "Enter First Number(1 digit):" WITH NO ADVANCING
               ACCEPT Num1
               DISPLAY "Enter Second Number(1 digit):" WITH NO ADVANCING
               ACCEPT Num2
               DISPLAY "Enter Operator(+ or *):" WITH NO ADVANCING
               ACCEPT Operator
               IF Operator = "+" THEN
                 Add Num1, Num2 Giving Result
               END-IF
               IF Operator = "*" THEN
                 Multiply Num1 By Num2 Giving Result
               END-IF
               Display "Result is = ", Result
           END-PERFORM.
           STOP RUN.
       