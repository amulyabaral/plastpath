#!/bin/bash

# Define the directory to search for .kraken_report files
search_dir="/mnt/SCRATCH/amulyab/PLASTPATH/kraken2_output"

# Define the output file
output_file="/mnt/project/PLASTPATH/bact_count.txt"

# Empty the output file in case it already exists
> "$output_file"

# Find all .kraken_report files and process them
find "$search_dir" -name "*.kraken_report" | while read -r file; do
    # Extract the sample name from the file path
    sample_name=$(basename "$file" ".kraken_report")

    # Extract the bacteria read count
    # Assuming the bacteria read counts are always in the same column position (e.g., the second column)
    bacteria_reads=$(awk '$4=="D" && $5=="2" {print $2}' "$file")

    # Output the sample name and bacteria read count to the output file
    echo "$sample_name $bacteria_reads" >> "$output_file"
done

echo "Extraction complete, results are in $output_file."