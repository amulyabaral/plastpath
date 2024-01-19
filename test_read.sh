#!/bin/bash

# Set the main folder path
main_folder="/mnt/project/PLASTPATH/Aug23/"

forward_reads=($(find "/mnt/project/PLASTPATH/Aug23/" -type f -name "*_1.fq.gz"))
# Iterate through the forward read files
for forward_read in $forward_reads; do
    # Construct the corresponding reverse read file
    reverse_read="${forward_read/_1/_2}"
    # Your processing command here, using $forward_read and $reverse_read
    echo "Processing $forward_read and $reverse_read together"

    # Add your processing command here
done


# find "/mnt/project/PLASTPATH/Aug23/" -type f -name "*_1.fq.gz" > forward_reads.txt
# to sync 
# rsync -aPL PLASTPATH amulyab@filemanager.orion.nmbu.no:/mnt/SCRATCH/amulyab/


#
# rsync -aPL amulyab@filemanager.orion.nmbu.no:/mnt/project/PLASTPATH/Aug23/Readme.html ./