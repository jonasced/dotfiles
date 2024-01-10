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
   optional)

```
rcup -v
```

5. Make sure that all the necessary programs required by the dotfiles are installed

- tmux
- neovim (run `:checkhealth` to see what is missing)
- nodejs
- ripgrep
- fd-find

6. For some of the icons you need to setup NerdIcons. See github repository for that

7. For clipboard usage in Neovim, install xsel or something of the sort.

8. For python usage, create a venv at the path specified by the python3_host_prog setting and install pynvim there.

## Notes

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

#### Inspecting code
K opens documentation of variable/function/class etc.

#### Jumps
Jumps in neovim! Use CTRL-] to jump, CTRL-O for older and CTRL-I for newer in jump list. See jump list with :ju

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
