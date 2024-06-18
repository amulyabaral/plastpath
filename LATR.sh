#!/bin/bash
#SBATCH --ntasks=32                                 # Number of cores (CPU)
#SBATCH --nodes=1                                   # Number of nodes to use
#SBATCH --job-name=plastpath_final                  # Job name 
#SBATCH --mem=100G                                  # Required RAM - Default memory per CPU is 3GB.
#SBATCH --partition=hugemem                         # Use smallmem for jobs < 10 GB RAM|Options: hugemen, smallmem, gpu
#SBATCH --mail-user=amulya.baral@nmbu.no            # Email when job is done.
#SBATCH --mail-type=ALL

main_path= "/mnt/project/PLASTPATH/"
make_directories="" #yes or no

create_directories() {

    if [ ! -d "$main_path/host_removed/" ]; then
        mkdir "$main_path/host_removed/"
    fi

    if [ ! -d "$main_path/results" ]; then
        mkdir "$main_path/results"
    fi

    if [ ! -d "$main_path/results/kraken2_output" ]; then
        mkdir "$main_path/results/kraken2_output"
    fi
}

if [ "$make_directories" = "yes" ]; then
    echo "Please enter the main path:"
    create_directories "$main_path"
    echo "Directories created."
    elif [ "$answer" = "no" ]; then
    echo "Directories will not be created."
else
    echo "Invalid input on directory creation. Please answer 'yes' or 'no'."

fi

 > forward_reads.txt

#host_Removal
for forward_read in $(find $main_path -type f -name "*_1.fq.gz"); do
    reverse_read="${forward_read/_1/_2}"
    sample_name="$(basename "$forward_read" _1.fq.gz)"
    bowtie2 -x /mnt/project/AntibiotiKU/databases/bowtie_db/GRCh38_noalt_as -p 32 -1 $forward_read -2 $reverse_read --un-conc /mnt/project/PLASTPATH/host_removed/$sample_name.host_removed.fq ;   
done


#QC for host-removed
echo "running fastqc now .."
for sample in /mnt/project/PLASTPATH/host_removed/*.fq ; do
    fastqc --noextract -t 32 -o /mnt/SCRATCH/amulyab/PLASTPATH/fastp_output/ $sample ;
done

echo "running kraken2 now .."
for sample in /mnt/project/PLASTPATH/host_removed/*.fq ; do
    sample_name="$(basename $sample)"
    kraken2 $sample \
        --threads 32 \
        --db /mnt/project/AntibiotiKU/databases/k2_standard_20231009 \
        --output /mnt/project/PLASTPATH/results/kraken2_output/$sample_name.kraken_out.txt \
        --report /mnt/SCRATCH/amulyab/PLASTPATH/kraken2_output/$sample_name.kraken_report.txt ;
done


