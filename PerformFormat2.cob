       IDENTIFICATION DIVISION.
       PROGRAM-ID. PERFORMFORMAT2.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  NumOfTimes PIC 9 VALUE 5.
       
       PROCEDURE DIVISION.
       Begin.
           DISPLAY "Program Begin.".
      *>     用法1
           PERFORM 3 TIMES
               DISPLAY ">> In line Perform <<"
           END-PERFORM
           DISPLAY "Finished In line Perform".
      *>     用法2
           PERFORM OutOfLineEG NumOfTimes TIMES
           DISPLAY "Back to Program Begin. Program Stop."
           STOP RUN.
       
       OutOfLineEG.
           DISPLAY ">> Out of line Perform <<".