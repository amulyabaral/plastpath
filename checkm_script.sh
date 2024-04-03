#!/bin/bash
#SBATCH --job-name=metabat2_binning
#SBATCH --ntasks=64
#SBATCH --mem=200G
#SBATCH --partition=hugemem-avx2
#SBATCH --mail-user=amulya.baral@nmbu.no
#SBATCH --mail-type=ALL

BINS_DIR="/mnt/project/PLASTPATH/metabat_output/"
CHECKM_OUTPUT_DIR="/mnt/project/PLASTPATH/checkm_output/"

checkm lineage_wf -x fa -t 64 $BINS_DIR $CHECKM_OUTPUT_DIR