module load FastQC
for sname in $(find "/mnt/project/PLASTPATH/Aug23/" -type f -name "V1*.fq.gz"); do fastqc --noextract -t 10 -o /mnt/SCRATCH/amulyab/PLASTPATH/fastp_output/ $sname ; done
