# Dotfiles Makefile
# Supports macOS and Linux

SHELL := /bin/bash
DOTFILES_DIR := $(shell pwd)

# OS detection
UNAME := $(shell uname -s)
ifeq ($(UNAME),Darwin)
    OS := mac
else ifeq ($(UNAME),Linux)
    OS := linux
else
    OS := unknown
endif

# Directories to create
DIRS := ~/.config/nvim \
        ~/.cache/tmp \
        ~/.zsh \
        ~/repo \
        ~/work \
        ~/tmp \
        ~/.vim/undo \
        ~/.vim/UltiSnips

.PHONY: all help dirs link link-mac link-linux packages clean

# Default target
all: dirs link
	@echo "Setup complete for $(OS)"

# Show help
help:
	@echo "Dotfiles Makefile"
	@echo ""
	@echo "Detected OS: $(OS)"
	@echo ""
	@echo "Targets:"
	@echo "  all        - Create directories and symlinks (default)"
	@echo "  help       - Show this help message"
	@echo "  dirs       - Create common directories"
	@echo "  link       - Create symlinks (auto-detect OS)"
	@echo "  link-mac   - Create macOS symlinks"
	@echo "  link-linux - Create Linux symlinks"
	@echo "  packages   - Install packages (Homebrew/apt)"
	@echo "  clean      - Remove symlinks"

# Create directories
dirs:
	@echo "Creating directories..."
	@mkdir -p $(DIRS)
	@echo "Done"

# OS-aware symlink target
link:
ifeq ($(OS),mac)
	@$(MAKE) link-mac
else ifeq ($(OS),linux)
	@$(MAKE) link-linux
else
	@echo "Unsupported OS: $(UNAME)"
	@exit 1
endif

# macOS symlinks
link-mac:
	@echo "Creating macOS symlinks..."
	ln -sf $(DOTFILES_DIR)/mac/zshrc ~/.zshrc
	ln -sf $(DOTFILES_DIR)/mac/bashrc ~/.bashrc
	ln -sf $(DOTFILES_DIR)/mac/vimrc ~/.vimrc
	ln -sf $(DOTFILES_DIR)/mac/tmux.conf ~/.tmux.conf
	ln -sf $(DOTFILES_DIR)/mac/curlrc ~/.curlrc
	ln -sf $(DOTFILES_DIR)/mac/psqlrc ~/.psqlrc
	ln -sf $(DOTFILES_DIR)/mac/mysqlrc ~/.mysqlrc
	ln -sf $(DOTFILES_DIR)/mac/screenrc ~/.screenrc
	ln -sf $(DOTFILES_DIR)/mac/git_ignore ~/.gitignore_global
	@echo "Done"

# Linux symlinks
link-linux:
	@echo "Creating Linux symlinks..."
	ln -sf $(DOTFILES_DIR)/linux/zshrc ~/.zshrc
	ln -sf $(DOTFILES_DIR)/linux/vimrc ~/.vimrc
	ln -sf $(DOTFILES_DIR)/linux/tmux.conf ~/.tmux.conf
	ln -sf $(DOTFILES_DIR)/linux/gdbinit ~/.gdbinit
	@echo "Done"

# Install packages
packages:
ifeq ($(OS),mac)
	@echo "Installing Homebrew packages..."
	@if ! command -v brew &>/dev/null; then \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	@if [ -f $(DOTFILES_DIR)/mac/brew.list ]; then \
		cat $(DOTFILES_DIR)/mac/brew.list | xargs brew install; \
	fi
else ifeq ($(OS),linux)
	@echo "Installing Linux packages..."
	sudo apt-get update && sudo apt-get install -y git vim tmux zsh curl wget jq fzf ripgrep htop tree
endif
	@echo "Done"

# Remove symlinks
clean:
	@echo "Removing symlinks..."
	rm -f ~/.zshrc ~/.bashrc ~/.vimrc ~/.tmux.conf
	rm -f ~/.curlrc ~/.psqlrc ~/.mysqlrc ~/.screenrc
	rm -f ~/.gitignore_global ~/.gdbinit
	@echo "Done"
