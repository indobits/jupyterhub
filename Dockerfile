#FROM jupyterhub/jupyterhub:1.1.0
FROM python:3.8.1

RUN apt-get update

RUN apt-get install locales locales-all -y
ENV LANG 'en_US.UTF-8'
ENV LANGUAGE 'en_US.UTF-8'
ENV LC_ALL 'en_US.UTF-8'

ENV TZ 'America/Lima'
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get install libgeos-dev libspatialindex-dev -y

COPY requirements.txt .
RUN pip install -r requirements.txt

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install nodejs
RUN npm install -g npm@6.13.7
RUN npm install -g configurable-http-proxy@4.2.0

#RUN useradd --user-group --system --create-home --no-log-init app
#USER app
WORKDIR /app
#COPY . .

#CMD openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
#	-keyout certificates/key.pem -out certificates/cert.pem \
#	-subj '/CN=localhost' && \
CMD jupyterhub -f .jupyter/config.py