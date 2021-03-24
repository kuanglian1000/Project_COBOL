       IDENTIFICATION DIVISION.
       PROGRAM-ID. SuMain-Call-DateValidate.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  FILLER PIC 9 VALUE 0.
           88  EndOfInput VALUE 1.
       
       01  InputDateIn PIC 9(8).

       01  ValidationResult PIC 9.
           88  DateIsValid VALUE 0.
           88  DateNotNumeric VALUE 1.
           88  YearContainsZeros VALUE 2.
           88  MonthContainsZeros VALUE 3.
           88  DayContainsZeros VALUE 4.
           88  MonthGreaterThan12 VALUE 5.
           88  DayTooGreatForMonth VALUE 6.
       
       PROCEDURE DIVISION.
       BEGIN.
           DISPLAY "Input Date as YYYYMMDD:" WITH No Advancing.
           ACCEPT InputDateIn.
           
           DISPLAY "(BEFORE CALL SUB) INPUTDATEIN = ", InputDateIn
      *>     CALL "Sub-DateValidate-V1"
      *>       USING InputDateIn, ValidationResult.

           CALL "Sub-DateValidate-V2"
             USING InputDateIn, ValidationResult.

           DISPLAY "InputDate : ", InputDateIn
           DISPLAY "ValidResult : ", ValidationResult
           EVALUATE TRUE
               WHEN DateIsValid    DISPLAY "Date is valid."
               WHEN DateNotNumeric DISPLAY "Date is not numeric."
               WHEN YearContainsZeros DISPLAY "Year contains all zeros."
               WHEN MonthContainsZeros DISPLAY "Month contains all zeros."
               WHEN DayContainsZeros   DISPLAY "Day contains all zeros."
               WHEN MonthGreaterThan12 DISPLAY "Month too great."
               WHEN DayTooGreatForMonth DISPLAY "Day too great for month"
               WHEN OTHER DISPLAY "(Error) unable to valid..."
           END-EVALUATE
           
           STOP RUN.
