       IDENTIFICATION DIVISION.
       PROGRAM-ID. PERFORMFORMAT3.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  IterCount PIC 99 VALUE ZEROS.
           88  MaxCountReached VALUE 99.
       01  UserInput PIC 99 VALUE ZEROS.
           88  EndOfUserInput VALUE ZEROS.
       01  RunningTotal PIC 999 VALUE ZEROS.
       01  AverageValue PIC 99 VALUE ZEROS.
       
       PROCEDURE DIVISION.
       Begin.
           PERFORM UNTIL IterCount = 5
               DISPLAY "IterCount = ", IterCount
               ADD 1 TO IterCount
           END-PERFORM
           DISPLAY "FINISH In Line Perform.".

           INITIALIZE IterCount.
           DISPLAY "After INITIALIZE, IterCount Value = " IterCount.

           DISPLAY "Enter a stream of up to 99 numbers."
           DISPLAY "Each number must be in the range 1-99. Enter 0 to stop"
           DISPLAY "Enter Number: " WITH NO ADVANCING.
           ACCEPT UserInput.
           PERFORM GetUserInput UNTIL EndOfUserInput OR MaxCountReached.

           DISPLAY "RunningTotal is ", RunningTotal.
           DISPLAY "IterCount is ", IterCount.
           COMPUTE AverageValue = RunningTotal / IterCount.
           DISPLAY "AverageValue is ", AverageValue.
           STOP RUN.

       GetUserInput.
           ADD UserInput TO RunningTotal
               ON SIZE ERROR DISPLAY "(Error): New Total is too large"
               NOT ON SIZE ERROR ADD 1 TO IterCount END-ADD
           END-ADD
           
           DISPLAY "Enter a stream of up to 99 numbers."
           DISPLAY "Each number must be in the range 1-99. Enter 0 to stop"
           DISPLAY "Enter Number: " WITH NO ADVANCING.
           ACCEPT UserInput.
           
       