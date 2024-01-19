#!/bin/bash
#SBATCH --ntasks=32                                 # Number of cores (CPU)
#SBATCH --nodes=1                                   # Number of nodes to use
#SBATCH --job-name=plastpath_host                  # Job name 
#SBATCH --mem=100G                                  # Required RAM - Default memory per CPU is 3GB.
#SBATCH --partition=hugemem                         # Use smallmem for jobs < 10 GB RAM|Options: hugemen, smallmem, gpu
#SBATCH --mail-user=amulya.baral@nmbu.no            # Email when job is done.
#SBATCH --mail-type=ALL

module load Bowtie2

for forward_read in $(find /mnt/project/PLASTPATH -type f -name "*_1.fq.gz"); do 
    reverse_read="${forward_read/_1/_2}" 
    sample_name="$(basename "$forward_read" _1.fq.gz)" 
    bowtie2 -x /mnt/project/AntibiotiKU/databases/bowtie_db/GRCh38_noalt_as -p 32 -1 $forward_read -2 $reverse_read --un-conc /mnt/project/PLASTPATH/host_removed/$sample_name.host_removed.fq ;   
done