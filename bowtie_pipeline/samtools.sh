#!/bin/bash
# unzip the tar to extract .sam files
tar -xzvf bowtie_out.tar.gz

# Create index from the reference
bowtie2-build MtbNCBIH37Rv.fa lambda_virus

# Define index location and core name
export REF=lambda_virus

# create output tar archive
mkdir samtools_out

# Iterate through the list of files
for file in bowtie_out/*.sam; do
    # Extract the sample name
    sample=$(echo "$file" | sed 's/\.sam//')  # Corrected sed command
    
    # Downstream tools
    # Use samtools to explore alignments
    
    # Samtools: convert SAM to BAM
    samtools view -b ${file} -o samtools_out/${sample}.bam  # Use ${file} instead of ${sample}.sam
    
    # Samtools: sort
    samtools sort samtools_out/${sample}.bam -o samtools_out/${sample}.sorted.bam
done

# Create a tar archive of the samtools_out directory
tar -czf samtools_out.tar.gz samtools_out/