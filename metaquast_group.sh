#!/bin/bash
#SBATCH --ntasks=64              
#SBATCH --job-name=quast_plastpath   # sensible name for the job
#SBATCH --mem=245G                 # Default memory per CPU is 3GB.
#SBATCH --partition=gpu     # Use the smallmem-partition for jobs requiring < 10 GB RAM.
#SBATCH --mail-user=amulya.baral@nmbu.no # Email me when job is done.
#SBATCH --mail-type=ALL

# Function to run QUAST on a group of samples
run_quast() {
    local group=("$@")
    local label_string=$(printf ",%s" "${group[@]}")
    label_string=${label_string:1}  # Remove leading comma

    local files=()
    for sample in "${group[@]}"; do
        # Adjust the pattern to match exactly the sample name and not beyond
        # Assumes the naming convention includes an underscore or similar character after the sample name
        file_pattern="/mnt/project/PLASTPATH/megahit_output/${sample}_*/final.contigs.fa"
        if compgen -G "$file_pattern" > /dev/null; then
            matched_files=( $file_pattern )
            for file in "${matched_files[@]}"; do
                # Verify that the directory exactly matches the sample name followed by a non-alphanumeric character
                dir_name=$(basename $(dirname "$file"))
                if [[ "$dir_name" == ${sample}_* ]]; then
                    files+=("$file")
                fi
            done
        else
            echo "Warning: No files found for pattern $file_pattern"
        fi
    done

    if [ ${#files[@]} -eq 0 ]; then
        echo "Error: No contig files found for group ${group[0]}"
        return 1
    fi

    # Run QUAST for the group
    python /mnt/project/PLASTPATH/quast-5.2.0/metaquast.py \
        -o "/mnt/project/PLASTPATH/metaquast_output/${group[0]}_group" \
        --labels "$label_string" \
        -t 128 \
        "${files[@]}"
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
