version 1.0

task clean_assembly {
  input {
    File assembly
    String output_filename = "cleaned_assembly.fasta"
    String docker = "us-docker.pkg.dev/general-theiagen/staphb/freyja:1.5.1-07_02_2024-01-27-2024-08-01"
    Int memory = 8
    Int disk_size = 50
  }
  
  command <<<
    set -e

    echo "DEBUG: Cleaning assembly fastas..."
    
    python3 <<CODE
    from Bio import SeqIO
    import sys

    def clean_header(header):
        return header.split()[0]

    def process_fasta(input_file, output_file):
        with open(output_file, 'w') as outfile:
            for record in SeqIO.parse(input_file, "fasta"):
                record.id = clean_header(record.id)
                record.description = ''
                SeqIO.write(record, outfile, "fasta")

    input_file = "~{assembly}"
    output_file = "~{output_filename}"

    process_fasta(input_file, output_file)
    print(f"Cleaned assembly saved as {output_file}")
    CODE
  >>>
  
  output {
    File cleaned_assembly = output_filename
  }
  
  runtime {
    docker: docker
    memory: "~{memory} GB"
    cpu: 1
    disks: "local-disk ~{disk_size} SSD"
    maxRetries: 2
    preemptible: 1
  }
}