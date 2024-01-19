#!/bin/bash

# Set the main folder path
main_folder="/mnt/project/PLASTPATH/Aug23/"

# Find all fastq files in the main folder
fastq_files=($(find "/mnt/project/PLASTPATH/Aug23/" -type f -name "*.fq.gz"))

# Iterate through the fastq files
for file in "$fastq_files"; do
    # Check if the file ends with _01 or _02
    if [[ $file =~ *_1\.fq\.gz ]]; then
        forward_read="$file"
        reverse_read="${file/_1/_2}"
        
        # Your processing command here, using $forward_read and $reverse_read
        echo "Processing $forward_read and $reverse_read together"
        
        # Add your processing command here
        
    fi
done