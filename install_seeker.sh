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

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh -b -p ~/miniconda3
rm Miniconda3-latest-Linux-x86_64.sh
~/miniconda3/bin/conda init bash

source ~/miniconda3/etc/profile.d/conda.sh
conda activate

conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

conda install mamba -c conda-forge
mamba install refgenie trim-galore fastqc fastq-screen salmon multiqc

mkdir -p ~/genomes
refgenie init -c ~/genomes/genome_config.yaml
echo 'export REFGENIE="${HOME}/genomes/genome_config.yaml"' >> ~/.bashrc
echo 'export REFGENIE="${HOME}/genomes/genome_config.yaml"' >> ~/.profile

# user can then run:
# refgenie pull mm10/salmon_sa_index
# refgenie pull mm10/salmon_partial_sa_index
