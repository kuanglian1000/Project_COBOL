       IDENTIFICATION DIVISION.
       PROGRAM-ID. Sub-DateValidate-V1.
      *> 自行開發版.(不錯了, 但有改善空間.)
      *>   ValidResult:
      *>   0 : valid
      *>   1 : not numeric
      *>   2 : year(yyyy) all zeros
      *>   3 : month(mm) all zeros
      *>   4 : day(dd) all zeros.
      *>   5 : month greater than 12.
      *>   6 : max day number not match the month has.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  DateToValidate.
           03  YYYY    PIC 9(4).
           03  MM      PIC 9(2).
           88  BIG     VALUE 01,03,05,07,08,10,12.
           88  SMALL   VALUE 04,06,09,11.
           88  TWO     VALUE 02.
           03  DD      PIC 9(2).
       01  Result PIC 9.
       
       LINKAGE SECTION.
       01  In-Date PIC 9(8).
       01  Out-ValidResult PIC 9.

       PROCEDURE DIVISION USING In-Date, Out-ValidResult.
       BEGIN.
           MOVE In-Date TO DateToValidate.
           PERFORM CheckDate
           MOVE Result TO Out-ValidResult.

           EXIT PROGRAM.

       CheckDate.
           EVALUATE TRUE
               WHEN In-Date NOT NUMERIC
                   MOVE 1 TO Result
               WHEN YYYY IS ZEROS
                   MOVE 2 TO Result
               WHEN MM IS ZEROS
                   MOVE 3 TO Result
               WHEN DD IS ZEROS
                   MOVE 4 TO Result
               WHEN MM > 12
                   MOVE 5 TO Result
               WHEN (BIG AND DD > 31) 
                       OR (SMALL AND DD > 30) 
                       OR (TWO AND DD > 29)
                   MOVE 6 TO Result
               WHEN OTHER
                   MOVE 0 TO Result
           END-EVALUATE.

      *>     END PROGRAM Sub-DateValidate-V1.
