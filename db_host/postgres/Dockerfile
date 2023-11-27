FROM postgres:16-alpine

ARG postgres/data:/var/lib/postgresql/data
ARG POSTGRES_PASSWORD=$POSTGRES_PASSWORD
ARG POSTGRES_USER=$POSTGRES_USER
ARG POSTGRES_DB=$POSTGRES_DB
COPY ./config /docker-entrypoint-initdb.d/
COPY ./postgresql.conf /var/lib/postgresql/
