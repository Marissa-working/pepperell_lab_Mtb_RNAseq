import argparse
import os

def process_file(input_file, temp_file):
    with open(input_file, 'r') as file:
        lines = file.readlines()
    
    processed_lines = []
    
    # Process each line
    for line in lines:
        # Remove leading '*' from the first character of the line
        if line.startswith('*'):
            line = line[1:]
        
        # Remove lines that start with '__'
        if not line.startswith('__'):
            # Replace spaces with underscores in gene names
            parts = line.strip().split('\t')
            if len(parts) == 2:
                gene_name, count = parts
                gene_name = gene_name.replace(' ', '_')
                processed_lines.append(f"{gene_name}\t{count}")
            elif len(parts) == 3:
                gene_name1, gene_name2, count = parts
                gene_name = gene_name1 + "_" + gene_name2
                processed_lines.append(f"{gene_name}\t{count}")
            else:
                # Handle lines that should not be processed (e.g., invalid format)
                print(f"Skipping line(cannot format): {line.strip()}")
    
    with open(temp_file, 'w') as file:
        for line in processed_lines:
            file.write(line + '\n')

def main():
    parser = argparse.ArgumentParser(description='Process a text file.')
    parser.add_argument('input_file', type=str, help='The input file to process')
    parser.add_argument('output_file', type=str, help='The output file to write')

    args = parser.parse_args()
    
    # Use a temporary file to avoid overwriting input file while processing
    temp_file = 'tempfile.txt'

    process_file(args.input_file, temp_file)
    
    # Replace input file with the processed temporary file
    os.replace(temp_file, args.output_file)

if __name__ == '__main__':
    main()

