#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Options
FORCE=false
INSTALL_PACKAGES=false
DRY_RUN=false

# Colors
info()    { echo -e "\033[34m[INFO]\033[0m $*"; }
success() { echo -e "\033[32m[OK]\033[0m $*"; }
warn()    { echo -e "\033[33m[WARN]\033[0m $*"; }
error()   { echo -e "\033[31m[ERROR]\033[0m $*" >&2; exit 1; }

# Detect OS
detect_os() {
    case "$(uname -s)" in
        Darwin) echo "mac" ;;
        Linux)  echo "linux" ;;
        *)      echo "unknown" ;;
    esac
}

# Detect Linux package manager
detect_package_manager() {
    if command -v apt-get &>/dev/null; then
        echo "apt"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v yum &>/dev/null; then
        echo "yum"
    else
        echo "unknown"
    fi
}

# Create common directories
create_directories() {
    info "Creating directories..."
    local dirs=(
        ~/.config/nvim
        ~/.cache/tmp
        ~/.zsh
        ~/repo
        ~/work
        ~/tmp
        ~/.vim/undo
        ~/.vim/UltiSnips
    )
    for dir in "${dirs[@]}"; do
        if [[ "$DRY_RUN" == true ]]; then
            info "[DRY-RUN] mkdir -p $dir"
        else
            mkdir -p "$dir"
        fi
    done
    success "Directories created"
}

# Create symlink
create_symlink() {
    local src="$1"
    local dst="$2"

    if [[ ! -f "$src" && ! -d "$src" ]]; then
        warn "Source not found: $src"
        return 1
    fi

    if [[ "$DRY_RUN" == true ]]; then
        info "[DRY-RUN] ln -sf $src -> $dst"
        return 0
    fi

    ln -sf "$src" "$dst"
    success "$dst -> $src"
}

# Setup for macOS
setup_mac() {
    info "Setting up for macOS..."

    # Symlinks
    create_symlink "$DOTFILES_DIR/mac/zshrc" ~/.zshrc
    create_symlink "$DOTFILES_DIR/mac/bashrc" ~/.bashrc
    create_symlink "$DOTFILES_DIR/mac/vimrc" ~/.vimrc
    create_symlink "$DOTFILES_DIR/mac/tmux.conf" ~/.tmux.conf
    create_symlink "$DOTFILES_DIR/mac/curlrc" ~/.curlrc
    create_symlink "$DOTFILES_DIR/mac/psqlrc" ~/.psqlrc
    create_symlink "$DOTFILES_DIR/mac/mysqlrc" ~/.mysqlrc
    create_symlink "$DOTFILES_DIR/mac/screenrc" ~/.screenrc
    create_symlink "$DOTFILES_DIR/mac/git_ignore" ~/.gitignore_global
    create_symlink "$DOTFILES_DIR/mac/sshrc" ~/.ssh/config

    # Package installation
    if [[ "$INSTALL_PACKAGES" == true ]]; then
        install_mac_packages
    fi

    success "macOS setup complete"
}

# Setup for Linux
setup_linux() {
    info "Setting up for Linux..."

    # Symlinks
    create_symlink "$DOTFILES_DIR/linux/zshrc" ~/.zshrc
    create_symlink "$DOTFILES_DIR/linux/vimrc" ~/.vimrc
    create_symlink "$DOTFILES_DIR/linux/tmux.conf" ~/.tmux.conf
    create_symlink "$DOTFILES_DIR/linux/gdbinit" ~/.gdbinit

    # Package installation
    if [[ "$INSTALL_PACKAGES" == true ]]; then
        install_linux_packages
    fi

    success "Linux setup complete"
}

# Install Homebrew packages (macOS)
install_mac_packages() {
    info "Installing macOS packages..."

    # Check/Install Homebrew
    if ! command -v brew &>/dev/null; then
        info "Installing Homebrew..."
        if [[ "$DRY_RUN" == true ]]; then
            info "[DRY-RUN] Install Homebrew"
        else
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
    fi

    # Install from brew.list
    local brew_list="$DOTFILES_DIR/mac/brew.list"
    if [[ -f "$brew_list" ]]; then
        info "Installing packages from brew.list..."
        if [[ "$DRY_RUN" == true ]]; then
            info "[DRY-RUN] brew install < $brew_list"
        else
            while IFS= read -r package || [[ -n "$package" ]]; do
                [[ -z "$package" || "$package" =~ ^# ]] && continue
                brew install "$package" 2>/dev/null || warn "Failed to install: $package"
            done < "$brew_list"
        fi
    fi

    success "macOS packages installed"
}

# Install Linux packages
install_linux_packages() {
    info "Installing Linux packages..."

    local pkg_manager
    pkg_manager=$(detect_package_manager)

    if [[ "$pkg_manager" == "unknown" ]]; then
        warn "Unknown package manager. Skipping package installation."
        return 1
    fi

    local packages=(
        git
        vim
        tmux
        zsh
        curl
        wget
        jq
        fzf
        ripgrep
        htop
        tree
    )

    if [[ "$DRY_RUN" == true ]]; then
        info "[DRY-RUN] $pkg_manager install ${packages[*]}"
        return 0
    fi

    case "$pkg_manager" in
        apt)
            sudo apt-get update
            sudo apt-get install -y "${packages[@]}"
            ;;
        dnf)
            sudo dnf install -y "${packages[@]}"
            ;;
        yum)
            sudo yum install -y "${packages[@]}"
            ;;
    esac

    success "Linux packages installed"
}

# Show help
show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Setup dotfiles for macOS or Linux.

OPTIONS:
    -f, --force       Run without confirmation prompt
    -p, --packages    Also install packages (Homebrew/apt/dnf/yum)
    -n, --dry-run     Show what would be done without making changes
    -h, --help        Show this help message

EXAMPLES:
    $(basename "$0")              # Interactive setup
    $(basename "$0") -f           # Force setup without confirmation
    $(basename "$0") -f -p        # Force setup with package installation
    $(basename "$0") -n           # Dry run to see what would happen

EOF
}

# Parse arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -f|--force)
                FORCE=true
                shift
                ;;
            -p|--packages)
                INSTALL_PACKAGES=true
                shift
                ;;
            -n|--dry-run)
                DRY_RUN=true
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                error "Unknown option: $1"
                ;;
        esac
    done
}

# Main
main() {
    parse_args "$@"

    local os
    os=$(detect_os)

    info "Detected OS: $os"
    info "Dotfiles directory: $DOTFILES_DIR"

    if [[ "$os" == "unknown" ]]; then
        error "Unsupported OS: $(uname -s)"
    fi

    # Confirmation
    if [[ "$FORCE" != true && "$DRY_RUN" != true ]]; then
        read -rp "This may overwrite existing files. Continue? (y/n) " -n 1
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            info "Aborted."
            exit 0
        fi
    fi

    # Update dotfiles
    if [[ "$DRY_RUN" != true ]]; then
        info "Updating dotfiles repository..."
        git -C "$DOTFILES_DIR" pull origin master 2>/dev/null || \
        git -C "$DOTFILES_DIR" pull origin main 2>/dev/null || \
        warn "Failed to pull latest changes"
    fi

    # Create directories
    create_directories

    # OS-specific setup
    case "$os" in
        mac)   setup_mac ;;
        linux) setup_linux ;;
    esac

    echo
    success "Dotfiles setup complete!"
    info "Restart your shell or run: source ~/.zshrc"
}

main "$@"
