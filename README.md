# golang-upx

golang builder image with UPX included

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

FROM gcr.io/distroless/base:3c29f81d9601750a95140e4297a06765c41ad10e
COPY --from=builder /go/bin/somebinary /app/somebinary

CMD ["/app/somebinary"]

```

