#!/bin/bash
#SBATCH --ntasks=64                                 # Number of cores (CPU)
#SBATCH --job-name=mapping_host                  # Job name 
#SBATCH --mem=200G                                  # Required RAM - Default memory per CPU is 3GB.
#SBATCH --partition=hugemem-avx2                         # Use smallmem for jobs < 10 GB RAM|Options: hugemen, smallmem, gpu
#SBATCH --mail-user=amulya.baral@nmbu.no            # Email when job is done.
#SBATCH --mail-type=ALL

gtdbtk classify_wf --genome_dir /mnt/project/PLASTPATH/high_quality_bins/ --out /mnt/project/PLASTPATH//gtdbtk_bins_output --cpus 64 --mash_db /mnt/project/PLASTPATH/microbe_gen/mash_db --extension fa