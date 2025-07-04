#!/bin/bash

set -e

# === Colors ===
GREEN="\033[0;32m"
CYAN="\033[0;36m"
YELLOW="\033[1;33m"
RESET="\033[0m"

echo -e "${CYAN}Hyperspace Node One-Click Installer${RESET}"

# === Prompt user for Private Key ===
read -rp "$(echo -e "${YELLOW}Enter your Hyperspace PRIVATE KEY:${RESET} ")" PRIVATE_KEY

# === Save to my.pem ===
echo "$PRIVATE_KEY" > my.pem
chmod 600 my.pem
echo -e "${GREEN}Private key saved to my.pem${RESET}"

# === Install CLI if not installed ===
if ! command -v aios-cli &> /dev/null; then
  echo -e "${CYAN}Installing Hyperspace CLI...${RESET}"
  curl https://download.hyper.space/api/install | bas
  export PATH="$HOME/.aios:$PATH"
  source ~/.bashrc
fi

# === Start node in tmux ===
SESSION="hyperspace"
if tmux has-session -t "$SESSION" 2>/dev/null; then
  echo -e "${YELLOW}Session '$SESSION' already exists. Skipping node start.${RESET}"
else
  echo -e "${CYAN}Starting aios-cli in tmux session '$SESSION'...${RESET}"
  tmux new-session -d -s "$SESSION" "aios-cli start"
fi

# === Continue setup on main shell ===
echo -e "${CYAN}Running initial setup commands...${RESET}"
sleep 5
aios-cli models add hf:TheBloke/phi-2-GGUF:phi-2.Q4_K_M.gguf
aios-cli hive import-keys ./my.pem
aios-cli hive login
aios-cli hive connect
aios-cli hive select-tier 5

echo -e "${GREEN}Setup complete! Node is running in tmux session '$SESSION'.${RESET}"
echo -e "${CYAN}To view: tmux attach -t hyperspace${RESET}"
