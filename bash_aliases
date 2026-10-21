#!/bin/bash

# Restart wayland only, keep user running
# Combined with systemd-run --user --scope --slice=session.slice --unit=tmux-ferroamp -- tmux new-session -s ... 
# from tmux_xxx scripts this only restarts the graphical interface and not the tmux sessions I'm running
# Requires Linger=yes, set by loginctl enable-linger <USER> 2>&1
alias restartwayland='systemctl --user restart wayland-wm@hyprland.desktop.service'

# Sonic remote command alias
alias scargo="$HOME/.dotfiles/scripts/sonic-cargo"

# Custom agent alias
alias agent='/srv/sandbox/tmux_agent.sh'
# Custom dotfile aliases
alias ferroamp="$HOME/.dotfiles/tmux_ferroamp.sh"
alias sonic="$HOME/.dotfiles/tmux_sonic.sh"
alias misc="$HOME/.dotfiles/tmux_misc.sh"
alias ferrossh="$HOME/.dotfiles/tmux_ferrossh.sh"
alias kanatastart="sudo $HOME/.cargo/bin/kanata --cfg $HOME/.dotfiles/kanata/engswe_capslock_ctrlescape_vimkeys.kbd"

# Jira aliases
alias mywork='jira issue ls -s~Cancelled -s~Done -s~Backlog -a$(jira me) --order-by updated'
alias mytodo='jira issue ls -s"To Do" -a$(jira me) --order-by priority'
alias mybacklog='jira issue ls -sBacklog -a$(jira me) --order-by priority'
alias epics='jira epic ls --order-by priority -s~Cancelled -s~Done'


# Git aliases
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff | mate'
alias gau='git add --update'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gcotb='git checkout --track -b'
alias glog='git log'
alias glogp='git log --pretty=format:"%h %s" --graph'

alias grbc='git rebase --continue'

# hgrep https://askubuntu.com/questions/74631/how-do-i-search-my-command-line-history-for-commands-i-used-before
# hgrep () {
#     history | egrep --color=auto --recursive "$@" | egrep --color=auto --recursive -v "hgrep $@"
# }


alias hgrep='history | grep --color=auto '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
