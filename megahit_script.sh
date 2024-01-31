#!/bin/bash
#SBATCH --ntasks=64               
#SBATCH --job-name=assembly_plastpath   # sensible name for the job
#SBATCH --mem=200G                 # Default memory per CPU is 3GB.
#SBATCH --partition=hugemem-avx2     # Use the smallmem-partition for jobs requiring < 10 GB RAM.
#SBATCH --mail-user=amulya.baral@nmbu.no # Email me when job is done.
#SBATCH --mail-type=ALL



find "/mnt/project/PLASTPATH/Aug23/" -type f -name "*_1.fq.gz" > forward_reads.txt

for forward_read in $(cat forward_reads.txt); do
    reverse_read="${forward_read/_1/_2}"
    sample_name="$(basename "$forward_read" _1.fq.gz)"
    output_dir="/mnt/project/PLASTPATH/megahit_output/$sample_name"
    if [ -d "$output_dir" ]; then
        echo "Output directory $output_dir already exists, skipping..."
    else
        echo -e "Now processing \n Forward read: $forward_read \n Reverse read: $reverse_read \nSample name is $sample_name"
        megahit -1 $forward_read -2 $reverse_read -o $output_dir -t 128 --min-contig-len 1000
    fi
done