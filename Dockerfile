FROM docker/sandbox-templates:shell-docker@sha256:39cf20eca861ec92747487af6197f6d916f774bdb98245d267dbd8dfd3debb05

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
