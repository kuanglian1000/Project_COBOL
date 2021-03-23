       IDENTIFICATION DIVISION.
       PROGRAM-ID. Sub-MultiplyNums.
      *>   This sub-program is CALLed from a Cobol program.
      *>   it requires 5 parameters.
      *>       2 to contain the numbers to be multiplied
      *>       2 to contain strings to be displayed
      *>       1 to return the result of the multiplication.

       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       LINKAGE SECTION.
      *> * Parameters passed to the subprogram must have corresponding 
      *> * entries in the LINKAGE SECTION of the CALLed subprogram but 
      *> * they don't have to be declared in any particular order in the
      *> * LINKAGE SECTION.
      *>   在LINKAGE SECTION內, 參數順序不重要.
       
       01  Num1    PIC 9(3).
       01  Num2    PIC 9(3).
       01  Answer  PIC 9(6) COMP.
       01  StrA    PIC X(20).
       01  StrB    PIC X(20).

      *>   (VIP)在PROCEDURE DIVISION內, 參數順序必須和 CALL..USING <參數> 相同.
       PROCEDURE DIVISION USING Num1, Num2, StrA, StrB, Answer.
       BEGIN.
           DISPLAY ">>> IN THE SUB-PROGRAM".
           DISPLAY "num1 = " , num1.
           DISPLAY "num2 = " , num2.
           DISPLAY "stra = " , stra.
           DISPLAY "strb = " , strb.

           MULTIPLY Num1 BY Num2 GIVING Answer.

           MOVE "NEW VALUE 123" TO StrA
           MOVE "NEW VALUE 456" TO StrB
           DISPLAY " LEAVING SUB-PROGRAM NOW. <<<".

           END PROGRAM Sub-MultiplyNums.
       