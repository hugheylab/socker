#!/bin/bash
set -e

Rscript -e "if (!requireNamespace('BiocManager', quietly = TRUE)) install.packages('BiocManager')"
Rscript -e "BiocManager::install('seeker', site_repository = 'https://hugheylab.github.io/drat/', update = FALSE, ask = FALSE)"
Rscript -e "install.packages('doParallel')"
rm -rf /tmp/downloaded_packages

# url and file name could change
wget https://d3gcli72yxqn2z.cloudfront.net/connect_latest/v4/bin/ibm-aspera-connect_4.1.0.46-linux_x86_64.tar.gz
tar -zxvf ibm-aspera-connect_4.1.0.46-linux_x86_64.tar.gz
./ibm-aspera-connect_4.1.0.46-linux_x86_64.sh
rm ibm-aspera-connect*

source ~/miniconda3/etc/profile.d/conda.sh
conda activate
mamba install fastq-screen fastqc multiqc refgenie salmon trim-galore

mkdir -p ~/genomes
refgenie init -c ~/genomes/genome_config.yaml
echo 'export REFGENIE="${HOME}/genomes/genome_config.yaml"' >> ~/.bashrc
echo 'export REFGENIE="${HOME}/genomes/genome_config.yaml"' >> ~/.profile
