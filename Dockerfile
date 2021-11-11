FROM rocker/tidyverse:4.1.2

LABEL org.opencontainers.image.authors="Jake Hughey <jakejhughey@gmail.com>" \
      org.opencontainers.image.source="https://github.com/hugheylab/socker"

RUN apt-get update && \
  apt-get install -y \
    nano \
    tmux && \
  rm -rf /var/lib/apt/lists/*

# RUN usermod -aG sudo rstudio
# user can set password with "sudo passwd rstudio"

USER rstudio
WORKDIR /home/rstudio
COPY install_seeker.sh .
RUN ./install_seeker.sh
ENV REFGENIE "/home/rstudio/genomes/genome_config.yaml"

CMD /bin/bash
