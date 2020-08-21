FROM quay.io/natlibfi/annif:0.49
# Docker image to use in Annif tutorial, https://github.com/NatLibFi/Annif-tutorial.
# Build with:
#     docker build -t quay.io/natlibfi/annif:0.49-tutorial -t quay.io/natlibfi/annif:tutorial .
#

USER root

RUN apt-get update \
	&& apt-get install -y --no-install-recommends curl nano wget make poppler-utils

RUN mkdir -p /Annif-tutorial /home/annif_user/.local/share/nano/ \
	&& chown -R annif_user:annif_user /Annif-tutorial /home/annif_user/.local/share/nano/

USER annif_user

WORKDIR /Annif-tutorial

CMD bash
