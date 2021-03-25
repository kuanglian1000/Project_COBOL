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

           CALL "TwDateToEuDate" 
             USING BY CONTENT FirstDate, 
                   BY REFERENCE FirstDate.
           DISPLAY "First Date(ddmmyyyy) = ", FirstDate.

           CALL "EuDateToTwDate"
             USING BY CONTENT FirstDate,
                   BY REFERENCE FirstDate.
           DISPLAY "First Date(yyyyMMdd) = ", FirstDate.

           DISPLAY SPACES.
           CALL "GetDayDiff"
             USING BY CONTENT FirstDate, SecondDate
                   BY REFERENCE DayDifference.
           MOVE DayDifference TO DayDifference-Prn.

           CALL "TwDateToEuDate"
             USING BY CONTENT FirstDate,
                   BY REFERENCE FirstDate.
           MOVE FirstDate To FirstDate-Prn.

           CALL "TwDateToEuDate"
             USING BY CONTENT SecondDate,
                   BY REFERENCE SecondDate.
           MOVE SecondDate TO SecondDate-Prn.

      *>   Show Result.
           DISPLAY SPACES
           DISPLAY "== Result =="
           DISPLAY "The difference between " FirstDate-Prn " and "
             SecondDate-Prn " is " DayDifference-Prn.

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
      
      *> =========================================================
      *> Convert a Date in DDMMYYYY => YYYYMMDD.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EuDateToTwDate.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  wsTwDate.
           03  TwYYYY  PIC 9(4).
           03  TwMM    PIC 99.
           03  TwDD    PIC 99.
           
       LINKAGE SECTION.
       01  EuDate.
           03  EuDD    PIC 99.
           03  EuMM    PIC 99.
           03  EuYYYY  PIC 9(4).
       01  outTwDate   PIC 9(8).
       
       PROCEDURE DIVISION USING EuDate, outTwDate.
       BEGIN.
           MOVE EuDD TO TwDD.
           MOVE EuMM TO TwMM.
           MOVE EuYYYY TO TwYYYY.
           MOVE wsTwDate TO outTwDate.
           EXIT PROGRAM.
       END PROGRAM EuDateToTwDate.

      *> =========================================================
      *> Convert a Date in YYYYMMDD => DDMMYYYY.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TwDateToEuDate.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  wsEuDate.
           03  EuDD    PIC 99.
           03  EuMM    PIC 99.
           03  EuYYYY  PIC 9(4).
       
       LINKAGE SECTION.
       01  TwDate.
           03  TwYYYY  PIC 9(4).
           03  TwMM    PIC 99.
           03  TwDD    PIC 99.
       01  outEuDate   PIC 9(8).
       
       PROCEDURE DIVISION USING TwDate, outEuDate.
       Begin.
           MOVE TwYYYY to EuYYYY.
           MOVE TwMM to EuMM.
           MOVE TwDD to EuDD.
           MOVE wsEuDate to outEuDate.
           EXIT PROGRAM.           
       END PROGRAM TwDateToEuDate.

      *> =========================================================
      *> 計算兩日期間的差異數
       IDENTIFICATION DIVISION.
       PROGRAM-ID. GetDayDiff.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       LINKAGE SECTION.
       01  Date1   PIC 9(8).
       01  Date2   PIC 9(8).
       01  Difference  PIC S9(7).
       
       PROCEDURE DIVISION USING Date1, Date2, Difference.
       Begin.
           COMPUTE Difference = FUNCTION INTEGER-OF-DATE(Date1)
               - FUNCTION INTEGER-OF-DATE(Date2)
           EXIT PROGRAM.           
       END PROGRAM GetDayDiff.

       END PROGRAM Main-Call-DayDiff.
