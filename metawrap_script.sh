#!/bin/bash
#SBATCH --ntasks=32               # 1 core(CPU)
#SBATCH --nodes=1                # Use 1 node
#SBATCH --job-name=taxonomy   # sensible name for the job
#SBATCH --mem=90G                 # Default memory per CPU is 3GB.
#SBATCH --partition=gpu     # Use the smallmem-partition for jobs requiring < 10 GB RAM.
#SBATCH --mail-user=amulya.baral@nmbu.no # Email me when job is done.
#SBATCH --mail-type=ALL

# cd $SCRATCH/PLASTPATH
# conda activate plastpath_resistome
find "/mnt/project/PLASTPATH/Aug23/" -type f -name "*_1.fq.gz" > forward_reads.txt
# Iterate through the forward read files
for forward_read in $(cat forward_reads.txt); do
    reverse_read="${forward_read/_1/_2}"
    sample_name="$(basename "$forward_read" _1.fq.gz)"
    echo -e "Now processing \n Forward read: $forward_read \n Reverse read: $reverse_read \nSample name is $sample_name"
    metawrap assembly -1 $forward_read -2 $reverse_read -m 200 -t 96 --use-metaspades -o ASSEMBLY
     
    output folder
    