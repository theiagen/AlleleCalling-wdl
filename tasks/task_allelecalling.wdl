version 1.0

task allelecalling {
  input {
    File assembly
    String samplename
    File blastdb_tar
    File loci
    Int blast_similarity = 75
    String docker = "us-docker.pkg.dev/general-theiagen/pni-docker-repo/allelecalling:4274fc"
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

    echo "DEBUG: Detecting if assembly file is compressed..."
    mkdir input_assembly/
    if [[ ! ~{assembly} == *.gz ]]; then
        echo "DEBUG: Assembly file is not compressed, compressing..."
        filename=$(basename ~{assembly})
        gzip -c ~{assembly} > input_assembly/${filename%.*}.fasta.gz
    else
        echo "DEBUG: Moving assembly file into input folder..."
        cp ~{assembly} input_assembly/
    fi


    # Run the pipeline
    echo "DEBUG: Running allelecalling with the following command:"
    echo "DEBUG: nextflow run /pn2.0_wgmlst/AlleleCalling.nf -c /pn2.0_wgmlst/scicomp.config -profile local --blastdb blast_allele_db/ --loci ~{loci} --input_assemblies input_assembly/ --publish_dir ~{samplename} --blast_similarity ~{blast_similarity} --blast_kb pn2.0_wgmlst/knowledge_bases/blast_kb/ --qckb /pn2.0_wgmlst/knowledge_bases/qc_kb"
    if nextflow run /pn2.0_wgmlst/AlleleCalling.nf \
        -c /pn2.0_wgmlst/scicomp.config \
        -profile local \
        --blastdb $PWD/blast_allele_db/ \
        --loci ~{loci} \
        --input_assemblies input_assembly/ \
        --publish_dir ~{samplename} \
        --blast_similarity ~{blast_similarity} \
        --blast_kb /pn2.0_wgmlst/knowledge_bases/blast_kb/ \
        --qckb /pn2.0_wgmlst/knowledge_bases/qc_kb ; then 

        # Everything finished, pack up the results
        if [[ "~{debug}" == "false" ]]; then
            # not in debug mode, clean up
            rm -rf .nextflow/ work/
        fi

        # rename output files
        echo "DEBUG: Renaming output files..."
        mv ~{samplename}/*/outputs.json ~{samplename}_outputs.json
        mv ~{samplename}/*/stats_calls.json.gz ~{samplename}_stats_calls.json.gz
        mv ~{samplename}/*/stats_calls.json.gz ~{samplename}_stats_calls.json.gz
        mv ~{samplename}/*/allele_calls.bam ~{samplename}_allele_calls.bam
        mv ~{samplename}/*/allele_calls.xml.gz ~{samplename}_allele_calls.xml.gz
        mv ~{samplename}/*/allele_calls.json.gz ~{samplename}_allele_calls.json.gz
        mv ~{samplename}/*/calls_standard.json.gz ~{samplename}_calls_standard.json.gz
        mv ~{samplename}/*/calls_core_standard.csv.gz ~{samplename}_calls_core_standard.csv.gz
        mv ~{samplename}/*/calls_core_pcr.csv.gz ~{samplename}_calls_core_pcr.csv.gz
        mv ~{samplename}/*/calls_accessory_standard.csv.gz ~{samplename}_calls_accessory_standard.csv.gz
        mv ~{samplename}/*/calls_accessory_pcr.csv.gz ~{samplename}_calls_accessory_pcr.csv.gz
        mv ~{samplename}/*/logs/messages.log ~{samplename}_messages.log
    
    else
        # Run failed
        exit 1
    fi
  >>>
  output {
    String allelecalling_docker = docker
    String allelecalling_analysis_date = read_string("DATE")
    File allelecalling_output_json = "~{samplename}_outputs.json"
    File allelecalling_stats = "~{samplename}_stats_calls.json.gz"
    File allelecalling_allele_calls_bam = "~{samplename}_allele_calls.bam"
    File allelecalling_allele_calls_xml = "~{samplename}_allele_calls.xml.gz"
    File allelecalling_allele_calls_json = "~{samplename}_allele_calls.json.gz"
    File allelecalling_standard_calls = "~{samplename}_calls_standard.json.gz"
    File allelecalling_csv_core_standard = "~{samplename}_calls_core_standard.csv.gz"
    File allelecalling_csv_core_pcr = "~{samplename}_calls_core_pcr.csv.gz"
    File allelecalling_csv_accessory_standard = "~{samplename}_calls_accessory_standard.csv.gz"
    File allelecalling_csv_accessory_pcr = "~{samplename}_calls_accessory_pcr.csv.gz"
    File allelecalling_log = "~{samplename}_messages.log"
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