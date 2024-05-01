#!/bin/bash
#SBATCH --ntasks=16                                # Number of cores (CPU)
#SBATCH --nodes=1                                   # Number of nodes to use
#SBATCH --job-name=prokka                  # Job name 
#SBATCH --mem=128G                                  # Required RAM - Default memory per CPU is 3GB.
#SBATCH --partition=hugemem                         # Use smallmem for jobs < 10 GB RAM|Options: hugemen, smallmem, gpu
#SBATCH --mail-user=amulya.baral@nmbu.no            # Email when job is done.
#SBATCH --mail-type=ALL

#!/bin/bash

# Load the necessary Prokka module
module load prokka

# Set the directories for input and output
inputDir="/mnt/project/PLASTPATH/high_quality_bins"
outputDir="/mnt/project/PLASTPATH/prokka_output"

# Use find and xargs to process each .fa file
find "$inputDir" -name "*.fa" -print0 | xargs -0 -I {} bash -c '{
    baseName=$(basename "{}" .fa);
    specificOutputDir="'$outputDir'"/"$baseName";
    mkdir -p "$specificOutputDir";
    prokka --outdir "$specificOutputDir" --prefix "$baseName" --metagenome "{}";
}'

echo "Annotation completed for all contigs."

