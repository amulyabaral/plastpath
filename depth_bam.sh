#!/bin/bash
#SBATCH --job-name=depth_calculation
#SBATCH --ntasks=16
#SBATCH --mem=80G
#SBATCH --partition=smallmem
#SBATCH --mail-user=amulya.baral@nmbu.no
#SBATCH --mail-type=ALL

cd /mnt/project/PLASTPATH/bam_files/
for bam_file in *_sorted.bam; do
    jgi_summarize_bam_contig_depths --outputDepth "${bam_file%.bam}_depth.txt" $bam_file
done
