FROM golang:1.22-alpine

RUN apk add --no-cache curl

# Install golang-migrate CLI
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.17.1/migrate.linux-amd64.tar.gz \
    -o migrate.tar.gz && \
    tar -xvf migrate.tar.gz && \
    mv migrate.linux-amd64 /usr/local/bin/migrate

WORKDIR /migrations

ENTRYPOINT ["migrate"]