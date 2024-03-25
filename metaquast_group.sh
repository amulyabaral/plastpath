#!/bin/bash

# Function to run QUAST on a group of samples
run_quast() {
    local group=("$@")
    local label_string=$(printf ",%s" "${group[@]}")
    label_string=${label_string:1}  # Remove leading comma

    local files=()
    for sample in "${group[@]}"; do
        files+=("/mnt/project/PLASTPATH/megahit_output/${sample}*/final.contigs.fa")
    done
    echo "now running ... "
    echo "/mnt/project/PLASTPATH/metaquast_output/${group[0]}_group"
    echo "$label_string"
    echo "${files[@]}"

    # Run QUAST for the group

    # /mnt/project/PLASTPATH/quast-5.2.0/metaquast.py \
     #   -o "/mnt/project/PLASTPATH/metaquast_output/${group[0]}_group" \
      #  --labels "$label_string" \
       # -t 128 \
        #"${files[@]}"
}

# Define sample groups
groups=(
    "V1 V2 V3 V4 V5 V6"
    "V7 V8 V9 V10 V11 V12"
    "R1 R2 R3 R4 R5 R6"
    "R7 R8 R9 R10 R11 R12"
    "R13 R14 R15 R16 R17 R18"
    "R19 R20 R21 R22 R23 R24"
    "Blank"
)

# Run QUAST for each group in parallel
for group in "${groups[@]}"; do
    run_quast $group &
done

# Wait for all background processes to complete
wait
