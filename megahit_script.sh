#!/bin/bash
#SBATCH --ntasks=32               # 1 core(CPU)
#SBATCH --nodes=1                # Use 1 node
#SBATCH --job-name=assembly_plastpath   # sensible name for the job
#SBATCH --mem=200G                 # Default memory per CPU is 3GB.
#SBATCH --partition=gpu     # Use the smallmem-partition for jobs requiring < 10 GB RAM.
#SBATCH --mail-user=amulya.baral@nmbu.no # Email me when job is done.
#SBATCH --mail-type=ALL


find "/mnt/project/PLASTPATH/Aug23/" -type f -name "*_1.fq.gz" > forward_reads.txt
# Iterate through the forward read files
for forward_read in $(cat forward_reads.txt); do
    reverse_read="${forward_read/_1/_2}"
    sample_name="$(basename "$forward_read" _1.fq.gz)"
    echo -e "Now processing \n Forward read: $forward_read \n Reverse read: $reverse_read \nSample name is $sample_name"
    megahit -1 $forward_read -2 $reverse_read -o /mnt/project/PLASTPATH/megahit_output/$sample_name -t 32 --min-contig-len 1000 \
    --k-list 29,49,69,109,129,149
done
