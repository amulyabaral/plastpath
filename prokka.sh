#!/bin/bash
#SBATCH --ntasks=16                                # Number of cores (CPU)
#SBATCH --nodes=1                                   # Number of nodes to use
#SBATCH --job-name=prokka                  # Job name 
#SBATCH --mem=128G                                  # Required RAM - Default memory per CPU is 3GB.
#SBATCH --partition=hugemem                         # Use smallmem for jobs < 10 GB RAM|Options: hugemen, smallmem, gpu
#SBATCH --mail-user=amulya.baral@nmbu.no            # Email when job is done.
#SBATCH --mail-type=ALL

#!/bin/bash
# Load the Prokka module
module load prokka

# Define the input directory containing .fa files
input_directory="/mnt/project/PLASTPATH/high_quality_bins"

# Define the output base directory
output_base_directory="/mnt/project/PLASTPATH/prokka_output"

# Loop through each .fa file in the input directory
for contig_file in "${input_directory}"/*.fa; do
    # Extract the filename without the extension
    filename=$(basename -- "$contig_file" .fa)
    
    # Define the output directory for the current file
    output_directory="${output_base_directory}/${filename}"
    
    # Run Prokka annotation tool
    prokka --outdir "$output_directory" --prefix "$filename" --metagenome "$contig_file"
done
