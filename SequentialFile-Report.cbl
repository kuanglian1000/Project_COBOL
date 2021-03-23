       IDENTIFICATION DIVISION.
       PROGRAM-ID. SEQUENTIALFILE-REPORT.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           
           SELECT StudentFile assign to "STUDENTS-reportData.DAT"
             organization is line sequential
             access mode is sequential.
            
           SELECT ReportFile ASSIGN TO "STUDENTS-reportOutput.dat"
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  StudentFile.
       01  StudentDetails.
           88  EndOfStudentFile VALUE HIGH-VALUES.
           03  StudentId   PIC x(7).
           03  StudentName PIC X(10).
           03  DateOfBirth.
               05  YoBirth PIC 9(4).
               05  MoBirth PIC 9(2).
               05  DoBirth PIC 9(2).
           03  CourseCode  PIC X(4).
           03  Gender      PIC X.
               88  Male    Value "M","m".
           
       FD  ReportFile.
       01  ReportLine  PIC X(40).

       WORKING-STORAGE SECTION.
       01  HeadingLine PIC X(21) VALUE "=Record Count Report=".

       01  StudentTotalLine.
           03  FILLER PIC X(17) VALUE "Total Students = ".
           03  PrnStudentCount PIC Z,ZZ9.
       
       01  MaleTotalLine.
           03  FILLER PIC X(17) VALUE "Total Males = ".
           03  PrnMaleCount PIC Z,ZZ9.
       
       01  FemaleTotalLine.
           03  FILLER PIC X(17) VALUE "Total Females = ".
           03  PrnFemaleCount PIC Z,ZZ9.

       01  WorkingTotal.
           03  StudentCount    PIC 9(4) VALUE ZERO.
           03  MaleCount       PIC 9(4) VALUE ZERO.
           03  FemaleCount     PIC 9(4) VALUE ZERO.
       
       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT StudentFile
           OPEN OUTPUT ReportFile

           READ StudentFile
               AT END SET EndOfStudentFile TO TRUE
           END-READ
           PERFORM UNTIL EndOfStudentFile
               ADD 1 TO StudentCount
               IF Male ADD 1 TO MaleCount
                   ELSE ADD 1 TO FemaleCount
               END-IF
               READ StudentFile
                   AT END SET EndOfStudentFile TO TRUE
               END-READ
           END-PERFORM.

           PERFORM PRINT-REPORT.

           CLOSE StudentFile.
           CLOSE ReportFile.
           
           STOP RUN.
       
       PRINT-REPORT.
           MOVE StudentCount TO PrnStudentCount.
           MOVE MaleCount TO PrnMaleCount.
           MOVE FemaleCount TO PrnFemaleCount.

           WRITE ReportLine FROM HeadingLine
               AFTER ADVANCING PAGE
           WRITE ReportLine FROM StudentTotalLine
               AFTER ADVANCING 2 LINES
           WRITE ReportLine FROM MaleTotalLine
               AFTER ADVANCING 2 LINES
           WRITE ReportLine FROM FemaleTotalLine
               AFTER ADVANCING 2 LINES.