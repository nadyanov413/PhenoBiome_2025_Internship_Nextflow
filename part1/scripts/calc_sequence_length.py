#!/usr/bin/env python
import sys
from Bio import SeqIO

def get_fasta_length(fasta_file):
    try:
        # Use SeqIO.read for files expected to have a single sequence
        record = SeqIO.read(fasta_file, "fasta")
        protein_id = record.id
        protein_length = len(record.seq)
        
        print(f"{protein_id},{protein_length}")
    except ValueError as e:
        sys.stderr.write(f"Error parsing FASTA file: {e}\n")
        sys.exit(1)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        sys.stderr.write("Usage: python get_sequence_length_biopython.py <fasta_file>\n")
        sys.exit(1)
    get_fasta_length(sys.argv[1])
