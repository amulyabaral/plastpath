#!/bin/bash
#SBATCH --ntasks=32               # 1 core(CPU)
#SBATCH --job-name=taxonomy   # sensible name for the job
#SBATCH --mem=128G                 # Default memory per CPU is 3GB.
#SBATCH --partition=hugemem-avx2     # Use the smallmem-partition for jobs requiring < 10 GB RAM.
#SBATCH --mail-user=amulya.baral@nmbu.no # Email me when job is done.
#SBATCH --mail-type=ALL

 kraken2 --threads 64 --db /mnt/SCRATCH/amulyab/PLASTPATH/k2_standard_20231009 --output /mnt/project/PLASTPATH/kraken2_output/contigs_flank.kraken_out.txt --report /mnt/project/PLASTPATH/kraken2_output/contigs_flank.kraken_report.txt --use-names /mnt/project/PLASTPATH/plastpath/extracted_contigs_with_flanks.fa
