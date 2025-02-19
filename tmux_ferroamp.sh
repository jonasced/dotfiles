#!/bin/bash
# ferroamp setup
TMUX_ENV=ferroamp
# Check if session is already active
if tmux list-sessions | grep $TMUX_ENV; then
  echo "Attaching to previous session"
  tmux attach -t$TMUX_ENV
  exit
fi

tmux new-session -s $TMUX_ENV -n ehubapps -c /home/jonas/dev/ferroamp/ \; \
  send-keys 'cd ehubapps/poetry-lock-ehub2/' C-m \; \
  send-keys 'eval "$( poetry env activate )"' C-m \; \
  send-keys 'cd ..' C-m \; \
  send-keys 'nvim .' C-m \; \
  new-window -n ferroamp-os -c /home/jonas/dev/ferroamp/ferroamp-os/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n ferroai -c /home/jonas/dev/ferroamp/ferroamp-optimization-algorithms/ \; \
  send-keys 'eval "$( poetry env activate )"' C-m \; \
  send-keys 'nvim .' C-m \; \
  new-window -n eegw -c /home/jonas/dev/ferroamp/ehub-ecloud-gateway/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n ferro-schemas -c /home/jonas/dev/ferroamp/ferro-schemas/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n ancser-poc -c /home/jonas/dev/ferroamp/ancser-poc/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n cont-deploy -c /home/jonas/dev/ferroamp/ferroamp-os-continuous-deploy/ \; \
  send-keys 'nvim .' C-m \; \

# new-window -n meta-ferroamp -c /home/jonas/dev/ferroamp/meta-ferroamp/ \; \
# send-keys 'nvim .' C-m \; \
# new-window -n artifacts -c /home/jonas/dev/ferroamp/artifacts/ \; \
# send-keys 'nvim .' C-m \; \
