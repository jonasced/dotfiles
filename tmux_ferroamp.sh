#!/bin/bash
# ferroamp setup
TMUX_ENV=ferroamp
# Check if session is already active
if tmux list-sessions | grep $TMUX_ENV; then
  echo "Attaching to previous session"
  tmux attach -t$TMUX_ENV
  exit
fi

source /home/jonas/dev/ferroamp/ehubapps/poetry-lock-ehub2/.venv/bin/activate || echo "failed to source env"
tmux new-session -s $TMUX_ENV -n ehubapps -c /home/jonas/dev/ferroamp/ nvim /home/jonas/dev/ferroamp/ehubapps/ \; \
  new-window -n ferroamp-os nvim /home/jonas/dev/ferroamp/ferroamp-os/ \; \
  new-window -n meta-ferroamp nvim /home/jonas/dev/ferroamp/meta-ferroamp/ \; \
  new-window -n ferro-schemas nvim /home/jonas/dev/ferroamp/ferro-schemas/ \; \
  new-window -n ancser-poc nvim /home/jonas/dev/ferroamp/ancser-poc/ \; \
  new-window -n artifacts nvim /home/jonas/dev/ferroamp/artifacts/
