# .devcontainer/Dockerfile - Self-contained build for maximum portability
# This allows the Dev Container to work even if the root Dockerfile.dev changes
# It simply re-uses the same logic as Dockerfile.dev for consistency

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm-256color

RUN apt-get update && apt-get install -y \
    git \
    curl \
    vim \
    neovim \
    tmux \
    bash \
    sudo \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash devuser && \
    echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Copy the entire repo (build context should be repo root when using this file)
COPY . /root/dotfiles

RUN cd /root/dotfiles && bash install.sh || true

# Pre-warm Neovim
RUN nvim --headless -c 'lua print("Neovim pre-warm complete"); vim.cmd("qa")' 2>/dev/null || true

WORKDIR /workspace
USER root
CMD ["bash"]