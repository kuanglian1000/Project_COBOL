      *> $set sourceformat "FREE"
       IDENTIFICATION DIVISION.
       PROGRAM-ID. AcceptAndDisplay.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  StudentDetails.
           02  StudentId   PIC 9(7).
           02  StudentName.
               03  FirstName PIC X(8).
               03  LastName  PIC XX.
           02  CourseCode  PIC X(4).
           02  Gender  PIC X.
      
      *> YYYYMMDD
       01  CurrentDate.
           03  CurrentYear PIC 9(4).
           03  CurrentMonth PIC 99.
           03  CurrentDay  PIC 99.
      
      *> YYDDD
       01  DayOfYear.
           03  FILLER PIC 9(4).
           03  YearDay PIC 9(3).
      
      *> HHMMSSss  s = S/100
       01  CurrentTime.
           03  CurrentHour PIC 99.
           03  CurrentMinute PIC 99.
           03  FILLER PIC 9(4).

       PROCEDURE DIVISION.
       Begin.
           DISPLAY "Enter student details using template below".
           DISPLAY "Enter - ID(7),FirstName(8),LastName(2),CourseCode(4),Gender(1)".
           DISPLAY "==Please Input Your Data==".
           ACCEPT StudentDetails.
           ACCEPT CurrentDate FROM DATE YYYYMMDD.
           ACCEPT DayOfYear FROM DAY YYYYDDD.
           ACCEPT CurrentTime FROM TIME.
           DISPLAY "Name is ", FirstName SPACE LastName.
           DISPLAY "Date is " CurrentDay Space CurrentMonth Space CurrentYear.
           DISPLAY "Today is " YearDay " of the year".
           DISPLAY "The time is " CurrentHour ":" CurrentMinute.
           STOP RUN.
       