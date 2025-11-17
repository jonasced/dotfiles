# Dotfiles

This repo contains my dot files used to configure the local Linux account and some of the installed
applications.

## Installation

The dot files are "installed" from this repo by creating a bunch of symlinks. This is done with the
help of a command-line utility [rcm](https://github.com/thoughtbot/rcm). The steps are as follows:

1. Install the dotfiles management utility [rcm](https://github.com/thoughtbot/rcm)
2. Clone the repo to your Linux home directory, `~/.`, as follows

```sh
git clone https://github.com/oshevtsov/dotfiles.git ~/.dotfiles
```

3. Go to the cloned directory, `cd ~/.dotfiles`
4. Run the following command to create the symlinks (the `-v` flag stand for "verbose" and is
   optional). Run this command again after every new dotfile you want to track is added.

```
rcup -v
```

5. Make sure that all the core programs required by the dotfiles are installed. Google them for respective installation.

- tmux
- neovim (run `:checkhealth` to see what is missing)
  - install is easiest by placing the appimage at the path /opt/nvim/nvim
- nodejs (use nvm!)
- ripgrep
- fd-find

6. Install terminal dependencies that are required as well.
- ohmyzsh for more terminal niceness
- zoxide (for nice path auto-completes)
- kanata (for re-binding keys, used in misc tmux setup command)
- atuin (for a nice ctrl+r experience)
- lazygit (super nice neovim git handling. https://github.com/jesseduffield/lazygit?tab=readme-ov-file#ubuntu)
  - For opening files from lazygit in terminal in neovim: https://github.com/kdheepak/lazygit.nvim/issues/22
- bash-git-prompt (for a nice git terminal line experience. fancygit is an alternative)
   - My fork works for this symlink in bash: git@github.com:jonasced/bash-git-prompt.git
- (porsmo for a nice timer)

- pyenv for handling local python installations

7. For some of the icons you need to setup NerdIcons. See github repository for that

8. For clipboard usage in Neovim, install xsel or something of the sort.

9. For python usage, create a venv at the path specified by the python3_host_prog setting and install pynvim there.

10. Other misc things I've installed which are useful but not dependencies
- delta for git syntax highlights (used in gitconfig) https://github.com/dandavison/delta
  - Needs following config in .config/lazygit/config.yml:
  ```
  paging:
    colorArg: always
    pager: "delta --dark --paging=never --line-numbers"
    useConfig: false
  ```
- uv for installing system wide tools such as tox, ruff, mypy etc
- pipx for similar purposes, poetry/pre-commit for example
- git-absorb (for nice quick fixups) (https://github.com/tummychow/git-absorb?tab=readme-ov-file)
- Codeium for Neovim (some AI has never hurt anyone)
- starship for a nice terminal prompt (https://starship.rs/guide/)
- ghostty for a experminetal terminal emulator (set gtk-titlebar = false to not have the ugly titlebar)
  - Setup by following https://askubuntu.com/questions/578293/is-it-possible-to-remove-the-default-terminal-and-replace-it-with-some-other-ter
  - Essentially mapping the terminal emulator of choice to the /home/jonas/bin/ folder with the name gnome-terminal (the default one)
  - to overwrite it.
  - BUG: this does not work! it seems like ghostty runs differently than gnome-terminal, it stays open in the window it is called from
  - BUG: also it appears to not shut down properly: blank window is left after ctrl+d, so quitting is neccessary
  - BUG: randomly shut down all my ghostty terminals when quitting one
  - FEATURE: nicer red under faulty code in neovim when opened in ghostty than gnome
  - Config needed to hide title bar
      window-decoration = "none"


## Notes

### Kanata
Added config for better nvim usage. Run in background:
`sudo /home/jonas/.cargo/bin/kanata --cfg /home/jonas/.dotfiles/kanata/engswe_capslock_ctrlescape_vimkeys.kbd`
TODO: Add as systemd service if this works nicely. Current workaround is to have a tmux alias for opening misc which calls this.
- https://github.com/jtroo/kanata/wiki/Avoid-using-sudo-on-Linux
- https://github.com/jtroo/kanata/discussions/130

I've also discovered that you can map arbitrary unicode characters as well! Added delta and swedish to the layer for arrows
(Also, in linux you can type ctrl+shift+u and then the unicode in hex.)

### tmux
Notify when process is done by prefix + m! (https://github.com/rickstaa/tmux-notify)

#### Pane workflow
You can have a separate pane next to neovim. Sometimes you want to move it however, see below

C-b ! -> break pane to new window

:resize-pane Up/Do/Le/Ri # cells to resize
:join-pane -s (from there to here) / -t (this to there) s:x.x (session:window.pane)

### Rust

There are some behaviors of `rust-analyzer` and the way it interacts with Neovim that may make you think your
setup is broken. For example, if you are working with a cargo workspace and do not see error diagnostics
from the on-save command (`clippy`), this is most probably because it is stuck in another crate within the
workspace and didn't make it through to the file you are working with right now. The command that is run
by `rust-analyzer` is:

```shell
cargo clippy --workspace --message-format=json --all-targets --manifest-path <path-to-workspace>/Cargo.toml
```

You may run it manually and see where `clippy` got stuck. What may seem more surprising though is that using
the built-in `check` instead of `clippy` is more resilient and can show errors in the file you are working
with, while still having failed diagnostics elsewhere within the workspace.

### Neovim
:help is your friend. :helpgrep "<pattern>" is also very useful.

#### Closing all but the active buffer
Magic!
:w|%bd|e#
How it works: first write current buffer's changes, then close all open buffers, then reopen the buffer I was currently on. In Vim, the | chains the execution of commands together. If your buffer is up to date the above can be shortened to :%bd | e#

#### Going to lsp notes (error, warning, note etc)
Bound to `[d`, and `]d`

#### Code folding
Search for opening and closing folds in help


#### Inspecting code
K (uppercase) opens documentation of variable/function/class etc.

#### Tabpage
The number in the top right is tabs! See tabpage for info

#### Jumps
Jumps in neovim! Use CTRL-] to jump to definition, CTRL-O for older and CTRL-I for newer in jump list. See jump list with :ju

#### Listing all X in file (func def, classes etc)
`:help global`
Find all lines that match keyword:
`:g/<keyword>`

#### Telescope
<leader>-sk opens up keybindings! There are many neat ones followed by the leader, currently set to spacebar:
ff, fg, e, o.

:help telescope of course, there you can find more.

live_grep_args
find_files

##### Search and replace in several files
You can also use telescope to help with search and replace in several files!
0. Yank the text you want to replace.
1. Telescope for `TEXT` you want to replace in the directory where it occurrs
2. Ctrl+Q to bring up the quickfix list
3. Run `:cdo %s/TEXT/NEWTEXT/gc` to replace
You could do this on an entire folder strcuture but this process avoids attempting to replace the text in files where it does not exist, something that takes quite some time otherwise.

Searching for a multi-line pattern can be done as follows, \_.* allows matching across multiple lines \v enables very magic mode for easier regex:
```
:%s/\v(start_pattern\_.*end_pattern)/replacement/g
```



#### Formatting, linting and language servers
This has been a whole tangent. Languange servers setup in mason-lspconfig can overlap with nvim-lint and formatter, making it hard to know who's doing what.

##### Python
For Python I recommend using only lsp or lint+formatter. Defining an intersection seems more work than its worth.
The LSP does live hinting while the lint+formatter only does on save, so I opted for LSP. It already had some plugins
installed (for example flake8 which is also available as linter) so seems like the superior option.

#### Windows
Guide below, long story short: CTRL-W is the keyword, navigation is obvious.
Split on S, vertical on V, close on Q.
For more -> :help window

#### Explore files
:Sexplore is neat for searching around in directories.
:cd to move around (useful for changing telescope context)

#### Gitsigns
gt, gc, gd, gh... (use space-sk to find all)
For smooth git usage, use hunks! Available in keybinding settings. Combine status, hunks and the :Git commit for smooth workflows

#### Bufferline
The plugin that controls the buffers visible at the top of the window when you've jumped between files! Commands are available as :Bufferline...
:help bufferline

#### Line wrapping
Remember, if you want to wrap lines use `:set wrap`, reset with `:set nowrap`

#### Formatting json
Magic `:%!jq '.'` from https://codegoalie.com/posts/format-json-nvim-jq/, discussed here: https://www.reddit.com/r/neovim/comments/xa4ca6/best_way_to_validate_and_format_json_files/

### Git tips

Find deleted file:
git log --all --full-history -- "**/thefile.*"


Specific parts of file blame/log
git blame -L 15,25:path/to/file
git log -L 15,25:path/to/file
git log -L :Function:path/to/file

Ignore whitespace, or copied in the same commit , or the commit that created the file, or any commit at all
git blame -w -C -C -C

Match regex of log only
git log -S file_watcher -p

What have you done?
git reflog

Line based diff default, word diff possible
git diff --word-diff

Avoid having to solve the same conflict twice
git config --global rerere.enabled true


git branch --column
git config --global column.ui true
branch.sort committerdate


Checks if fetch is needed, if your ref is the last on the server. Safety so you don't accidentally force push over someone elses work
git push --force-with-lease

Sign commits with SSH? Needed?

Runs cronjobs in the background every hour, speeeeed.
git maintenance start

git commit-graph write

Faster git status
core.fsmonitor true

##### Remotes, authentications and forks

When forking a repo you might use HTTPS. If you want to push to your own fork, then you have to
1. Set to your remote instead of the original repo by adding `git remote add myrepo /path/to/remote`
   (https://stackoverflow.com/a/25546211)
2. Set the remote to use ssh instead of https by either entering a ssh remote directly or editing the .git/config file
   (https://stackoverflow.com/a/10909299)
3. As said in the first thread, `git push -u myrepo master` for pushing and setting it to default for future pushes


##### BIG repo stuff
git clone --filter:blob:none
git clone --filter:tree:0

If you have a lot of subdirectories but only want to work on one:
sparse-checkout

##### Several users for github on the same computer
This thread has some tips: https://stackoverflow.com/questions/4220416/can-i-specify-multiple-users-for-myself-in-gitconfig
Boils down to adding custom ssh hosts, such as:
```
# Default GitHub
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519

# Professional github alias
Host github_certainli
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_certainli_ed25519
```
and then authenticating using git@github_certainli instead for those repos.
