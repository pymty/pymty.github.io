FROM ubuntu:18.04
RUN apt-get update && \
    apt-get install -y build-essential libjpeg-dev git-core
RUN apt-get update && \
    apt-get install -y python3 python3-dev python3-pip python3-venv python3-gdbm
RUN python3 -m venv  /env
RUN /env/bin/pip install wheel
RUN /env/bin/pip install Nikola[extras]
ARG UID
ARG GID
ARG USER
RUN useradd --home-dir /home/${USER} --uid ${UID} --gid ${GID}  ${USER} && \
    mkdir /site && chown ${UID}:${GID} /site && \
    mkdir /home/${USER} && chown ${UID}:${GID} /home/${USER}
WORKDIR /site
COPY utils/entrypoint.sh /entrypoint.sh
USER ${UID}:${GID}
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [  ]
