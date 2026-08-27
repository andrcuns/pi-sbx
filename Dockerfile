FROM docker/sandbox-templates:shell-docker@sha256:5fc81bc7a127e59d81b244a06831ae3212a0310b2e5a0349c54e29249e45e919

USER root

# install packages
RUN apt-get update  \
  && apt-get -y --no-install-recommends install  \
  curl \
  git \
  ca-certificates \
  build-essential \
  ripgrep \
  fd-find \
  && rm -rf /var/lib/apt/lists/*

# mise paths
ENV MISE_DATA_DIR="/home/agent/mise" \
  MISE_CONFIG_DIR="/home/agent/mise" \
  MISE_CACHE_DIR="/home/agent/mise/cache" \
  MISE_INSTALL_PATH="/home/agent/.local/bin/mise" \
  PATH="/home/agent/mise/shims:$PATH"

USER agent

# install mise
ARG MISE_VERSION
RUN curl https://mise.run | sh && mise --version
