FROM rocker/tidyverse:4.1.1

LABEL org.opencontainers.image.authors="Jake Hughey <jakejhughey@gmail.com>"

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
RUN /home/rstudio/install_seeker.sh

CMD /bin/bash
