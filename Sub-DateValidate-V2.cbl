       IDENTIFICATION DIVISION.
       PROGRAM-ID. Sub-DateValidate-V2 IS INITIAL.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  MonthDayTable.
           03  TableValues PIC X(24)
                   VALUE "312831303130313130313031".
           03  FILLER REDEFINES TableValues.
               05  DaysInMonth
                   OCCURS 12 TIMES PIC 99.

       01  CurruptDate PIC 9(8).

       01  LeapQuot    PIC 9(4).
       01  LeapRemain  PIC 9(4).

       01  FILLER  PIC 9 VALUE ZERO.
           88  LeapYear VALUE 1.
       
       LINKAGE SECTION.
       01  InputDateLK.
           03  YearLK PIC 9(4).
           03  MonthLK PIC 99.
               88  MonthInvalid VALUE 13 THRU 99.
               88  MonthIsFebruary VALUE 2.
           03  DayLK PIC 99.

       01  ValidationResultLK PIC 9.
           88  DateIsValid VALUE 0.
           88  DateNotNumeric VALUE 1.
           88  YearContainsZeros VALUE 2.
           88  MonthContainsZeros VALUE 3.
           88  DayContainsZeros VALUE 4.
           88  MonthGreaterThan12 VALUE 5.
           88  DayTooGreatForMonth VALUE 6.

       PROCEDURE DIVISION USING InputDateLK, ValidationResultLK.
       Begin.
           EVALUATE TRUE
             WHEN NOT InputDateLK NUMERIC SET DateNotNumeric TO TRUE
             WHEN YearLK = 0 SET YearContainsZeros TO TRUE
             WHEN MonthLK = 0 SET MonthContainsZeros TO TRUE
             WHEN DayLK = 0 SET DayContainsZeros TO TRUE
             WHEN MonthInvalid SET MonthGreaterThan12 TO TRUE
             WHEN OTHER 
               PERFORM CheckValidDay
           END-EVALUATE.
           
           EXIT PROGRAM.

       CheckValidDay.
      *>   閏年, 判斷規則:
      *>   1. 年份可被400整除 = 閏年
      *>   2. 年份不被100整除, 但被4整除 = 閏年 
           DIVIDE YearLK BY 400 GIVING LeapQuot REMAINDER LeapRemain.
           IF LeapRemain = 0
              SET LeapYear TO TRUE
           ELSE
              DIVIDE YearLK BY 100 GIVING LeapQuot REMAINDER LeapRemain
              IF LeapRemain NOT = 0
               DIVIDE YearLK BY 4 GIVING LeapQuot REMAINDER LeapRemain
               IF LeapRemain = 0
                   SET LeapYear TO TRUE
               END-IF
              END-IF
           END-IF.

      *>   閏年, 2月給29天
           IF LeapYear AND MonthLK = 2
               MOVE 29 TO DaysInMonth(2)
           END-IF.

      *>   判斷合法日期
           IF DayLK > DaysInMonth(MonthLK)
               SET DayTooGreatForMonth TO TRUE
           ELSE
               SET DateIsValid TO TRUE
           END-IF.
