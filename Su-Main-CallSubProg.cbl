       IDENTIFICATION DIVISION.
       PROGRAM-ID. SU-MAIN-CALLSUBPROG.
       
      *> 示範如何使用 CALL 呼叫副程式.
      *> 副程式-MultiplyNums, 有5個參數, 前4個是INPUT-PARAMETERS, 最後1個是OUTPUT-PARAMETER.
      *> 副程式-Fickle, 展示 State Memory 情況.
      *> 副程式-Steadfast, 使用 IS INITIAL 可避免 State Memory 的發生.
       
       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  UserNumber PIC 99.
           88 InputStop VALUE 0.

      *> DEFAULT IS DISPLAY, CAN BE DISPLAYED.
       01  PrnResult PIC 9(6).

      *> 參數可以是 01 LEVEL OR ELEMENTARY DATA-ITEMS.
       01  Parameters.
           03  Number1 PIC 9(3).
           03  Number2 PIC 9(3).
           03  FirstString PIC X(19) VALUE "First parameter".
           03  SecondString PIC X(19) VALUE "Second parameter".
           03  Result PIC 9(6) COMP.
      *>     COMP 可作為參數, 但無法用來顯示, 必須搬至 DISPLAY 變數內.

       PROCEDURE DIVISION.
       BEGIN.
           PERFORM CallMultiplyNums.
           PERFORM CallFickle.
           PERFORM CallSteadfast.

           PERFORM MakeFickleSteadfast.

           STOP RUN.

       MakeFickleSteadfast.
           DISPLAY SPACE
           DISPLAY "-----Use 'CANCEL' VERB , Clear 'State memory'.-----".
           DISPLAY "Input Number(2 digits, 0 TO STOP): " WITH NO ADVANCING.
           ACCEPT UserNumber.
           DISPLAY "-----Use 'CANCEL' VERB , Before Clear 'State memory'.-----".
           CALL "Sub-Fickle" USING BY CONTENT UserNumber.
           PERFORM UNTIL InputStop
      *>       USE 'CANCEL' VERB TO clear STATE MEMORY.
               CANCEL "Sub-Fickle"
               CALL "Sub-Fickle" USING BY CONTENT UserNumber
               DISPLAY "Input Number(2 digits, 0 TO STOP): " WITH NO ADVANCING
               ACCEPT UserNumber
           END-PERFORM.
       
       CallSteadfast.
           DISPLAY SPACE
           DISPLAY "-----Call Third Sub-Program(Steadfast).-----".
           DISPLAY "Input Number(2 digits, 0 TO STOP): " WITH NO ADVANCING.
           ACCEPT UserNumber.
           PERFORM UNTIL InputStop
      *>       USE 'IS INITIAL' IN "Sub-Steadfast" to clear STATE MEMORY.
               CALL "Sub-Steadfast" USING BY CONTENT UserNumber
               DISPLAY "Input Number(2 digits, 0 TO STOP): " WITH NO ADVANCING
               ACCEPT UserNumber
           END-PERFORM.

       CallFickle.
           DISPLAY SPACE
           DISPLAY "-----Call Second Sub-Program.-----".
           DISPLAY "Input Number(2 digits, 0 TO STOP): " WITH NO ADVANCING.
           ACCEPT UserNumber.
           PERFORM UNTIL InputStop
               CALL "Sub-Fickle" USING BY CONTENT UserNumber
               DISPLAY "Input Number(2 digits, 0 TO STOP): " WITH NO ADVANCING
               ACCEPT UserNumber
           END-PERFORM.

       CallMultiplyNums.
           DISPLAY "Input 2 numbers(3 digits each) to be multiplied"
           DISPLAY "First Number: " WITH NO ADVANCING
           ACCEPT Number1.
           DISPLAY "Second Number: " WITH NO ADVANCING
           ACCEPT Number2.
           DISPLAY "First Number = ", Number1
           DISPLAY "Second Number = ", Number2
           DISPLAY ">>>> Calling sub-program Now...".

           CALL "Sub-MultiplyNums" 
             USING BY CONTENT Number1, Number2, FirstString,
                   BY REFERENCE SecondString, Result.
      *>     CALL "MultiplyNums" USING
      *>         BY VALUE IDENTIFER
      *>         RETURNING RETURN-CODE
      *>     END-CALL
           
           DISPLAY "Back to main-program now <<<<<<<".
           MOVE Result TO PrnResult.
           DISPLAY Number1 " multiplied by " Number2 " is = " PrnResult.

           DISPLAY "The first string is  " FirstString.
           DISPLAY "The second string is " SecondString.