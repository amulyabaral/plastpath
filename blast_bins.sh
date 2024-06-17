#!/bin/bash
#SBATCH --ntasks=32
#SBATCH --job-name=plastpath
#SBATCH --mem=128G                                 # Required RAM - Default memory per CPU is 3GB.
#SBATCH --partition=hugemem-avx2                         # Use smallmem for jobs < 10 GB RAM|Options: hugemen, smallmem, gpu
#SBATCH --mail-user=amulya.baral@nmbu.no            # Email when job is done.
#SBATCH --mail-type=ALL


for bin_file in /mnt/project/PLASTPATH/high_quality_bins/*.fa; do
    bin_name=$(basename $bin_file .fa)
    blastn -query $bin_file -db /mnt/project/PLASTPATH/blast_db/card_blastn -outfmt '6 qseqid sseqid salltitles length pident evalue qlen slen qstart qend sstart send' -num_threads 32 -out /mnt/project/PLASTPATH/blast_output/blast_output_bins/${bin_name}_blast_output.txt ;
done