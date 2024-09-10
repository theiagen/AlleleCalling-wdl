FROM us-docker.pkg.dev/general-theiagen/docker-private/ngs-pipeline-process-allele-calling:ver1.3

USER root
WORKDIR /

# Metadata for versioning purposes
ARG PN2_0_WGMLST_COMMIT="4274fc2c5d98c0290a72902a813912929d952c16"
ARG PN2_0_WGMLST_SRC_URL=https://github.com/ncezid-biome/pn2.0_wgmlst/archive/${PN2_0_WGMLST_COMMIT}.zip

# Metadata labels
LABEL base.image="condaforge/miniforge3:23.3.1-1"
LABEL dockerfile.version="1"
LABEL software="AlleleCalling-wdl"
LABEL software.version=${PN2_0_WGMLST_COMMIT}
LABEL description="A WDL wrapper of ncezid-biome/pn2.0_wgmlst for Terra.bio"
LABEL website="https://github.com/ncezid-biome/pn2.0_wgmlst"
LABEL maintainer1="Inês Mendes"
LABEL maintainer.email1="ines.mendes@theiagen.com"

# Install dependencies; cleanup apt garbage
RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  ca-certificates \
  procps \
  libtiff5 \
  unzip \
  bsdmainutils \
  gcc && \
  apt-get autoclean && \
  rm -rf /var/lib/apt/lists/*

RUN mamba install -y --name base -c conda-forge -c bioconda -c defaults \
  'bioconda::nextflow==22.10.6' && \
  mamba clean -a -y

COPY pn2.0_wgmlst/ /pn2.0_wgmlst

# set the environment, add base conda/micromamba bin directory into path
# set locale settings to UTF-8
# set the environment, put new conda env in PATH by default
ENV PATH="/opt/conda/bin:${PATH}" \
  LC_ALL=C.UTF-8

# replace the config file with the correct one
COPY scicomp.config /pn2.0_wgmlst/scicomp.config

# set final working directory to /data
WORKDIR /data