#!/bin/bash
#SBATCH --job-name=metabat2_binning
#SBATCH --ntasks=64
#SBATCH --mem=200G
#SBATCH --partition=hugemem-avx2
#SBATCH --mail-user=amulya.baral@nmbu.no
#SBATCH --mail-type=ALL

CONTIGS_DIR="/mnt/project/PLASTPATH/megahit_output/"
DEPTH_DIR="/mnt/project/PLASTPATH/bam_files/"
OUTPUT_BASE="/mnt/project/PLASTPATH/metabat_output/"

# Ensure the output directory exists
mkdir -p $OUTPUT_BASE

# Iterate over each sample's contig file and corresponding depth file
for contig_dir in $CONTIGS_DIR*; do
    if [ -d "$contig_dir" ]; then
        sample_name=$(basename $contig_dir)
        contigs_file="${contig_dir}/final.contigs.fa"
        depth_file="${DEPTH_DIR}${sample_name}_depth.txt"
        
        if [ -f "$contigs_file" ] && [ -f "$depth_file" ]; then
            output_path="${OUTPUT_BASE}${sample_name}"
            echo "Running MetaBat2 for sample $sample_name"
            metabat2 -i $contigs_file -a $depth_file -o $output_path -m 1500
        else
            echo "Missing contigs or depth file for sample $sample_name"
        fi
    fi
done
