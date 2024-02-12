#!/bin/bash
# unzip the tar to extract fastq.gz files
tar -xzvf fastq_out.tar.gz
# Create index from the reference
bowtie2-build MtbNCBIH37Rv.fa lambda_virus
# Define index location and core name
export REF=lambda_virus
# create output tar archive
mkdir bowtie_out

# Iterate through the list of files
for file in *_R1_001.fastq.gz; do
    # Extract the sample name without the _R1_001.fastq.gz part
    sample=$(echo "$file" | sed 's/_R1_001.fastq.gz//')

    # Execute the Bowtie command
    # echo "Running Bowtie for sample: $sample"
    bowtie2 -p 8 -x $REF -1 ${sample}_R1_001.fastq.gz -2 ${sample}_R2_001.fastq.gz -S ${sample}.sam
    mv ${sample}.sam bowtie_out/
done
tar -czf bowtie_out.tar.gz bowtie_out/