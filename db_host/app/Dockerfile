ARG GOARCH=amd64
ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=1000
FROM golang:1.21.3 as build
RUN groupadd --gid 1000 ubuntu && useradd --uid 1000 --gid 1000 -m ubuntu

FROM alpine
RUN apk update && apk add postgresql-client
 
RUN mkdir /opt/bingo && mkdir /opt/bongo && mkdir /opt/bongo/logs && \
mkdir /opt/bongo/logs/f5d569d9f9 && chmod 777 /opt/bongo/logs/f5d569d9f9 && \
chmod 777 /opt/bingo
WORKDIR /app
COPY . .
COPY --from=build /etc/passwd /etc/
USER ubuntu
CMD ["sh", "/app/start.sh"]
