# Use a lightweight base image
FROM python:3.9-slim

# Set environment variables to prevent interactive prompts and to ensure pip is in non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive PIP_NO_CACHE_DIR=1

# Update and install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

# Install gtftools
RUN pip3 install numpy, gtftools

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Run a command (replace with your own)
CMD ["python3", "-c", "print('Python and gtftools are installed.')"]
