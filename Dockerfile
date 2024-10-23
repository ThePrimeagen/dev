ARG GO_VERSION=1
FROM golang:${GO_VERSION}-bookworm as builder

WORKDIR /usr/src/app
COPY go.mod ./
RUN go mod download && go mod verify
COPY resources resources
COPY main.go main.go
RUN go build -v -o /run-app ./main.go

FROM debian:bookworm

COPY --from=builder /run-app /usr/local/bin/
CMD ["run-app"]
