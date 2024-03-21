FROM golang:1.22.1

ARG upx_version=4.2.2
ARG GOPROXY

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# hadolint ignore=DL3008
RUN arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) && \
  apt-get update && apt-get install -y --no-install-recommends xz-utils && \
  curl -Ls https://github.com/upx/upx/releases/download/v${upx_version}/upx-${upx_version}-${arch}_linux.tar.xz -o - | tar xvJf - -C /tmp && \
  cp /tmp/upx-${upx_version}-${arch}_linux/upx /usr/local/bin/ && \
  chmod +x /usr/local/bin/upx && \
  apt-get remove -y xz-utils && \
  rm -rf /var/lib/apt/lists/*

