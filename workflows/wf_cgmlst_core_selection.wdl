version 1.0

workflow cgmlst_core_selection {
  meta {
    description: "Organizes all cgmlst_core database defaults into a single location for easier maintanence"
  }
  input {
    String scheme
    File? cgmlst_core_db
    Int? cgmlst_core_threshold
  }

   Boolean is_scheme_allowed = scheme == "CAMPY" || scheme == "CBOT" || scheme == "CRONO" || scheme == "LISTERIA" || scheme == "SALM" || scheme == "STEC" || scheme == "VIBR"

  if (scheme == "CAMPY") {
    File CAMPY_cgmlst_core_db = "gs://theiagen-large-public-files-rp/cdc-pni/allele_databases/Campylobacter_jejuni_atb_pn20_20250213.tsv.gz"
    Int CAMPY_cgmlst_core_threshold = 100
  }

  if (scheme == "CBOT") {
  }

  if (scheme == "CRONO") {
  }

  if (scheme == "LISTERIA") {"
  }

  if (scheme == "SALM") {
  }

  if (scheme == "STEC") {
  }

  if (scheme == "VIBR") {
  }

  output {
    File selected_cgmlst_core_db = select_first([cgmlst_core_db, CAMPY_cgmlst_core_db, CBOT_cgmlst_core_db, CRONO_cgmlst_core_db, LISTERIA_cgmlst_core_db, SALM_cgmlst_core_db, STEC_cgmlst_core_db, VIBR_cgmlst_core_db, "gs://theiagen-large-public-files-rp/cdc-pni/empty_loci.tsv"])
    Int selected_cgmlst_core_threshold = select_first([cgmlst_core_threshold, CAMPY_cgmlst_core_threshold, CBOT_cgmlst_core_threshold, CRONO_cgmlst_core_threshold, LISTERIA_cgmlst_core_threshold, SALM_cgmlst_core_threshold, STEC_cgmlst_core_threshold, VIBR_cgmlst_core_threshold, 100])
    String selected_scheme = scheme
    String warning_message = if (is_scheme_allowed) then "scheme is allowed." else "Warning: The input scheme is not in the allowed options."
  }
}