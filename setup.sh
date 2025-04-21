#!/usr/bin/env bash

set -e

echo "🔍 Detecting OS..."

# Helper func to install LazyGit from source
lazygit_install() {
    TEMP_DIR=$HOME/temp_dir
    INSTALL_DIR=/usr/local/bin/

    echo "Creating temp directory : ${TEMP_DIR}"
    mkdir -p "${TEMP_DIR}" && cd "${TEMP_DIR}"


    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')

    echo "Downloading version : ${LAZYGIT_VERSION}"

    read -rp "Continue to download and install LazyGit Version ${LAZYGIT_VERSION}? [y/N]" LAZY_CONFIRM

    if [[ "$LAZY_CONFIRM" =~ ^[Yy]$ ]]; then

        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

        echo "Extracting ..."
        tar xf "lazygit.tar.gz" "lazygit"

        echo "Installing to directory : ${INSTALL_DIR}"
        sudo install lazygit -D -t "${INSTALL_DIR}"
    else
        echo "Aborting Lazygit Install"
    fi

    cd -

    echo "Post install cleanup - Removing ${TEMP_DIR}"
    rm -rf "${TEMP_DIR}"

    exit 0
}

# Function to install on Debian/Ubuntu
install_debian() {
    echo "🟢 Debian/Ubuntu detected. Installing Neovim..."
    sudo apt update
    sudo apt install -y neovim curl git \
        python3-pip python3-venv software-properties-common git-delta

    lazygit_install
}

# Function to install on Fedora
install_fedora() {
    echo "🟠 Fedora detected. Installing Neovim..."
    sudo dnf install -y neovim curl git lazygit git-delta python3-pip python3-virtualenv
}

# Function to install on macOS
install_macos() {
    echo "🔵 macOS detected. Installing Neovim..."
    # Check for Homebrew
    if ! command -v brew &>/dev/null; then
        echo "🍺 Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    brew update
    brew install neovim git lazygit git-delta python
}

# Detect OS and call the appropriate install function
case "$(uname)" in
    "Linux")
        if [ -f /etc/debian_version ]; then
            install_debian
        elif [ -f /etc/fedora-release ]; then
            install_fedora
        else
            echo "❌ Unsupported Linux distribution."
            exit 1
        fi
        ;;
    "Darwin")
        install_macos
        ;;
    *)
        echo "❌ Unsupported operating system."
        exit 1
        ;;
esac

# Set up Python support
# echo "🐍 Setting up Python support for Neovim..."
# pip3 install --user --upgrade pynvim

echo "✅ Neovim and dependencies installed successfully!"


# Download the latest binary from GitHub
# LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' | cut -d'"' -f4)
# curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION#v}_Linux_x86_64.tar.gz"
# tar xf lazygit.tar.gz lazygit
# sudo install lazygit /usr/local/bin
#
