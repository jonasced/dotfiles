#!/bin/bash
# ferroamp setup
TMUX_ENV=ssh
# Check if session is already active
if tmux list-sessions | grep $TMUX_ENV; then
  echo "Attaching to previous session"
  tmux attach -t$TMUX_ENV
  exit
fi

cat ~/.ssh/id_ed25519.pub | ssh ferroamp ferro-sign > ~/.ssh/ferroamp-cert.pub
sleep 1

systemd-run --user --scope --slice=session.slice --unit=tmux-ssh -- tmux new-session -s $TMUX_ENV -n term -c /home/jmj/dev/ferroamp/ \; \
  new-window -n 15174 -c /home/jmj/dev/ferroamp/ \; \
  send-keys 'ssh fe-ace-15174 # ci-cd turkey' C-m \; \
  new-window -n 5927 -c /home/jmj/dev/ferroamp/ \; \
  send-keys 'ssh fe-ace-5927 # black swan' C-m \; \
  new-window -n 6125 -c /home/jmj/dev/ferroamp/ \; \
  send-keys 'ssh fe-ace-6125 # grouse' C-m \; \
  new-window -n 5040 -c /home/jmj/dev/ferroamp/ \; \
  send-keys 'ssh fe-ace-5040 # showroom' C-m \; \
  new-window -n 4502 -c /home/jmj/dev/ferroamp/ \; \
  send-keys 'ssh fe-ace-4502 # sunbird sso' C-m \; \
  new-window -n 4423 -c /home/jmj/dev/ferroamp/ \; \
  send-keys 'ssh fe-ace-4423 # sunbird single' C-m \; \
  new-window -n 3621 -c /home/jmj/dev/ferroamp/ \; \
  send-keys 'ssh fe-ace-3621 # sunbird single' C-m \; \
