version 1.0

import "../tasks/task_allelecalling.wdl" as allelecalling_task

workflow allelecalling_wf {
  meta {
    description: "A WDL wrapper around the allele caller software for PNI."
  }
  input {
    File assembly
    String samplename
    File blastdb_tar
    File loci
  }
  call allelecalling_task.allelecalling {
    input:
      assembly = assembly,
      samplename = samplename,
      blastdb_tar = blastdb_tar,
      loci = loci
  }
  output {
    String allelecalling_docker = allelecalling.allelecalling_docker
    String allelecalling_analysis_date = allelecalling.allelecalling_analysis_date
    File allelecalling_output_json = allelecalling.allelecalling_output_json
    File allelecalling_stats = allelecalling.allelecalling_stats
    File allelecalling_allele_calls_bam = allelecalling.allelecalling_allele_calls_bam
    File allelecalling_allele_calls_xml = allelecalling.allelecalling_allele_calls_xml
    File allelecalling_allele_calls_json = allelecalling.allelecalling_allele_calls_json
    File allelecalling_standard_calls = allelecalling.allelecalling_standard_calls
    File allelecalling_csv_core_standard = allelecalling.allelecalling_csv_core_standard
    File allelecalling_csv_core_pcr = allelecalling.allelecalling_csv_core_pcr
    File allelecalling_csv_accessory_standard = allelecalling.allelecalling_csv_accessory_standard
    File allelecalling_csv_accessory_pcr = allelecalling.allelecalling_csv_accessory_pcr
    File allelecalling_log = allelecalling.allelecalling_log
  }
}