#!/bin/bash
#SBATCH --ntasks=8               # core(CPU)
#SBATCH --nodes=1                # Use .. node
#SBATCH --job-name=bk_build   # sensible name for the job
#SBATCH --mem=800                # Default memory per CPU is 3GB.
#SBATCH --partition=hugemem     # Use the smallmem-partition for jobs requiring < 10 GB RAM.
#SBATCH --mail-user= # Email me when job is done.
#SBATCH --mail-type=ALL

# cd $SCRATCH/PLASTPATH
# conda activate plastpath_resistome
# kraken2-build --standard --threads 8 --db standard
bracken-build -d /mnt/SCRATCH/amulyab/PLASTPATH/kraken2_database/kraken2_standard -t 16