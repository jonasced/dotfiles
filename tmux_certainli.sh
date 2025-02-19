#!/bin/bash
# certainli setup

TMUX_ENV=certainli
# Check if session is already active
if tmux list-sessions | grep $TMUX_ENV; then
  echo "Attaching to previous session"
  tmux attach -t$TMUX_ENV
  exit
fi

tmux new-session -s $TMUX_ENV -n backend -c /home/jonas/dev/certainli/ \; \
  send-keys 'cd certainli-backend' C-m \; \
  send-keys 'nvim .' C-m \; \
  new-window -n frontend -c /home/jonas/dev/certainli/certainli-frontend/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n pyapi -c /home/jonas/dev/certainli/certainli-pyapi/ \; \
  send-keys 'eval "$( poetry env activate )"' C-m \; \
  send-keys 'nvim .' C-m \; \
