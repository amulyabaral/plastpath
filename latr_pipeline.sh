#!/bin/bash
#SBATCH --ntasks=32                                 # Number of cores (CPU)
#SBATCH --nodes=1                                   # Number of nodes to use
#SBATCH --job-name=taxonomy                         # Job name 
#SBATCH --mem=100G                                   # Required RAM - Default memory per CPU is 3GB.
#SBATCH --partition=hugemem                         # Use smallmem for jobs < 10 GB RAM|Options: hugemen, smallmem, gpu
#SBATCH --mail-user=amulya.baral@nmbu.no            # Email when job is done.
#SBATCH --mail-type=ALL

cd /mnt/project/PLASTPATH/Aug23/
find "/mnt/project/PLASTPATH/Aug23/" -type f -name "*_1.fq.gz" > forward_reads.txt
# Iterate through the forward read files
for forward_read in $(cat forward_reads.txt); do
    reverse_read="${forward_read/_1/_2}"
    sample_name="$(basename "$forward_read" _1.fq.gz)"
    echo -e "Now processing \n Forward read: $forward_read \n Reverse read: $reverse_read \nSample name is $sample_name";
    bowtie2 -x /mnt/project/AntibiotiKU/databases/bowtie_db/GRCh38_noalt_as -p 32 -1 $forward_read -2 $reverse_read --un-conc $sample_name.host_removed.fq ;   
done

echo "

 ██▓    ▒█████  ▒█████  ██ ▄█▀    ▄▄▄    ▄▄▄█████▓   ▄▄▄█████▓██░ ██ ▄▄▄    ▄▄▄█████▓    ██▀███ ▓█████  ██████ ██▓ ██████▄▄▄█████▓▒█████  ███▄ ▄███▓█████     ▐██▌ 
▓██▒   ▒██▒  ██▒██▒  ██▒██▄█▒    ▒████▄  ▓  ██▒ ▓▒   ▓  ██▒ ▓▓██░ ██▒████▄  ▓  ██▒ ▓▒   ▓██ ▒ ██▓█   ▀▒██    ▒▓██▒██    ▒▓  ██▒ ▓▒██▒  ██▓██▒▀█▀ ██▓█   ▀     ▐██▌ 
▒██░   ▒██░  ██▒██░  ██▓███▄░    ▒██  ▀█▄▒ ▓██░ ▒░   ▒ ▓██░ ▒▒██▀▀██▒██  ▀█▄▒ ▓██░ ▒░   ▓██ ░▄█ ▒███  ░ ▓██▄  ▒██░ ▓██▄  ▒ ▓██░ ▒▒██░  ██▓██    ▓██▒███       ▐██▌ 
▒██░   ▒██   ██▒██   ██▓██ █▄    ░██▄▄▄▄█░ ▓██▓ ░    ░ ▓██▓ ░░▓█ ░██░██▄▄▄▄█░ ▓██▓ ░    ▒██▀▀█▄ ▒▓█  ▄  ▒   ██░██░ ▒   ██░ ▓██▓ ░▒██   ██▒██    ▒██▒▓█  ▄     ▓██▒ 
░██████░ ████▓▒░ ████▓▒▒██▒ █▄    ▓█   ▓██▒▒██▒ ░      ▒██▒ ░░▓█▒░██▓▓█   ▓██▒▒██▒ ░    ░██▓ ▒██░▒████▒██████▒░██▒██████▒▒ ▒██▒ ░░ ████▓▒▒██▒   ░██░▒████▒    ▒▄▄  
░ ▒░▓  ░ ▒░▒░▒░░ ▒░▒░▒░▒ ▒▒ ▓▒    ▒▒   ▓▒█░▒ ░░        ▒ ░░   ▒ ░░▒░▒▒▒   ▓▒█░▒ ░░      ░ ▒▓ ░▒▓░░ ▒░ ▒ ▒▓▒ ▒ ░▓ ▒ ▒▓▒ ▒ ░ ▒ ░░  ░ ▒░▒░▒░░ ▒░   ░  ░░ ▒░ ░    ░▀▀▒ 
░ ░ ▒  ░ ░ ▒ ▒░  ░ ▒ ▒░░ ░▒ ▒░     ▒   ▒▒ ░  ░           ░    ▒ ░▒░ ░ ▒   ▒▒ ░  ░         ░▒ ░ ▒░░ ░  ░ ░▒  ░ ░▒ ░ ░▒  ░ ░   ░     ░ ▒ ▒░░  ░      ░░ ░  ░    ░  ░ 
  ░ ░  ░ ░ ░ ▒ ░ ░ ░ ▒ ░ ░░ ░      ░   ▒   ░           ░      ░  ░░ ░ ░   ▒   ░           ░░   ░   ░  ░  ░  ░  ▒ ░  ░  ░   ░     ░ ░ ░ ▒ ░      ░     ░          ░ 
    ░  ░   ░ ░     ░ ░ ░  ░            ░  ░                   ░  ░  ░     ░  ░             ░       ░  ░     ░  ░       ░             ░ ░        ░     ░  ░    ░    
                                 
                                                                                                                                                      
        LATR - Look At That Resistome, a metagenomic resistome analysis pipeline 
        Dev. by Amulya Baral, 2023      "

#SET PARAMETERS as [Yes/No/Y/y/N/n]

dna_file_path="y"
output_path=""
read_qc=""
host_removal=""
taxonomy=""
assembly=""
kma=""
number_of_threads=""   #input the number of threads based on the sbatch script


# conda activate plastpath_resistome #conda activate doesnt work, need path permissions, might work after restart 

find "/mnt/project/PLASTPATH/Aug23/" -type f -name "*_1.fq.gz" > forward_reads.txt
# Iterate through the forward read files
for forward_read in $(cat forward_reads.txt); do
    reverse_read="${forward_read/_1/_2}"
    sample_name="$(basename "$forward_read" _1.fq.gz)"
    echo -e "Now processing \n Forward read: $forward_read \n Reverse read: $reverse_read \nSample name is $sample_name"
    
done

#set up indexes and databases

# Kraken module
function()
  #  kraken2 --threads 32 --gzip-compressed --db kraken2_database/kraken2_standard --paired $forward_read $reverse_read --output /mnt/SCRATCH/amulyab/PLASTPATH/kraken2_output/$sample_name.kraken_out.txt --report /mnt/SCRATCH/amulyab/PLASTPATH/kraken2_output/$sample_name.kraken_report.txt ;
#create functions for reading files 
#read, cd, 
#activate conda beforehand, maybe a label at the top


#need to document a lot of code, finalize the scripts also

