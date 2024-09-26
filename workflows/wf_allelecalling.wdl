version 1.0

import "../tasks/task_allelecalling.wdl" as allelecalling_task
import "wf_scheme_selection.wdl" as scheme_selection

workflow allelecalling_wf {
  meta {
    description: "A WDL wrapper around the allele caller software for PNI."
  }
  input {
    File assembly
    String samplename
    String scheme
  }
  call scheme_selection.scheme_selection {
    input:
      scheme = scheme
  }
  call allelecalling_task.allelecalling {
    input:
      assembly = assembly,
      samplename = samplename,
      blastdb_alleleinfo = scheme_selection.selected_blastdb_alleleinfo,
      blastdb_nhr = scheme_selection.selected_blastdb_nhr,
      blastdb_nin = scheme_selection.selected_blastdb_nin,
      blastdb_nsq = scheme_selection.selected_blastdb_nsq,
      loci = scheme_selection.selected_loci
  }
  output {
    String allelecalling_selected_scheme = scheme_selection.selected_scheme
    String allelecalling_selected_scheme_warning = scheme_selection.warning_message
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