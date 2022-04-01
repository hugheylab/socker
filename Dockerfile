FROM ghcr.io/hugheylab/stocker:latest

LABEL org.opencontainers.image.authors="Jake Hughey <jakejhughey@gmail.com>" \
      org.opencontainers.image.source="https://github.com/hugheylab/socker"

COPY install_seeker.sh .
RUN ./install_seeker.sh
ENV PATH="$PATH:/home/rstudio/sratoolkit/bin"
ENV REFGENIE="/home/rstudio/genomes/genome_config.yaml"
