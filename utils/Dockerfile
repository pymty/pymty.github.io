FROM ubuntu:18.04
RUN apt-get update && \
    apt-get install -y build-essential libjpeg-dev
RUN apt-get update && \
    apt-get install -y python3 python3-dev python3-pip python3-venv python3-gdbm
RUN python3 -m venv  /env
RUN /env/bin/pip install wheel
RUN /env/bin/pip install Nikola[extras]
WORKDIR /site
COPY utils/entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [  ]
