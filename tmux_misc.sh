#!/bin/bash
# Misc setup
TMUX_ENV=misc
# Check if session is already active
if tmux list-sessions | grep $TMUX_ENV; then
  echo "Attaching to previous session"
  tmux attach -t$TMUX_ENV
  exit
fi

  # split-window -v -p 10 \; \
  # select-pane -t 1 \; \
  # send-keys 'porsmo' C-m \; \
echo "Creating new session"
systemd-run --user --scope --slice=session.slice --unit=tmux-misc -- tmux new-session -s $TMUX_ENV -n dharma -c /home/jmj/Dropbox/Apps/Obsidian/Dharma/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n dotfiles -t 8 -c /home/jmj/.dotfiles/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n kanata -t 9 \; \
  send-keys 'sudo /home/jmj/.cargo/bin/kanata --cfg /home/jmj/.dotfiles/kanata/engswe_capslock_ctrlescape_vimkeys.kbd' C-m \; \
