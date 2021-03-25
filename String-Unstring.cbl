       IDENTIFICATION DIVISION.
       PROGRAM-ID. STRING-UNSTRING.
      *> 篩選出 "InsertSupplier"
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT InputData ASSIGN TO "String-UnstringData.dat"
             ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  InputData.
      *> 
       01  SupplierAndVideoRecord.
           88  EndOfFile   VALUE HIGH-VALUE.
           03  TypeCode    PIC XX.
               88  DeleteSupplier  VALUE "1,".
               88  DeleteVideo     VALUE "2,".
               88  InsertVideo     VALUE "3,".
               88  InsertSupplier  VALUE "4,".
               88  ValidTypeCode   VALUE "1,", "2,", "3,", "4,".
           03  RemainRec   PIC X(78).

       WORKING-STORAGE SECTION.
       01  InsertSupplierRec.
           03  TransType       PIC 9.
           03  TransDate       PIC X(8).
           03  SupplierCode    PIC XX.
           03  SupplierName    PIC X(20).
           03  SupplierAddress PIC X(50).
      
      *> 檢查欄位長度
       01  InsertSupplierCount.
           03  DateCount           PIC 99.
               88  ValidDate       VALUE 8.
           03  CodeCount           PIC 99.
               88  ValidCode       VALUE 1 THRU 2.
           03  NameCount           PIC 99.
               88  ValidName       VALUE 1 THRU 20.
           03  AddressCount        PIC 99.
               88  ValidAddress    VALUE 1 THRU 50.
      
      *> 儲存每列實際長度
       01  StringEnd   PIC 99.
           
       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT InputData
           READ InputData
               AT END SET EndOfFile TO TRUE
           END-READ
           PERFORM UNTIL EndOfFile 

      *>   計算每行實際長度
               MOVE ZEROS TO InsertSupplierCount
               MOVE 0 to StringEnd
               INSPECT RemainRec TALLYING StringEnd FOR TRAILING SPACES
               COMPUTE StringEnd = 78 - StringEnd
               
      *>   只抓"InsertSupplier"
               IF InsertSupplier
      *>             DISPLAY SupplierAndVideoRecord
                   UNSTRING RemainRec(1:StringEnd) DELIMITED BY ","
                     INTO TransDate COUNT IN DateCount
                      SupplierCode COUNT IN CodeCount
                      SupplierName COUNT IN NameCount
                      SupplierAddress COUNT IN AddressCount
                   END-UNSTRING
                   PERFORM ShowErrorMsg
               else
                   IF NOT ValidTypeCode
                       DISPLAY SPACES
                       DISPLAY "Record = " RemainRec(1:70)
                       DISPLAY "Type Code Error(" TypeCode ")"
                   END-IF
               END-IF

               READ InputData
                   AT END SET EndOfFile TO TRUE
               END-READ
           END-PERFORM

           CLOSE InputData
           STOP RUN.
       
       ShowErrorMsg.
           DISPLAY SPACES
           DISPLAY "Record = " RemainRec(1:70)
           IF NOT ValidDate DISPLAY "TransDate Size Error(" TransDate ")" END-IF
           IF NOT ValidCode DISPLAY "SupplierCode Size Error(" SupplierCode ")" END-IF
           IF NOT ValidName DISPLAY "SupplierName Size Error(" SupplierName ")" END-IF
           IF NOT ValidAddress DISPLAY "SupplierAddress Size Error(" SupplierAddress ")" END-IF.
