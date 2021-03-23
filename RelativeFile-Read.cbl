       IDENTIFICATION DIVISION.
       PROGRAM-ID. RELATIVEFILE-READ.
      *> Read a relative file directly or in sequence.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT RelativeFile ASSIGN TO "RelativeFile-IsHere.dat"
             ORGANIZATION IS RELATIVE
             ACCESS MODE IS DYNAMIC
             RELATIVE KEY IS SupplierKey
             FILE STATUS IS SupplierStatus.

       DATA DIVISION.
       FILE SECTION.
       FD  RelativeFile.
       01  SupplierRecord.
           88  EndOfFile   VALUE HIGH-VALUE.
           03  SupplierCode    PIC 99.
           03  SupplierName    PIC X(20).
           03  SupplierAddress PIC X(50).
           
       WORKING-STORAGE SECTION.
       01  SupplierStatus  PIC X(2).
           88  RECORDFOUND VALUE "00".

       01  SupplierKey PIC 99.

       01  PRNSUPPLIERRECORD.
           03  PRNSUPPLIERCODE     PIC BB99.
           03  PRNSUPPLIERNAME     PIC BBX(20).
           03  PRNSUPPLIERADDRESS  PIC BBX(50).
       
       01  READTYPE    PIC 9.
           88  DIRECTREAD  VALUE 1.
           88  SEQUENTIALREAD  VALUE 2.
           
       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT RelativeFile.
           DISPLAY "CHOOSE READ TYPE : DIRECT READ = 1, SEQUENTIAL READ = 2 ? "
             WITH NO ADVANCING
           ACCEPT READTYPE.

           IF DIRECTREAD
               DISPLAY "ENTER KEY(2 DIGITS) TO SHOW : " WITH NO ADVANCING
               ACCEPT SupplierKey
               READ RelativeFile
                   INVALID KEY DISPLAY "STATUS = ", SupplierStatus
               END-READ
               PERFORM DISPLAYrECORD
           END-IF

           IF SEQUENTIALREAD
               READ RelativeFile NEXT RECORD
                   AT END SET EndOfFile TO TRUE
               END-READ
               PERFORM UNTIL EndOfFile
                   PERFORM DISPLAYrECORD
                   READ RelativeFile NEXT RECORD
                       AT END SET EndOfFile TO TRUE
                   END-READ
               END-PERFORM
           END-IF

           CLOSE RelativeFile.
           STOP RUN.

       DISPLAYrECORD.
           IF RECORDFOUND
               MOVE SupplierCode TO PRNSUPPLIERCODE
               MOVE SupplierName TO PRNSUPPLIERNAME
               MOVE SupplierAddress TO PRNSUPPLIERADDRESS
               DISPLAY PRNSUPPLIERRECORD
           END-IF.
