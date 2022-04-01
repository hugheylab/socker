#!/bin/bash
set -e

wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/3.0.0/sratoolkit.3.0.0-ubuntu64.tar.gz
tar -zxvf sratoolkit.3.0.0-ubuntu64.tar.gz
mv sratoolkit.3.0.0-ubuntu64 sratoolkit
echo 'export PATH="${PATH}:${HOME}/sratoolkit/bin"' >> ~/.bashrc
echo 'export PATH="${PATH}:${HOME}/sratoolkit/bin"' >> ~/.profile
echo 'Sys.setenv(PATH = paste(Sys.getenv("PATH"), path.expand("~/sratoolkit/bin"), sep = ":"))' >> ~/.Rprofile
rm sratoolkit*.tar.gz

mkdir -p ${HOME}/.ncbi
printf '/LIBS/IMAGE_GUID = "%s"\n' `uuidgen` > ${HOME}/.ncbi/user-settings.mkfg
printf '/libs/cloud/report_instance_identity = "true"\n' >> ${HOME}/.ncbi/user-settings.mkfg

source ~/miniconda3/etc/profile.d/conda.sh
conda activate
mamba install fastq-screen fastqc multiqc pigz refgenie salmon trim-galore

mkdir -p ~/genomes
refgenie init -c ~/genomes/genome_config.yaml
echo 'export REFGENIE="${HOME}/genomes/genome_config.yaml"' >> ~/.bashrc
echo 'export REFGENIE="${HOME}/genomes/genome_config.yaml"' >> ~/.profile

Rscript -e "if (!requireNamespace('BiocManager', quietly = TRUE)) install.packages('BiocManager')"
Rscript -e "BiocManager::install('seeker', site_repository = 'https://hugheylab.github.io/drat/', update = FALSE, ask = FALSE)"
Rscript -e "BiocManager::install('preprocessCore', configure.args = '--disable-threading', force = TRUE)" # https://support.bioconductor.org/p/122925/
Rscript -e "install.packages('doParallel')"
Rscript -e "library('seeker')" # force error if install failed
Rscript -e "library('doParallel')"
rm -rf /tmp/downloaded_packages
