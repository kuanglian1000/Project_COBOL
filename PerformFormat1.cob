       IDENTIFICATION DIVISION.
       PROGRAM-ID. PERFORMFORMAT1.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       PROCEDURE DIVISION.
       TopLevel.
           DISPLAY "[TopLevel]-In. Starting to run program.".
           PERFORM OneLevelDown.
           DISPLAY "[TopLevel]-Back".
           STOP RUN.
       
       TwoLevelDown.
           DISPLAY "[22-TwoLevel]-In"
           PERFORM ThreeLevelDown
           DISPLAY "[22-TwoLevel]-Back".
           
       OneLevelDown.
           DISPLAY "[1-OneLevel]-In"
           PERFORM TwoLevelDown
           DISPLAY "[1-OneLevel]-Back".
           
       ThreeLevelDown.
           DISPLAY "[333-ThreeLevel]-In"
           DISPLAY "[333-ThreeLevel]-Back".
           

