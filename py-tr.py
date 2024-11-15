import os

def split_file(input_filename, size_k):
    base_name = os.path.splitext(input_filename)[0]  # 去掉文件扩展名
    with open(input_filename, 'r', encoding='utf-8') as infile:
        file_count = 1
        bytes_read = 0
        output_filename = f"{base_name}_{file_count}.txt"
        outfile = open(output_filename, 'w', encoding='utf-8')

        for line in infile:
            outfile.write(line)
            bytes_read += len(line.encode('utf-8'))
            if bytes_read >= size_k * 1024:
                outfile.close()
                file_count += 1
                output_filename = f"{base_name}_{file_count}.txt"
                outfile = open(output_filename, 'w', encoding='utf-8')
                bytes_read = 0

        outfile.close()
    print("Files are split successfully.")

size_k = int(input("Enter the size in K: "))
input_filename = input("Enter the filename: ")
split_file(input_filename, size_k)
