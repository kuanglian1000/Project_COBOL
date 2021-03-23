       IDENTIFICATION DIVISION.
       PROGRAM-ID. PERFORMFORMAT4.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  LoopCount PIC 9 VALUE ZEROS.
       01  LoopCount2 PIC S9 VALUE ZEROS.

       PROCEDURE DIVISION.
       Begin.
           

           
           STOP RUN.

       LoopBody.
           DISPLAY "LoopBody " WITH NO ADVANCING
           DISPLAY "LoopCount = " LoopCount " LoopCount2 = " LoopCount2.
       