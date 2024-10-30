#!/bin/bash
# ferroamp setup
source /home/jonas/dev/ferroamp/ehubapps/.venv/bin/activate || echo "failed to source env"
tmux new-session -s dev -n ehubapps -c /home/jonas/dev/ferroamp/ nvim /home/jonas/dev/ferroamp/ehubapps/ \; \
  new-window -n ferroamp-os nvim /home/jonas/dev/ferroamp/ferroamp-os/ \; \
  new-window -n meta-ferroamp nvim /home/jonas/dev/ferroamp/meta-ferroamp/ \; \
  new-window -n ferro-schemas nvim /home/jonas/dev/ferroamp/ferro-schemas/ \; \
  new-window -n ancser-poc nvim /home/jonas/dev/ferroamp/ancser-poc/ \; \
  new-window -n artifacts nvim /home/jonas/dev/ferroamp/artifacts/
