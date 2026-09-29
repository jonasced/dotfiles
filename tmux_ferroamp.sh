#!/bin/bash
# ferroamp setup
TMUX_ENV=ferroamp
# Check if session is already active
if tmux list-sessions | grep $TMUX_ENV; then
  echo "Attaching to previous session"
  tmux attach -t$TMUX_ENV
  exit
fi

systemd-run --user --scope --slice=session.slice --unit=tmux-ferroamp -- tmux new-session -s $TMUX_ENV -n ehubapps -c /home/jmj/dev/ferroamp/ \; \
  send-keys 'cd ehubapps/poetry-lock-ehub2/' C-m \; \
  send-keys 'eval "$( poetry env activate )"' C-m \; \
  send-keys 'cd ..' C-m \; \
  send-keys 'nvim .' C-m \; \
  new-window -n ferroai -c /home/jmj/dev/ferroamp/ferroamp-optimization-algorithms/ \; \
  send-keys 'source .venv/bin/activate' C-m \; \
  send-keys 'nvim .' C-m \; \
  new-window -n ferroai -c /home/jmj/dev/ferroamp/ferroamp-optimization-algorithms-2/ \; \
  send-keys 'source .venv/bin/activate' C-m \; \
  send-keys 'nvim .' C-m \; \
  new-window -n ferro-schemas -c /home/jmj/dev/ferroamp/ferro-schemas/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n ferroamp-os -c /home/jmj/dev/ferroamp/ferroamp-os/ \; \
  send-keys 'nvim .' C-m \; \
  new-window -n cont-deploy -c /home/jmj/dev/ferroamp/ferroamp-os-continuous-deploy/ \; \
  send-keys 'nvim .' C-m \; \
  # new-window -n eegw -c /home/jmj/dev/ferroamp/ehub-ecloud-gateway/ \; \
  # send-keys 'eval "$( poetry env activate )"' C-m \; \
  # send-keys 'nvim .' C-m \; \
  # new-window -n artifacts -c /home/jmj/dev/ferroamp/artifacts/ \; \
  # send-keys 'pyenv activate install-patch' C-m \; \

# new-window -n ancser-poc -c /home/jmj/dev/ferroamp/ancser-poc/ \; \
# send-keys 'nvim .' C-m \; \
# new-window -n meta-ferroamp -c /home/jmj/dev/ferroamp/meta-ferroamp/ \; \
# send-keys 'nvim .' C-m \; \
# send-keys 'nvim .' C-m \; \
