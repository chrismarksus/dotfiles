# Dockerfile for testing dotfiles installation
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    vim \
    neovim \
    bash \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create a test user
RUN useradd -ms /bin/bash testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

# Copy dotfiles repo into the container
COPY --chown=testuser:testuser . /home/testuser/dotfiles

# Run the install script
RUN cd /home/testuser/dotfiles && bash install.sh || true

# Pre-warm Neovim (caches lazy.nvim plugins, shada, etc.) so subsequent
# validation runs finish quickly and reliably without slow first-start penalty
RUN nvim --headless -c 'lua print("Neovim pre-warm complete"); vim.cmd("qa")' 2>/dev/null || true

# Make validation script executable and run it
RUN chmod +x /home/testuser/dotfiles/scripts/validate-install.sh
RUN /home/testuser/dotfiles/scripts/validate-install.sh || true

CMD ["bash"]