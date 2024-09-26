version 1.0

workflow schema_selection {
  meta {
    description: "Organizes all schema database defaults into a single location for easier maintanence"
  }
  input {
    String schema
    File? blastdb_alleleinfo
    File? blastdb_nhr
    File? blastdb_nin
    File? blastdb_nsq
    File? loci
  }

   Boolean is_schema_allowed = schema == "CAMPY" || schema == "CBOT" || schema == "CRONO" || schema == "LISTERIA" || schema == "SALM" || schema == "STEC" || schema == "VIBR"

  if (schema == "CAMPY") {
    File CAMPY_blastdb_alleleinfo = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CAMPY/alleleinfo.txt_0"
    File CAMPY_blastdb_nhr = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CAMPY/alleles_0.nhr"
    File CAMPY_blastdb_nin = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CAMPY/alleles_0.nin"
    File CAMPY_blastdb_nsq = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CAMPY/alleles_0.nsq"
    File CAMPY_loci = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CAMPY/loci.tsv"
  }

  if (schema == "CBOT") {
    File CBOT_blastdb_alleleinfo = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CBOT/alleleinfo.txt_0"
    File CBOT_blastdb_nhr = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CBOT/alleles_0.nhr"
    File CBOT_blastdb_nin = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CBOT/alleles_0.nin"
    File CBOT_blastdb_nsq = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CBOT/alleles_0.nsq"
    File CBOT_loci = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CBOT/loci.tsv"
  }

  if (schema == "CRONO") {
    File CRONO_blastdb_alleleinfo = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CRONO/alleleinfo.txt_0"
    File CRONO_blastdb_nhr = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CRONO/alleles_0.nhr"
    File CRONO_blastdb_nin = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CRONO/alleles_0.nin"
    File CRONO_blastdb_nsq = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CRONO/alleles_0.nsq"
    File CRONO_loci = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/CRONO/loci.tsv"
  }

  if (schema == "LISTERIA") {
    File LISTERIA_blastdb_alleleinfo = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/LISTERIA/alleleinfo.txt_0"
    File LISTERIA_blastdb_nhr = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/LISTERIA/alleles_0.nhr"
    File LISTERIA_blastdb_nin = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/LISTERIA/alleles_0.nin"
    File LISTERIA_blastdb_nsq = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/LISTERIA/alleles_0.nsq"
    File LISTERIA_loci = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/LISTERIA/loci.tsv"
  }

  if (schema == "SALM") {
    File SALM_blastdb_alleleinfo = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/SALM/alleleinfo.txt_0"
    File SALM_blastdb_nhr = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/SALM/alleles_0.nhr"
    File SALM_blastdb_nin = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/SALM/alleles_0.nin"
    File SALM_blastdb_nsq = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/SALM/alleles_0.nsq"
    File SALM_loci = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/SALM/loci.tsv"
  }

  if (schema == "STEC") {
    File STEC_blastdb_alleleinfo = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/STEC/alleleinfo.txt_0"
    File STEC_blastdb_nhr = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/STEC/alleles_0.nhr"
    File STEC_blastdb_nin = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/STEC/alleles_0.nin"
    File STEC_blastdb_nsq = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/STEC/alleles_0.nsq"
    File STEC_loci = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/STEC/loci.tsv"
  }

  if (schema == "VIBR") {
    File VIBR_blastdb_alleleinfo = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/VIBR/alleleinfo.txt_0"
    File VIBR_blastdb_nhr = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/VIBR/alleles_0.nhr"
    File VIBR_blastdb_nin = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/VIBR/alleles_0.nin"
    File VIBR_blastdb_nsq = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/VIBR/alleles_0.nsq"
    File VIBR_loci = "gs://theiagen-large-public-files-rp/cdc-pni/pn2.0-mlst-databases/db/VIBR/loci.tsv"
  }

  output {
    File selected_blastdb_alleleinfo = select_first([blastdb_alleleinfo, CAMPY_blastdb_alleleinfo, CBOT_blastdb_alleleinfo, CRONO_blastdb_alleleinfo, LISTERIA_blastdb_alleleinfo, SALM_blastdb_alleleinfo, STEC_blastdb_alleleinfo, VIBR_blastdb_alleleinfo, "gs://theiagen-large-public-files-rp/cdc-pni/empty_alleleinfo.txt_o"])
    File selected_blastdb_nhr = select_first([blastdb_nhr, CAMPY_blastdb_nhr, CBOT_blastdb_nhr, CRONO_blastdb_nhr, LISTERIA_blastdb_nhr, SALM_blastdb_nhr, STEC_blastdb_nhr, VIBR_blastdb_nhr, "gs://theiagen-large-public-files-rp/cdc-pni/empty.nhr"])
    File selected_blastdb_nin = select_first([blastdb_nin, CAMPY_blastdb_nin, CBOT_blastdb_nin, CRONO_blastdb_nin, LISTERIA_blastdb_nin, SALM_blastdb_nin, STEC_blastdb_nin, VIBR_blastdb_nin, "gs://theiagen-large-public-files-rp/cdc-pni/empty.nin"])
    File selected_blastdb_nsq = select_first([blastdb_nsq, CAMPY_blastdb_nsq, CBOT_blastdb_nsq, CRONO_blastdb_nsq, LISTERIA_blastdb_nsq, SALM_blastdb_nsq, STEC_blastdb_nsq, VIBR_blastdb_nsq, "gs://theiagen-large-public-files-rp/cdc-pni/empty.nsq"])
    File selected_loci = select_first([loci, CAMPY_loci, CBOT_loci, CRONO_loci, LISTERIA_loci, SALM_loci, STEC_loci, VIBR_loci, "gs://theiagen-large-public-files-rp/cdc-pni/empty_loci.tsv"])
    String selected_schema = schema
    String warning_message = if (is_schema_allowed) then "Schema is allowed." else "Warning: The input schema is not in the allowed options."
  }
}