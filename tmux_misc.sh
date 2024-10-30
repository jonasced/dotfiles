#!/bin/bash
# Misc setup
tmux new-session -s misc -n dharma nvim /home/jonas/Dropbox/Apps/Obsidian/Dharma/ \; \
  split-window -v -p 10 \; \
  select-pane -t 1 \; \
  send-keys 'porsmo' C-m \; \
  new-window -n dotfiles nvim /home/jonas/.dotfiles/ \; \
  new-window -n kanata sudo /home/jonas/.cargo/bin/kanata --cfg /home/jonas/.dotfiles/kanata/engswe_capslock_ctrlescape_vimkeys.kbd
