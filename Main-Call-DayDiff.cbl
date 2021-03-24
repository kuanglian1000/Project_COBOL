       IDENTIFICATION DIVISION.
       PROGRAM-ID. Main-Call-DayDiff.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  Dates.
           03  FirstDate           PIC X(8).
           03  SecondDate          PIC X(8).
           03  FirstDate-Prn       PIC XX/XX/XXXX.
           03  SecondDate-Prn      PIC XX/XX/XXXX.

       01  DayDiffs.
           03  DayDifference       PIC S9(7).
           03  DayDifference-Prn   PIC ----,--9.
       
       01  ValidationResult        PIC 9.
           88  DateIsValid         VALUE 0.
           88  DateIsNotValid      VALUE 1 THRU 6.
           88  DateNotNumeric      VALUE 1.
           88  YearContainsZeros   Value 2.
           88  MonthContainsZeros  Value 3.
           88  DayContainsZeros    Value 4.
           88  MonthGreaterThan12  Value 5.
           88  DayToGreatForMonth  Value 6.

       PROCEDURE DIVISION.
       Begin.
           SET DateIsNotValid TO TRUE
           PERFORM GetValidFirstDate UNTIL DateIsValid
           DISPLAY "First Date is ", FirstDate.

           SET DateIsNotValid TO TRUE
           PERFORM GetValidSecondDate UNTIL DateIsValid
           DISPLAY "Second Date is ", SecondDate.



           STOP RUN.

       GetValidFirstDate.
           DISPLAY SPACE.
           DISPLAY "Input First Date: " WITH NO ADVANCING
           ACCEPT FirstDate.
           CALL "Sub-DateValidate-V2" 
             USING BY CONTENT FirstDate, 
                   BY REFERENCE ValidationResult
           IF DateIsNotValid
             PERFORM DisplayErrorMessage
           END-IF.

      *> 取得第2個日期
       GetValidSecondDate.
           DISPLAY SPACE.
           DISPLAY "Input Second Date: " WITH NO ADVANCING
           ACCEPT SecondDate.
           CALL "Sub-DateValidate-V2" 
             USING BY CONTENT SecondDate, 
                   BY REFERENCE ValidationResult
           IF DateIsNotValid
             PERFORM DisplayErrorMessage
           END-IF.

      *> 顯示錯誤訊息
       DisplayErrorMessage.
           DISPLAY "ValidationResult is ", ValidationResult
           EVALUATE TRUE
               WHEN  DateNotNumeric      DISPLAY "(Error)DateNotNumeric"
               WHEN  YearContainsZeros   DISPLAY "(Error)YearContainsZeros"
               WHEN  MonthContainsZeros  DISPLAY "(Error)MonthContainsZeros"
               WHEN  DayContainsZeros    DISPLAY "(Error)DayContainsZeros"
               WHEN  MonthGreaterThan12  DISPLAY "(Error)MonthGreaterThan12"
               WHEN  DayToGreatForMonth  DISPLAY "(Error)DayToGreatForMonth"
               WHEN OTHER DISPLAY "(Error) Out of 1-6 Error Message"
           END-EVALUATE.
