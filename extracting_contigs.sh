#!/bin/bash

# Define the path to the folder containing your FASTA files
FASTA_FOLDER="/mnt/project/PLASTPATH/megahit_output/*"

# Path to the TSV file containing the names of unique contigs (qseqid)
CONTIGS_FILE="/mnt/project/PLASTPATH/plastpath/contig_names_amr_flank.tsv"

# Output file where the sequences will be pasted
OUTPUT_FASTA="/mnt/project/PLASTPATH/amr_contigs_with_flanks.fasta"

# Check if output file exists and remove if it does
[ -f "$OUTPUT_FASTA" ] && rm "$OUTPUT_FASTA"

# Loop through each qseqid in the TSV file
while read -r contig
do
  # Use awk to find the contig and capture until the next header
  awk -v contig="^>$contig$" '
    $0 ~ contig {printit = 1}
    $0 ~ /^>/ && $0 !~ contig {printit = 0}
    printit {print}
  ' "$FASTA_FOLDER"/*.fasta >> "$OUTPUT_FASTA"
done < "$CONTIGS_FILE"

echo "Contig extraction complete."