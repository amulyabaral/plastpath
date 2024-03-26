#!/bin/bash
#SBATCH --ntasks=64
#SBATCH --job-name=bam_gen
#SBATCH --mem=240G
#SBATCH --partition=gpu
#SBATCH --mail-user=amulya.baral@nmbu.no
#SBATCH --mail-type=ALL

module load Bowtie2

# Directory where the assembly files are stored, as used in the QUAST script
ASSEMBLY_DIR="/mnt/project/PLASTPATH/megahit_output/"

# Directory to store the BAM files
OUTPUT_DIR="/mnt/project/PLASTPATH/bam_files/"

# Ensure this directory exists or create it
mkdir -p $OUTPUT_DIR

# Find forward reads
find "/mnt/project/PLASTPATH/Aug23/" -type f -name "*_1.fq.gz" > forward_reads.txt

# Loop through the forward reads, find corresponding assemblies, index them, and generate BAM files
while IFS= read -r forward_read; do
    reverse_read="${forward_read/_1/_2}"
    sample_name="$(basename "$forward_read" _1.fq.gz)"
    bam_output="${OUTPUT_DIR}${sample_name}_sorted.bam"
    
    # Check if BAM file already exists to avoid re-processing
    if [ -f "$bam_output" ]; then
        echo "BAM file $bam_output already exists, skipping..."
        continue
    fi
    
    echo -e "Now processing: \nForward read: $forward_read \nReverse read: $reverse_read \nSample name: $sample_name"

    # Locate assembly file for the sample, using a pattern similar to the QUAST script
    assembly_file="${ASSEMBLY_DIR}${sample_name}/final.contigs.fa"

    if [ ! -f "$assembly_file" ]; then
        echo "Assembly file $assembly_file not found for sample $sample_name."
        continue
    fi

    # Index the assembly file for the sample
    bowtie2-build $assembly_file ${OUTPUT_DIR}${sample_name}_index --threads 128

    # Align reads to the assembly and convert to BAM
    bowtie2 -x ${OUTPUT_DIR}${sample_name}_index -1 $forward_read -2 $reverse_read -S ${OUTPUT_DIR}${sample_name}.sam --threads 128
    samtools view -bS ${OUTPUT_DIR}${sample_name}.sam > ${OUTPUT_DIR}${sample_name}.bam
    rm ${OUTPUT_DIR}${sample_name}.sam  # Remove intermediate SAM file

    # Sort and index the BAM file
    samtools sort ${OUTPUT_DIR}${sample_name}.bam -o $bam_output --threads 128
    samtools index $bam_output
done < forward_reads.txt
