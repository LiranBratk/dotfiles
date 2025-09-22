#!/bin/bash

set -e

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

SOURCE_DIR=$(pwd)
DEST_DIR="$HOME/.config"
EXCLUDE=(".git" "readme.md" "apply_configs.sh" ".zshrc" '.vscode')

echo -e "${YELLOW}Applying dotfiles...${NC}"

mkdir -p "$DEST_DIR"

for item in *; do
    if [[ " ${EXCLUDE[*]} " =~ " ${item} " ]]; then
        continue
    fi

    if [ -d "$item" ]; then
        echo -e "${GREEN}Applying $item configuration...${NC}"
        rsync -a --delete "$item" "$DEST_DIR/"

        if [ -d "$DEST_DIR/$item" ]; then
            find "$DEST_DIR/$item" -type f -name "*.sh" -exec chmod +x {} + 2>/dev/null || true
        fi
    fi
done

echo -e "${GREEN}Applying .zshrc configuration...${NC}"
cp .zshrc "$HOME/"
# Do not source Zsh config inside a Bash process (zsh-only parameter expansions cause errors)
if command -v zsh >/dev/null 2>&1; then
    zsh -ic 'echo Reloaded .zshrc in a subshell.' >/dev/null 2>&1 || true
fi

echo -e "${YELLOW}Done.${NC}"
pkill -x waybar && swaymsg reload