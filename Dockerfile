FROM python:3-stretch


# install virtualenv and configure the base virtualenv for s1te
RUN pip install virtualenv==16.1.0

ENV VENV /envs/pymty
ENV VENV_PIP $VENV/bin/pip
RUN virtualenv $VENV
RUN $VENV_PIP install nikola
COPY docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "nikola" ]