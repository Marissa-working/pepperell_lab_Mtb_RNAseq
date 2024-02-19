# Mtb_RNAseq
Pipeline of data <br>
fastqc => bwa/bowtie => samtools
## Bowtie Pipeline
* All the files are in the bowtie_pipeline folder.
* Using the docker image jysgro/bowtie2:sam115_bcf118
* Using CHTC staging area (feel free to change it to local in bowtie.sub, samtools.sub)
* Need a .fa file as reference file for all steps
* The fastqc output is stored in fastq_out.tar.gz. (Should be passed into the bowtie)
* The bowtie output is stored in bowtie_out.tar.gz. (Should be passed into the samtools)
* The samtools output is stored in samtools_out.tar.gz. (Include the .sorted.bam files)
## Bwa Pipeline
* All the files are in the bwa_pipeline folder.
* Using the docker image marissazhang/mtb_rnaseq:1.0 (Can be built from the Dockerfile given)
* Using CHTC staging area (feel free to change it to local in bwa.sub, samtools.sub)
* Need a .fa file as reference file for all steps
* The fastqc output is stored in fastq_out.tar.gz. (Should be passed into the bwa)
* The bowtie output is stored in bwa_out.tar.gz. (Should be passed into the samtools)
* The samtools output is stored in samtools_out_new.tar.gz. (Include the .sorted.bam files)
