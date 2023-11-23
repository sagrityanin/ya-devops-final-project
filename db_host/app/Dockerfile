ARG GOARCH=amd64
ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=1000
FROM golang:1.21.3
RUN mkdir /app && mkdir /opt/bingo && mkdir /opt/bongo && mkdir /opt/bongo/logs && \
mkdir /opt/bongo/logs/f5d569d9f9 && chmod 777 /opt/bongo/logs/f5d569d9f9 && \
chmod 777 /opt/bingo
RUN groupadd --gid 1000 ubuntu && useradd --uid 1000 --gid 1000 -m ubuntu && \
apt update && apt install postgresql-client -y
WORKDIR /app
COPY . .
USER ubuntu
CMD ["bash", "/app/start.sh"]
