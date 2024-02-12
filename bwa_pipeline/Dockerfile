# Use an official Ubuntu image as the base OS
FROM ubuntu:20.04

# Update the package list and install necessary packages
RUN apt-get update && apt-get install -y wget gcc clang

RUN apt-get install -y \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    make \
    libncurses5-dev

# Install BWA
RUN mkdir /usr/bwa && \
    cd /usr/bwa && \
    wget https://github.com/lh3/bwa/releases/download/v0.7.17/bwa-0.7.17.tar.bz2 && \
    tar xvjf bwa-0.7.17.tar.bz2 && \
    cd bwa-0.7.17 && \
    make && \
    cp bwa /usr/local/bin

# install samtools 1.11
RUN wget https://github.com/samtools/samtools/releases/download/1.11/samtools-1.11.tar.bz2
RUN tar -xjf samtools-1.11.tar.bz2 -C /usr/local/bin/
RUN cd /usr/local/bin/samtools-1.11/ && ./configure
RUN cd /usr/local/bin/samtools-1.11/ && make
RUN cd /usr/local/bin/samtools-1.11/ && make install
ENV PATH="/usr/local/bin/samtools-1.11:${PATH}"
# Ensure the /usr/local/bin directory is in the PATH
ENV PATH="/usr/local/bin:${PATH}"