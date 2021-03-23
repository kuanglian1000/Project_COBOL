       IDENTIFICATION DIVISION.
       PROGRAM-ID. SEQUENTIALFILEWRITE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT StudentFile ASSIGN TO "Student.dat"
             ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  StudentFile.
       01  StudentDetails.
           03  StudentId PIC 9(7).
           03  StudentName.
               05  FirstName PIC X(8).
               05  LastName    PIC XX.
           03  DateOfBirth.
               05  YoBirth PIC 9(4).
               05  MoBirth PIC 9(2).
               05  DoBirth PIC 9(2).
           03  CourseCode  PIC X(4).
           03  Gender      PIC X.

       PROCEDURE DIVISION.
       Begin.
           OPEN OUTPUT StudentFile
           DISPLAY "ENTER STUDENT DETAIL USING TEMPLATE BELOW. ENTER NO DATA TO END."
           
           PERFORM GetStudentDetails
           PERFORM UNTIL StudentDetails = SPACE
               WRITE StudentDetails
               PERFORM GetStudentDetails
           END-PERFORM
           
           CLOSE StudentFile
           STOP RUN.
       
       GetStudentDetails.
           DISPLAY "Enter => Id,FirstName,LastName,Year,Month,Day,CourseCode,Gender"
           DISPLAY "1234567FFFFFFFFLLYYYYMMDDCodeG"
           ACCEPT StudentDetails.