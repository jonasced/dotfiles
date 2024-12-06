#!/bin/bash
# Misc setup
TMUX_ENV=misc
# Check if session is already active
if tmux list-sessions | grep $TMUX_ENV; then
  echo "Attaching to previous session"
  tmux attach -t$TMUX_ENV
  exit
fi

echo "Creating new session"
tmux new-session -s $TMUX_ENV -n dharma nvim /home/jonas/Dropbox/Apps/Obsidian/Dharma/ \; \
  split-window -v -p 10 \; \
  select-pane -t 1 \; \
  send-keys 'porsmo' C-m \; \
  new-window -n dotfiles nvim /home/jonas/.dotfiles/ \; \
  new-window -n kanata sudo /home/jonas/.cargo/bin/kanata --cfg /home/jonas/.dotfiles/kanata/engswe_capslock_ctrlescape_vimkeys.kbd
