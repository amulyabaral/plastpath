#!/bin/bash
#SBATCH --ntasks=16                                # Number of cores (CPU)
#SBATCH --nodes=1                                   # Number of nodes to use
#SBATCH --job-name=prokka                  # Job name 
#SBATCH --mem=128G                                  # Required RAM - Default memory per CPU is 3GB.
#SBATCH --partition=hugemem                         # Use smallmem for jobs < 10 GB RAM|Options: hugemen, smallmem, gpu
#SBATCH --mail-user=amulya.baral@nmbu.no            # Email when job is done.
#SBATCH --mail-type=ALL

module load prokka

for contig_file in /mnt/project/PLASTPATH/high_quality_bins/*.fa ; 
    do filename=$(basename -- "$contig_file" .fa); 
    prokka --outdir /mnt/project/PLASTPATH/prokka_output/$filename --prefix $filename --metagenome $contig_file ;
done



