#!/bin/bash
#SBATCH --ntasks=32                                 # Number of cores (CPU)
#SBATCH --job-name=blasting               # Job name 
#SBATCH --mem=128G                                 # Required RAM - Default memory per CPU is 3GB.
#SBATCH --partition=hugemem-avx2                         # Use smallmem for jobs < 10 GB RAM|Options: hugemen, smallmem, gpu
#SBATCH --mail-user=amulya.baral@nmbu.no            # Email when job is done.
#SBATCH --mail-type=ALL


for contig_file in /mnt/project/PLASTPATH/megahit_output/*/final.contigs.fa; do
    dir_name=$(basename $(dirname $contig_file))
    blastn -query $contig_file -db /mnt/project/PLASTPATH/blast_db/card_blastn --outfmt '6 qseqid sseqid salltitles length pident evalue qlen slen qstart qend sstart send' -num_threads 32 -out /mnt/project/PLASTPATH/blast_output/${dir_name}_blast_output.txt ;
done
    