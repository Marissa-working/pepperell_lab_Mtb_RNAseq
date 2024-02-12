#!/bin/bash
# unzip the tar to extract .sam files
tar -xzvf bwa_out.tar.gz

# create output tar archive
mkdir samtools_out_new

# Iterate through the list of files
for file in bwa_out/*.sam; do
    # Extract the sample name
    sample=$(echo "$file" | sed 's/\.sam//')  # Corrected sed command
    
    # Downstream tools
    # Use samtools to explore alignments
    
    # Samtools: convert SAM to BAM
    samtools view -bhSu ${file} -o samtools_out_new/${sample}.bam  
    
    # Samtools: sort
    sort -O bam -T samtools_out_new/${sample}.sort samtools_out_new/${sample}.bam 
done

# Create a tar archive of the samtools_out directory
tar -czf samtools_out_new.tar.gz samtools_out_new/