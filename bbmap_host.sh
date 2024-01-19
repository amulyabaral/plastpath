#!/bin/bash
#SBATCH --ntasks=32                                 # Number of cores (CPU)
#SBATCH --nodes=1                                   # Number of nodes to use
#SBATCH --job-name=mapping_host                  # Job name 
#SBATCH --mem=128G                                  # Required RAM - Default memory per CPU is 3GB.
#SBATCH --partition=hugemem-avx2                         # Use smallmem for jobs < 10 GB RAM|Options: hugemen, smallmem, gpu
#SBATCH --mail-user=amulya.baral@nmbu.no            # Email when job is done.
#SBATCH --mail-type=ALL

echo "now building bbmap index"
bbmap.sh ref=/mnt/project/PLASTPATH/bbmap_index/hg19_main_mask_ribo_animal_allplant_allfungus.fa.gz 
echo "finished building bbmap index"

for forward_read in $(find /mnt/project/PLASTPATH -type f -name "*_1.fq.gz"); do 
    reverse_read="${forward_read/_1/_2}" 
    sample_name="$(basename "$forward_read" _1.fq.gz)" 
    bbmap.sh -in=$forward_read \
    covstats=/mnt/project/PLASTPATH/bbmap_output/$sample_name.constats.txt \
    covhist=/mnt/project/PLASTPATH/bbmap_output/$sample_name.covhist.txt \
    basecov=/mnt/project/PLASTPATH/bbmap_output/$sample_name.basecov.txt \
    bincov=/mnt/project/PLASTPATH/bbmap_output/$sample_name.bincov.txt \
    outu=u/mnt/project/PLASTPATH/bbmap_output/$sample_name.1.fq ;   
done