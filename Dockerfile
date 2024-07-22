FROM rocker/shiny:4.3.2

RUN apt-get update \
  && apt-get install -y --no-install-recommends ncbi-blast+ \
  && rm -rf /var/lib/apt/lists/*

RUN R -q -e "install.packages(c( \
  'protr', \
  'e1071', \
  'seqinr', \
  'shinyjs', \
  'stringr', \
  'markdown', \
  'shinythemes', \
  'DT', \
  'bslib' \
), repos='https://cloud.r-project.org')"

RUN R -q -e "stopifnot(vapply(c('protr', 'e1071', 'seqinr', 'shiny', \
  'shinyjs', 'stringr', 'markdown', 'shinythemes', 'DT', 'bslib'), \
  requireNamespace, logical(1), quietly=TRUE))"

COPY Plant-mSubP /srv/shiny-server/Plant-mSubP
COPY deploy/shiny-server.conf /etc/shiny-server/shiny-server.conf

WORKDIR /srv/shiny-server/Plant-mSubP

ENV PLANT_MSUBP_BLAST_DB=/opt/blast_db/subcellular_localization_db

EXPOSE 3838

CMD ["/init"]
