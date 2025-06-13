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
  curl https://download.hyper.space/api/install | bash
  source ~/.bashrc
fi

# === Start tmux session ===
SESSION="hyperspace"
if tmux has-session -t "$SESSION" 2>/dev/null; then
  echo -e "${YELLOW}Session '$SESSION' already exists. Attaching...${RESET}"
else
  echo -e "${CYAN}Creating tmux session: $SESSION${RESET}"
  tmux new-session -d -s "$SESSION"

  # Commands to run inside tmux session
  tmux send-keys -t "$SESSION" "aios-cli start" C-m
  sleep 5
  tmux send-keys -t "$SESSION" "aios-cli models add hf:TheBloke/phi-2-GGUF:phi-2.Q4_K_M.gguf" C-m
  sleep 5
  tmux send-keys -t "$SESSION" "aios-cli hive import-keys ./my.pem" C-m
  tmux send-keys -t "$SESSION" "aios-cli hive login" C-m
  tmux send-keys -t "$SESSION" "aios-cli hive connect" C-m
  tmux send-keys -t "$SESSION" "aios-cli hive select-tier 5" C-m
fi

echo -e "${GREEN}Node is running in tmux session '$SESSION'. To attach: ${CYAN}tmux attach -t hyperspace${RESET}"
