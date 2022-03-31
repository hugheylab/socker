#!/bin/bash
set -e

Rscript -e "if (!requireNamespace('BiocManager', quietly = TRUE)) install.packages('BiocManager')"
Rscript -e "BiocManager::install('seeker', site_repository = 'https://hugheylab.github.io/drat/', update = FALSE, ask = FALSE)"
Rscript -e "BiocManager::install('preprocessCore', configure.args = '--disable-threading', force = TRUE)" # https://support.bioconductor.org/p/122925/
Rscript -e "install.packages('doParallel')"
Rscript -e "library('seeker')" # force error if install failed
Rscript -e "library('doParallel')"
rm -rf /tmp/downloaded_packages

# url and file name could change
# wget https://d3gcli72yxqn2z.cloudfront.net/connect_latest/v4/bin/ibm-aspera-connect_4.1.1.73_linux.tar.gz
# tar -zxvf ibm-aspera-connect_4.1.1.73_linux.tar.gz
# ./ibm-aspera-connect_4.1.1.73_linux.sh
# rm ibm-aspera-connect*
wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/3.0.0/sratoolkit.3.0.0-ubuntu64.tar.gz
tar -zxvf sratoolkit.3.0.0-ubuntu64.tar.gz
echo 'export PATH="${PATH}:${HOME}/sratoolkit.3.0.0-ubuntu64/bin"' >> ~/.bashrc
echo 'export PATH="${PATH}:${HOME}/sratoolkit.3.0.0-ubuntu64/bin"' >> ~/.profile
rm sratoolkit*.tar.gz

source ~/miniconda3/etc/profile.d/conda.sh
conda activate
mamba install fastq-screen fastqc multiqc pigz refgenie salmon trim-galore

mkdir -p ~/genomes
refgenie init -c ~/genomes/genome_config.yaml
echo 'export REFGENIE="${HOME}/genomes/genome_config.yaml"' >> ~/.bashrc
echo 'export REFGENIE="${HOME}/genomes/genome_config.yaml"' >> ~/.profile
