#!/bin/bash
# certainli setup

TMUX_ENV=certainli
# Check if session is already active
if tmux list-sessions | grep $TMUX_ENV; then
  echo "Attaching to previous session"
  tmux attach -t$TMUX_ENV
  exit
fi


source /home/jonas/dev/certainli/certainli-pyapi/.venv/bin/activate || echo "failed to source env"
tmux new-session -s $TMUX_ENV -n backend -c /home/jonas/dev/certainli/ nvim /home/jonas/dev/certainli/certainli-backend/ \; \
  new-window -n frontend nvim /home/jonas/dev/certainli/certainli-frontend/ \; \
  new-window -n pyapi nvim /home/jonas/dev/certainli/certainli-pyapi/ \; \
