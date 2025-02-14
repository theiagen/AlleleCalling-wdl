version 1.0

task cgmlst_core {
  input {
    File allelecalling_csv_core_standard
    String samplename
    File selected_cgmlst_core_db
    String selected_scheme
    Int selected_cgmlst_core_threshold
    String docker = "us-docker.pkg.dev/general-theiagen/docker-private/theiapulse:0.0.1"
    Boolean debug = false
    Int memory = 16
    Int cpus = 4
    Int disk_size = 100
  }
  command <<<
    date | tee DATE

    cgmlst-query.py -r ~{selected_cgmlst_core_db} -q ~{allelecalling_csv_core_standard} -t ~{selected_cgmlst_core_threshold} -d ~{samplename}_core_cgmlst_distance.tsv -tree ~{samplename}_core_cgmlst_tree.nwk

  >>>
  output {
    String cgmlst_core_docker = docker
    String cgmlst_core_date = read_string("DATE")
    File cgmlst_core_tree = "~{samplename}_core_cgmlst_tree.nwk"
    File cgmlst_distance_matrix = "~{samplename}_core_cgmlst_distance.tsv" 
  }
  runtime {
    docker: "~{docker}"
    memory: "~{memory} GB"
    cpu: ~{cpus}
    disks: "local-disk ~{disk_size} SSD"
    maxRetries: 0
    preemptible: 0
  }
}
