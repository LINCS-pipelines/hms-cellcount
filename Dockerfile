FROM rocker/rstudio-stable:3.4.0

COPY ./Level2_to_Level3.R /home/rstudio/
COPY ./Level3_to_Level4.R /home/rstudio/

RUN apt-get update -qq && \
    apt-get install -y \
    zlib1g-dev \
    libssh2-1-dev \
    libxml2-dev \
    curl \
    libpng-dev \
    sudo \
    wget

RUN R -e "install.packages(c('devtools'), repos = 'http://cran.us.r-project.org')"
RUN R -e "devtools::install_version('readr', version = '1.1.1', repos = 'http://cran.us.r-project.org')"
RUN R -e "devtools::install_version('dplyr', version = '0.7.4', repos = 'http://cran.us.r-project.org')"
RUN R -e "devtools::install_github('schurerlab/LINCSDataPortal', ref = '3680b4dc2d6b5af192f49987eda96ee477da334a', force=TRUE)"

RUN R -e "source('https://bioconductor.org/biocLite.R'); biocLite('GRmetrics', ask=FALSE); "
 
