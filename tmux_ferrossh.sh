#!/bin/bash
# ferroamp setup
TMUX_ENV=ssh
# Check if session is already active
if tmux list-sessions | grep $TMUX_ENV; then
  echo "Attaching to previous session"
  tmux attach -t$TMUX_ENV
  exit
fi

tmux new-session -s $TMUX_ENV -n term -c /home/jonas/dev/ferroamp/ \; \
  send-keys 'cat ~/.ssh/id_ferroserver_rsa.pub | ssh ferroamp ferro-sign > ~/.ssh/ferroamp-cert.pub' C-m \; \
  new-window -n 3117 -c /home/jonas/dev/ferroamp/ \; \
  send-keys 'ssh fe-ace-3117' C-m \; \
  new-window -n 4502 -c /home/jonas/dev/ferroamp/ \; \
  send-keys 'ssh fe-ace-4502' C-m \; \
  new-window -n 5927 -c /home/jonas/dev/ferroamp/ \; \
  send-keys 'ssh fe-ace-5927' C-m \; \
  new-window -n 4423 -c /home/jonas/dev/ferroamp/ \; \
  send-keys 'ssh fe-ace-4423' C-m \; \
  new-window -n 6125 -c /home/jonas/dev/ferroamp/ \; \
  send-keys 'ssh fe-ace-6125' C-m \; \
  new-window -n 5040 -c /home/jonas/dev/ferroamp/ \; \
  send-keys 'ssh fe-ace-5040' C-m \; \
