10 INPUT "Enter the size in K: ", size
20 INPUT "Enter the filename: ", filename$
30 OPEN filename$ FOR INPUT AS #1
40 count = 1
50 baseName$ = LEFT$(filename$, LEN(filename$) - 4) ' 去掉扩展名
60 OPEN baseName$ + "_" + STR$(count) + ".txt" FOR OUTPUT AS #2
70 bytes_read = 0
80 WHILE NOT EOF(1)
90     LINE INPUT #1, line$
100    bytes_read = bytes_read + LEN(line$)
110    PRINT #2, line$
120    IF bytes_read >= size * 1024 THEN
130        CLOSE #2
140        count = count + 1
150        OPEN baseName$ + "_" + STR$(count) + ".txt" FOR OUTPUT AS #2
160        bytes_read = 0
170 END IF
180 WEND
190 CLOSE #1, #2
200 PRINT "Files are split successfully."
