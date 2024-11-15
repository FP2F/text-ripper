#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    char inputFileName[100], outputFileName[100], line[1024], baseName[100];
    FILE *inputFile, *outputFile;
    int sizeInK, bytesRead = 0, fileCount = 1;

    printf("Enter the size in K: ");
    scanf("%d", &sizeInK);
    printf("Enter the filename: ");
    scanf("%s", inputFileName);

    inputFile = fopen(inputFileName, "r");
    if (inputFile == NULL) {
        printf("Error opening file!\n");
        return 1;
    }

    // 获取文件名的基础部分（去掉扩展名）
    strcpy(baseName, inputFileName);
    baseName[strlen(baseName) - 4] = '\0';  // 去掉最后4个字符（扩展名）

    sprintf(outputFileName, "%s_%d.txt", baseName, fileCount);
    outputFile = fopen(outputFileName, "w");

    while (fgets(line, sizeof(line), inputFile) != NULL) {
        fputs(line, outputFile);
        bytesRead += strlen(line);
        if (bytesRead >= sizeInK * 1024) {
            fclose(outputFile);
            fileCount++;
            sprintf(outputFileName, "%s_%d.txt", baseName, fileCount);
            outputFile = fopen(outputFileName, "w");
            bytesRead = 0;
        }
    }

    fclose(inputFile);
    fclose(outputFile);
    printf("Files are split successfully.\n");
    return 0;
}
