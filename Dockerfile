FROM quay.io/natlibfi/annif:1.0.0
# Docker image to use in Annif tutorial, https://github.com/NatLibFi/Annif-tutorial.
# Build with:
#     docker build -t quay.io/natlibfi/annif:1.0-tutorial -t quay.io/natlibfi/annif:tutorial .
#

USER root

RUN apt-get update \
	&& apt-get install -y --no-install-recommends curl nano wget make poppler-utils git

RUN mkdir -p /Annif-tutorial /Annif-tutorial-dvc /home/annif_user \
	&& chown -R annif_user:annif_user /Annif-tutorial /home/annif_user \
	&& chmod a+w /Annif-tutorial-dvc

WORKDIR /Annif
RUN poetry config virtualenvs.create false
RUN poetry add jupyter dvc --no-cache

USER annif_user
ENV JUPYTER_DATA_DIR=/tmp
ENV JUPYTER_CONFIG_DIR=/tmp

WORKDIR /Annif-tutorial

CMD bash
