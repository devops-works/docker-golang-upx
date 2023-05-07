ARG GO_VERSION=1.20

FROM --platform=$BUILDPLATFORM golang:${GO_VERSION} AS base
SHELL ["/bin/bash", "-cex"]
ARG upx_version=4.0.2
ARG TARGETARCH
RUN if [[ $TARGETARCH == "amd64" ]]; then ARCHH="amd64"; \
  elif [[ $TARGETARCH == "arm" ]];then ARCHH="arm"; \
  elif [[ $TARGETARCH == "arm64" ]];then ARCHH="arm64"; \
  elif [[ $TARGETARCH == "mips64le" ]];then ARCHH="mipsel"; \
  elif [[ $TARGETARCH == "mips64" ]];then ARCHH="mips"; \
  elif [[ $TARGETARCH == "386" ]];then ARCHH="i386"; fi; \
  cd /tmp; \
  apt-get update; \
  apt-get install -y --no-install-recommends xz-utils; \
  curl -Ls 'https://github.com/upx/upx/releases/download/v'$upx_version'/upx-'$upx_version'-'$ARCHH'_linux.tar.xz' -o - | tar xvJf - -C /tmp/; \
  mv upx-* upx; \
  mv upx/upx /usr/local/bin/upx; \
  chmod +x /usr/local/bin/upx; \
  apt-get remove -y xz-utils; \
  apt-get clean autoclean; \
  apt-get autoremove --yes; \
  rm -rf /var/lib/{apt/lists/,cache}/* /tmp/*
