version 1.0

task allelecalling {
  input {
    File assembly
    String samplename
    String blast_kb_tar
    String blastdb_tar
    String loci
    String qckb_tar
    Float blast_similarity
    String docker = "us-docker.pkg.dev/general-theiagen/docker-private/ngs-pipeline-process-allele-calling:ver1.3"
    Boolean debug = false
    Int memory = 4
    Int disk_size = 100
  }
  command <<<
    date | tee DATE

    # Uncompress the blastdb files into a new folder
    echo "DEBUG: Uncompressing blastdb files..."
    mkdir blast_allele_db/
    tar -xzf ~{blastdb_tar} -C blast_allele_db/

    echo "DEBUG: Uncompressing blast_kb files..."
    mkdir blast_kb/
    tar -xzf ~{blast_kb_tar} -C blast_kb/
   
    echo "DEBUG: Uncompressing qckb files..."
    mkdir qckb/
    tar -xzf ~{qckb_tar} -C qckb/

    # Run the pipeline
    echo "DEBUG: Running allelecalling with the following command:"
    echo "DEBUG: nextflow run /pn2.0_wgmlst/AlleleCalling.nf -c /pn2.0_wgmlst/scicomp.config -profile local --blastdb blast_allele_db/ --loci ~{loci} --input_assemblies ~{assembly} --publish_dir ~{samplename} --blast_similarity ~{blast_similarity} --blast_kb blast_kb/ --qckb qc_kb/"
    if nextflow run /pn2.0_wgmlst/AlleleCalling.nf \
        -c /pn2.0_wgmlst/scicomp.config \
        -profile local \
        --blastdb blast_allele_db/ \
        --loci ~{loci} \
        --input_assemblies ~{assembly} \
        --publish_dir ~{samplename} \
        --blast_similarity ~{blast_similarity} \
        --blast_kb blast_kb/ \
        --qckb qc_kb/; then 

        # Everything finished, pack up the results
        if [[ "~{debug}" == "false" ]]; then
            # not in debug mode, clean up
            rm -rf .nextflow/ work/
        fi

        # rename output files
        if [[ -f "${samplename}/*/outputs.json" ]]; then
            mv "${samplename}/*/outputs.json" ~{samplename}_outputs.json
        fi
        if [[ -f "${samplename}/*/stats_calls.json.gz" ]]; then
            mv "${samplename}/*/stats_calls.json.gz" ~{samplename}_stats_calls.json.gz
        fi
        if [[ -f "${samplename}/*/stats_calls.json.gz" ]]; then
            mv "${samplename}/*/stats_calls.json.gz" ~{samplename}_stats_calls.json.gz
        fi
        if [[ -f "${samplename}/*/allele_calls.bam" ]]; then
            mv "${samplename}/*/allele_calls.bam" ~{samplename}_allele_calls.bam
        fi
        if [[ -f "${samplename}/*/allele_calls.xml.gz" ]]; then
            mv "${samplename}/*/allele_calls.xml.gz" ~{samplename}_allele_calls.xml.gz
        fi 
        if [[ -f "${samplename}/*/allele_calls.json.gz" ]]; then
            mv "${samplename}/*/allele_calls.json.gz" ~{samplename}_allele_calls.json.gz
        fi
        if [[ -f "${samplename}/*/calls_standard.json.gz" ]]; then
            mv "${samplename}/*/calls_standard.json.gz" ~{samplename}_calls_standard.json.gz
        fi
        if [[ -f "${samplename}/*/calls_core_standard.csv.gz" ]]; then
            mv "${samplename}/*/calls_core_standard.csv.gz" ~{samplename}_calls_core_standard.csv.gz
        fi
        if [[ -f "${samplename}/*/calls_core_pcr.csv.gz" ]]; then
            mv "${samplename}/*/calls_core_pcr.csv.gz" ~{samplename}_calls_core_pcr.csv.gz
        fi
        if [[ -f "${samplename}/*/calls_accessory_standard.csv.gz" ]]; then
            mv "${samplename}/*/calls_accessory_standard.csv.gz" ~{samplename}_calls_accessory_standard.csv.gz
        fi
        if [[ -f "${samplename}/*/calls_accessory_pcr.csv.gz" ]]; then
            mv "${samplename}/*/calls_accessory_pcr.csv.gz" ~{samplename}_calls_accessory_pcr.csv.gz
        fi
        if [[ -f "${samplename}/*/messages.log" ]]; then
            mv "${samplename}/*/logs/messages.log" ~{samplename}_messages.log
        fi
    
    else
        # Run failed
        exit 1
    fi
  >>>
  output {
    String allelecalling_docker = docker
    String allelecalling_analysis_date = read_string("DATE")
    File? allelecalling_output_json = "~{samplename}_outputs.json"
    File? allelecalling_stats = "~{samplename}_stats_calls.json.gz"
    File? allelecalling_allele_calls_bam = "~{samplename}_allele_calls.bam"
    File? allelecalling_allele_calls_xml = "~{samplename}_allele_calls.xml.gz"
    File? allelecalling_allele_calls_json = "~{samplename}_allele_calls.json.gz"
    File? allelecalling_standard_calls = "~{samplename}_calls_standard.json.gz"
    File? allelecalling_csv_core_standard = "~{samplename}_calls_core_standard.csv.gz"
    File? allelecalling_csv_core_pcr = "~{samplename}_calls_core_pcr.csv.gz"
    File? allelecalling_csv_accessory_standard = "~{samplename}_calls_accessory_standard.csv.gz"
    File? allelecalling_csv_accessory_pcr = "~{samplename}_calls_accessory_pcr.csv.gz"
    File? allelecalling_log = "~{samplename}_messages.log"
  }
  runtime {
    docker: "~{docker}"
    memory: "~{memory} GB"
    cpu: 1
    disks: "local-disk ~{disk_size} SSD"
    maxRetries: 0
    preemptible: 0
  }
}