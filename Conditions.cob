       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONDITIONS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  Char PIC X.
           88 Vowel VALUE "a", "e", "i", "o", "u".
           88 Consonant VALUE "b", "c", "d", "f", "g", "h",
                               "j" THRU "n", "p" THRU "t",
                               "v" THRU "z".
           88 Digit VALUE "0" THRU "9".
           88 ValidCharacter VALUE "a" THRU "z", "0" THRU "9".
       
       PROCEDURE DIVISION.
       Begin.
           DISPLAY "Enter lower case character or digit. No Data ends.".
           ACCEPT Char.
           PERFORM UNTIL NOT ValidCharacter
               EVALUATE TRUE
                   WHEN Vowel Display "The letter '" Char "' is a vowel."
                   WHEN Consonant DISPLAY "The letter '" Char "' is a consonant."
                   WHEN Digit DISPLAY "The letter '" Char "' is a digit."
                   WHEN OTHER
                      DISPLAY "No Match, Problems Found."
               END-EVALUATE
           END-PERFORM.
           STOP RUN.
       