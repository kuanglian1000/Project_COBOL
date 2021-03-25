       IDENTIFICATION DIVISION.
       PROGRAM-ID. STRING-INSPECT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  xStr        PIC X(50) VALUE "    Tfis is the first source string".
       01  xStr2       PIC X(32) VALUE "This is the second source string".
       01  StrSize     PIC 99 VALUE 32.
       01  CharCount   PIC 99 VALUE Zeros.
       01  EndCount    PIC 99 VALUE Zeros.
       01  yStr        PIC X(4) VALUE spaces.
       01  CharPos     PIC 99 VALUE Zeros.
       01  StrLength   PIC 99 VALUE Zeros.

       PROCEDURE DIVISION.
       BEGIN.
           DISPLAY "Task1-[startPosition,Length] : " xStr(16:5).
           DISPLAY "Task2-[startPosition,Length] : " xStr2(1:7).
           
           MOVE 13 TO StrLength
           COMPUTE CharPos = (StrSize - StrLength) + 1
           DISPLAY "Task3-Get last 13 chars : " xStr2(CharPos : StrLength).

      *>     回傳字串長度
           MOVE 0 TO StrSize
           INSPECT xStr TALLYING StrSize FOR ALL CHARACTERS
      
      *>     找出所有空白字元(前+字串內+後)
           MOVE 0 TO CharCount
           INSPECT xStr TALLYING CharCount FOR ALL SPACES
           DISPLAY "All Space Char Count = ", CharCount.
      
      *>     找出字首(LEADING)空白
           MOVE 0 TO CharCount
           INSPECT xStr TALLYING CharCount FOR LEADING SPACES
           DISPLAY "LEADING Space Char Count = ", CharCount.

      *>     找出字尾(trailing)空白
           MOVE 0 TO CharCount
           INSPECT xStr TALLYING CharCount FOR TRAILING SPACES
           DISPLAY "TRAILING Space Char Count = ", CharCount.

      *>     去除字尾(trailing)空白
           DISPLAY "(Before)'" xStr "'".
           COMPUTE StrLength = StrSize - CharCount.
           DISPLAY "(AFTER)'" xStr(1 : StrLength) "'".

      *>     去除字首(leading)空白
           DISPLAY "(Before)'" xStr "'".
           MOVE 0 to CharCount
           INSPECT xStr TALLYING CharCount FOR LEADING SPACES
           DISPLAY "(AFTER)'" xStr(CharCount + 1 : ) "'".
           DISPLAY "(AFTER)'" xStr(CharCount + 1 : StrSize ) "'".

      *>     找出特定字元位置(ex.找出特定字元,第1個出現位置)
           DISPLAY "Str=" xStr2.
           MOVE 1 to CharCount
           INSPECT xStr2 TALLYING CharCount FOR CHARACTERS
               BEFORE INITIAL "source"
           DISPLAY "POSITION : " , CharCount.
           
      *>     找出"fred"中, 第1個出現的字元及位置
           MOVE "fred" TO yStr
           MOVE 51 TO EndCount
           PERFORM VARYING CharPos FROM 1 BY 1 UNTIL CharPos > 4
               MOVE 1 TO CharCount
               INSPECT xStr TALLYING CharCount FOR CHARACTERS
                   BEFORE INITIAL yStr(CharPos:1)
               IF CharCount < EndCount
                  MOVE CharCount TO EndCount
               END-IF
           END-PERFORM.
           DISPLAY "FIRST OCCURRENCE IS IN CHAR POSITION,", EndCount
           DISPLAY "THE CHAR IS, " xStr(EndCount : 1)
           
           STOP RUN.
