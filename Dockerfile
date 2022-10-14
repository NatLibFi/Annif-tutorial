FROM quay.io/natlibfi/annif:0.59
# Docker image to use in Annif tutorial, https://github.com/NatLibFi/Annif-tutorial.
# Build with:
#     docker build -t quay.io/natlibfi/annif:0.59-tutorial -t quay.io/natlibfi/annif:tutorial .
#

USER root

RUN apt-get update \
	&& apt-get install -y --no-install-recommends curl nano wget make poppler-utils git

RUN mkdir -p /Annif-tutorial /home/annif_user \
	&& chown -R annif_user:annif_user /Annif-tutorial /home/annif_user

RUN pip install jupyter dvc --no-cache-dir

USER annif_user
ENV JUPYTER_DATA_DIR=/tmp

WORKDIR /Annif-tutorial

CMD bash
