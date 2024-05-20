# Use Debian base image
FROM debian:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic tools
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    wget \
    git \
    zsh \
    vim \
    emacs \
    neovim \
    nano \
    python3 \
    python3-pip \
    gcc \
    g++ \
    racket \
    docker-compose \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Rust standard tooling
RUN rustup component add rustfmt clippy

# Install Visual Studio Code Server (code-server)
# Note: You might want to check for the latest version of code-server and update the URL accordingly.
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Set Zsh as the default shell
RUN chsh -s $(which zsh)

# Copy any custom scripts or configuration files (if you have any)
# Example:
# COPY ./custom_script.sh /usr/local/bin/custom_script.sh
# RUN chmod +x /usr/local/bin/custom_script.sh

# Set the working directory
WORKDIR /workspace

# Expose ports (if needed, e.g., for web development or if you decide to use code-server's port)
# EXPOSE 8080

# Set the default command to Zsh
CMD ["zsh"]
