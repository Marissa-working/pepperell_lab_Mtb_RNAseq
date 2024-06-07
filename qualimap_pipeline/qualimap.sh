#!/bin/bash

# Unzip the tar file to extract .bam files
tar -xzvf testsamtools.tar.gz

# Find the extracted BAM file (assuming there's only one .bam file in the tar.gz)
BAM_FILE=$(find . -name "*.bam" -print -quit)

if [ -z "$BAM_FILE" ]; then
  echo "Error: No BAM file found in the extracted archive!"
  exit 1
fi

# Get the base name of the BAM file (without the directory and extension)
BAM_BASENAME=$(basename "$BAM_FILE" .bam)

# Set the GTF file path (hardcoded in this case)
GTF_FILE="MtbNCBIH37Rv.gtf"

# Check if the GTF file exists
if [ ! -f "$GTF_FILE" ]; then
  echo "Error: GTF file '$GTF_FILE' not found!"
  exit 1
fi

# Create output directories for Qualimap (if not already existing)
mkdir -p "${BAM_BASENAME}_bamqc"
mkdir -p "${BAM_BASENAME}_rnaseq"

# Run Qualimap bamqc
qualimap bamqc -bam "$BAM_FILE" -outdir "${BAM_BASENAME}_bamqc" --java-mem-size=2G

# Run Qualimap rnaseq
qualimap rnaseq -bam "$BAM_FILE" -outdir "${BAM_BASENAME}_rnaseq" -pe -gtf "$GTF_FILE" --java-mem-size=2G

# Create a tar.gz archive of the Qualimap output directories
tar -zcvf "qualimap_out.tar.gz" "${BAM_BASENAME}_bamqc/" "${BAM_BASENAME}_rnaseq/"