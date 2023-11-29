ARG GOARCH=amd64
FROM golang:1.21 as build
RUN mkdir /app && mkdir /opt/bingo && mkdir /opt/bongo && mkdir /opt/bongo/logs && \
mkdir /opt/bongo/logs/f5d569d9f9 && chmod 777 /opt/bongo/logs/f5d569d9f9 && \
chmod 777 /opt/bingo
RUN groupadd --gid 1000 ubuntu && useradd --uid 1000 --gid 1000 -m ubuntu
WORKDIR /app
COPY config.yaml /opt/bingo

FROM alpine
COPY --from=build /app /
COPY --from=build /opt/bingo /opt/bingo/
COPY --from=build /opt/bongo /opt/bongo/
COPY --from=build /etc/passwd /etc/
COPY . .
EXPOSE 32531
RUN apk add curl
USER ubuntu
CMD ["/bingo", "run_server"]
