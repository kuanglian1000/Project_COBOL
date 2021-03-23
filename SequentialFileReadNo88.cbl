           IDENTIFICATION DIVISION.
           PROGRAM-ID. SEQUENTIALFILEREADNO88.

           ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT StudentFile ASSIGN TO "Student.dat"
                 Organization is line sequential.

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
           BEGIN.
               OPEN INPUT StudentFile

               READ StudentFile
                   AT END MOVE HIGH-VALUES TO StudentDetails
               END-READ
               PERFORM UNTIL StudentDetails = HIGH-VALUES
                   DISPLAY StudentId SPACE StudentName SPACE CourseCode SPACE YoBirth
                   READ StudentFile
                       AT END MOVE HIGH-VALUE TO StudentDetails
                   END-READ
               END-PERFORM

               CLOSE StudentFile.
               STOP RUN.
