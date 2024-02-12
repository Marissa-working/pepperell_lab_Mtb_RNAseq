#!/bin/bash
# unzip the tar to extract fastq.gz files
tar -xzvf fastq_out.tar.gz
# Create index from the reference
bwa index MtbNCBIH37Rv.fa
# # Define index location and core name
# export REF=lambda_virus
# create output tar archive
mkdir bwa_out

# Iterate through the list of files
for file in *_R1_001.fastq.gz; do
    # Extract the sample name without the _R1_001.fastq.gz part
    sample=$(echo "$file" | sed 's/_R1_001.fastq.gz//')

    # Execute the bwa command
    bwa mem -M -t 8 MtbNCBIH37Rv.fa ${sample}_R1_001.fastq.gz ${sample}_R2_001.fastq.gz > ${sample}.sam
    mv ${sample}.sam bwa_out/
done
tar -czf bwa_out.tar.gz bwa_out/