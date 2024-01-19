cd /mnt/SCRATCH/amulyab/PLASTPATH/fastp_output_new/
forward_reads=($(find "/mnt/project/PLASTPATH/Aug23/" -type f -name "*_1.fq.gz"))
# Iterate through the forward read files
for forward_read in $forward_reads; do
    # Construct the corresponding reverse read file
    reverse_read="${forward_read/_1/_2}"
    # Your processing command here, using $forward_read and $reverse_read
    echo "Processing $forward_read and $reverse_read together"
    fastp --in1 $forward_read --in2 $reverse_read -o $forward_read -O out.R2.fq.gz
 ;
done

