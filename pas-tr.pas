program TxtSplitter;
uses crt;
var
  inputFile, outputFile: TextFile;
  line: string;
  inputFileName, outputFileName, baseName: string;
  sizeInK, bytesRead, fileCount: integer;
begin
  Write('Enter the size in K: ');
  ReadLn(sizeInK);
  Write('Enter the filename: ');
  ReadLn(inputFileName);

  AssignFile(inputFile, inputFileName);
  Reset(inputFile);
  
  baseName := Copy(inputFileName, 1, Length(inputFileName) - 4);  { 去掉扩展名 }
  fileCount := 1;
  bytesRead := 0;
  outputFileName := baseName + '_' + IntToStr(fileCount) + '.txt';
  AssignFile(outputFile, outputFileName);
  Rewrite(outputFile);

  while not Eof(inputFile) do
  begin
    ReadLn(inputFile, line);
    WriteLn(outputFile, line);
    bytesRead := bytesRead + Length(line);
    if bytesRead >= sizeInK * 1024 then
    begin
      CloseFile(outputFile);
      Inc(fileCount);
      outputFileName := baseName + '_' + IntToStr(fileCount) + '.txt';
      AssignFile(outputFile, outputFileName);
      Rewrite(outputFile);
      bytesRead := 0;
    end;
  end;

  CloseFile(inputFile);
  CloseFile(outputFile);

  WriteLn('Files are split successfully.');
end.
