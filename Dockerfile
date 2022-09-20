FROM debian:9-slim

RUN apt-get update && \
   apt-get install -y --no-install-recommends \
   wget build-essential libreadline-gplv2-dev libncursesw5-dev libssl-dev \
   libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev locales ca-certificates && \
   rm -rf /var/cache/apt/archives/*

RUN printf 'en_US.UTF-8 UTF-8\n' >> /etc/locale.gen && locale-gen

RUN wget https://www.python.org/ftp/python/3.9.4/Python-3.9.4.tgz && tar xzf Python-3.9.4.tgz && rm Python-3.9.4.tgz

WORKDIR Python-3.9.4

RUN ./configure --enable-optimizations && make altinstall

RUN python3.9 -m pip install --upgrade pip

ADD ./app/requirements.txt /requirements.txt
RUN python3.9 -m pip install -r /requirements.txt

COPY ./app /app/

EXPOSE 80

WORKDIR /app

ENV FLASK_APP=finenomore \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8

ENTRYPOINT [ "flask", "run", "--host=0.0.0.0", "--port=80" ]
