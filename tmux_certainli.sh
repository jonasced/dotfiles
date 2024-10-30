#!/bin/bash
# certainli setup
tmux new-session -s certainli -n backend -c /home/jonas/dev/certainli/ nvim /home/jonas/dev/certainli/certainli-backend/ \; \
  new-window -n frontend nvim /home/jonas/dev/certainli/certainli-frontend/ \; \
