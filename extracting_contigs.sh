#!/bin/bash

# Path to the contig_and_file text file
contig_file="/mnt/project/PLASTPATH/contig_and_file.txt"

# Read the contig_and_file text file line by line
while IFS= read -r line
do
  # Extract the qseqid (assuming it's the first column)
  qseqid=$(echo $line | cut -d ' ' -f 1)

  # Extract the FileName (assuming it's the second column)
  directory_name=$(echo $line | cut -d ' ' -f 2)

  # Construct the path to the FASTA file
  fasta_file_path="/mnt/project/PLASTPATH/megahit_output/$directory_name/final_contigs.fa"

  # Check if the file exists
  if [ -f "$fasta_file_path" ]; then
    # Use awk to search for the contig in the FASTA file
    awk -v seq=">$qseqid" 'BEGIN {RS = ">"} $1 == seq {print ">"$0}' "$fasta_file_path"
  else
    echo "File not found: $fasta_file_path"
  fi
done < "$contig_file"