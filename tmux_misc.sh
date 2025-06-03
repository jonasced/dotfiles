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
tmux new-session -s $TMUX_ENV -n dharma -c /home/jonas/Dropbox/Apps/Obsidian/Dharma/ \; \
  send-keys 'nvim .' C-m \; \
  split-window -v -p 10 \; \
  select-pane -t 1 \; \
  send-keys 'porsmo' C-m \; \
  new-window -n dotfiles -t 8 -c /home/jonas/.dotfiles/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n kanata -t 9 \; \
  send-keys 'sudo /home/jonas/.cargo/bin/kanata --cfg /home/jonas/.dotfiles/kanata/engswe_capslock_ctrlescape_vimkeys.kbd' C-m \; \
