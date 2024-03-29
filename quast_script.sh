#!/bin/bash
#SBATCH --ntasks=64              
#SBATCH --job-name=quast_plastpath   # sensible name for the job
#SBATCH --mem=200G                 # Default memory per CPU is 3GB.
#SBATCH --partition=gpu     # Use the smallmem-partition for jobs requiring < 10 GB RAM.
#SBATCH --mail-user=amulya.baral@nmbu.no # Email me when job is done.
#SBATCH --mail-type=ALL

#labels=$(find /mnt/project/PLASTPATH/megahit_output/*/final.contigs.fa -exec dirname {} \; | xargs -I{} basename {} | tr '\n' ',')
#labels="${labels%,}"
# /mnt/project/PLASTPATH/quast-5.2.0/metaquast.py -o /mnt/project/PLASTPATH/metaquast_output --labels "$labels" -t 128 $(find /mnt/project/PLASTPATH/megahit_output/*/final.contigs.fa | sed 's/,/, /g')


contigs_files=($(find /mnt/project/PLASTPATH/megahit_output/*/final.contigs.fa))

for contigs_file in "${contigs_files[@]}"; do
    label=$(basename $(dirname $contigs_file))
    /mnt/project/PLASTPATH/quast-5.2.0/metaquast.py \
        -o "/mnt/project/PLASTPATH/metaquast_output/$label" \
        --labels "$label" \
        -t 128 \
        $contigs_file
done

