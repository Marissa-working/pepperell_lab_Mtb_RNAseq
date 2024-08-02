import pandas as pd
import re

def get_gene_length(filename):
    gene_length = {}
    with open(filename, 'r') as file:
        for line in file:
            parts = line.strip().split('\t')
            if len(parts) >= 9 and parts[2] == 'gene':
                # Extract gene name
                match = re.search(r'gene_name "([^"]+)"', parts[8])
                if match:
                    gene_name = match.group(1)
                else:
                    gene_name = 'unknown'
                
                # Calculate gene length
                try:
                    start = int(parts[3])
                    end = int(parts[4])
                    length = end - start
                except ValueError:
                    length = 'error'
                gene_length[gene_name] = length
    return gene_length

def read_HTSeqCount(filename):
    data = {}
    with open(filename, 'r') as file:
        for line in file:
            parts = line.strip().split()
            if len(parts) == 2:
                gene_name, counts = parts
                data[gene_name] = int(counts)
    return data

gene_length = get_gene_length('MtbNCBIH37Rv_ncRNAs_sORFs.gtf')
counts = read_HTSeqCount('5075_10_S1_HTSeqCounts.txt')

# Combine dictionaries
combined_data = {
    'Gene_name': list(gene_length.keys()),
    'Length': [gene_length.get(gene, None) for gene in gene_length.keys()],
    'Count': [counts.get(gene, None) for gene in gene_length.keys()]
}

# Create DataFrame
df = pd.DataFrame(combined_data)
df["RPK"] = df["Count"]/df["Length"]
scale_factor = df["RPK"].sum()/1000000
df["TPM"] = df["RPK"]/scale_factor
print(df)
