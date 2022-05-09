#!/bin/bash
set -e

Rscript -e "if (!requireNamespace('BiocManager', quietly = TRUE)) install.packages('BiocManager')"
Rscript -e "BiocManager::install('seeker', site_repository = 'https://hugheylab.github.io/drat/', update = FALSE, ask = FALSE)"
Rscript -e "BiocManager::install('preprocessCore', configure.args = '--disable-threading', force = TRUE)" # https://support.bioconductor.org/p/122925/
Rscript -e "install.packages('doParallel')"
Rscript -e "library('seeker')" # force error if install failed
Rscript -e "library('doParallel')"
Rscript -e "seeker::installSysDeps()"
rm -rf /tmp/downloaded_packages
