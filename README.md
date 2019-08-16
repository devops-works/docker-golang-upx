# golang-upx

Golang builder image with UPX included

[UPX](https://upx.github.io/) strip will strip your golang binaries
pretty effectively, reducing you final container size.

See [Docker Hub](https://hub.docker.com/r/devopsworks/golang-upx) for final images.

## Usage

```dockerfile
FROM devopsworks/golang-upx:1.12 as builder

WORKDIR /src

COPY go.mod .
COPY go.sum .

RUN go mod download

RUN GOOS=linux \
  GOARCH=amd64 \
  go build \
  ...
  -o /go/bin/somebinary && \
  strip /go/bin/somebinary && \
  /usr/local/bin/upx -9 /go/bin/somebinary

FROM gcr.io/distroless/base:3c29f81d9601750a95140e4297a06765c41ad10e
COPY --from=builder /go/bin/somebinary /app/somebinary

CMD ["/app/somebinary"]
```

## Authors

[devopsworks](https://devops.works)

