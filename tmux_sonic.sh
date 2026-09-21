#!/bin/bash
# ferroamp setup
TMUX_ENV=sonic
# Check if session is already active
if tmux list-sessions | grep $TMUX_ENV; then
  echo "Attaching to previous session"
  tmux attach -t$TMUX_ENV
  exit
fi

tmux new-session -s $TMUX_ENV -n ehubapps -c /home/jmj/ \; \
  send-keys 'cd ehubapps/poetry-lock-ehub2/' C-m \; \
  send-keys 'eval "$( poetry env activate )"' C-m \; \
  send-keys 'cd ..' C-m \; \
  send-keys 'nvim .' C-m \; \
  new-window -n ferro-schemas -c /home/jmj/ferro-schemas/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n os -c /home/jmj/dev/ferroamp/newest-os/ferroamp-os/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n os-ehubapps -c /home/jmj/newest-os/ferroamp-os/apps/ehubapps/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n os-meta -c /home/jmj/newest-os/ferroamp-os/sources/meta-ferroamp/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n dotfiles -c /home/jmj/.dotfiles/ \; \
  send-keys 'nvim .' C-m \; \

# new-window -n ferroamp-os -c /home/jmj/dev/ferroamp/ferroamp-os/ \; \
# send-keys 'nvim .' C-m \; \
# new-window -n ancser-poc -c /home/jmj/dev/ferroamp/ancser-poc/ \; \
# send-keys 'nvim .' C-m \; \
# new-window -n meta-ferroamp -c /home/jmj/dev/ferroamp/meta-ferroamp/ \; \
# send-keys 'nvim .' C-m \; \
# send-keys 'nvim .' C-m \; \
