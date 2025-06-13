# Hyperspace Node One Click Setup (Linux)

This guide helps you install and run a Hyperspace Node in one click using a simple script and `tmux`. It includes both CLI and desktop options.

---

## Method 1: One-Click CLI Script (Recommended for VPS/Linux)

### Install Dependencies 
```bash
sudo apt update && sudo apt install git -y
```
### Quick Start: Run the Script
```bash
bash <(curl -sL https://raw.githubusercontent.com/CodeDialect/hyperspace/main/hyperspace_setup.sh)
```

### What the script does:
- Prompts you for your **Private Key**
- Saves it securely to `my.pem`
- Installs the CLI if needed
- Runs the node inside a persistent `tmux` session
- Automatically downloads the model and configures the node

### Your tmux session will auto-start everything:
To reattach anytime:
```bash
tmux attach -t hyperspace
```

---

## Method 2: Desktop App (Windows/Mac/Linux)

1. Visit the official [Download Page](https://hyper.space/downloads)
2. Choose your OS and version (CPU or GPU)
3. Run the app and toggle the red switch to green
---

## Common `tmux` Commands

| Command | Description |
|--------|-------------|
| `tmux attach -t hyperspace` | Reattach to your running node |
| `tmux ls` | List all tmux sessions |
| `tmux kill-session -t hyperspace` | Stop the session completely |
| `CTRL + A then D` | Detach from the session |

---

## Useful `aios-cli` Commands

| Command | Description |
|--------|-------------|
| `aios-cli start` | Start the node |
| `aios-cli hive import-keys ./my.pem` | Import your private key |
| `aios-cli hive login` | Login to the hive |
| `aios-cli hive connect` | Connect to the hive |
| `aios-cli hive select-tier 5` | Choose Tier-5 (2x if upgraded to Tier-3) |
| `aios-cli hive points` | Check your points and multipliers |
| `aios-cli models add hf:TheBloke/phi-2-GGUF:phi-2.Q4_K_M.gguf` | Download and register the model |

---

## Notes

- Ensure you keep your `my.pem` file safe. It's your identity!
- The node must stay online 24/7 to earn points.
- The more uptime and performance, the higher the tier and multiplier.

---
