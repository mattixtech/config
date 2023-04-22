fish_add_path /Users/mattix/.cargo/bin 
fish_add_path /opt/homebrew/bin 

fish_vi_key_bindings insert

zoxide init fish | source
starship init fish | source

abbr -a ls exa
abbr -a ll exa -lahr
abbr -a cgo cargo
abbr -a cd z
abbr -a nv nvim
abbr -a cat bat -P --style=plain
abbr -a procs procs --pager disable -t

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursor to an underscore
set fish_cursor_replace_one underscore
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block

function fish_greeting
    # neofetch
end

# if status is-interactive
#     if ! set -q TMUX
# 		exec tmux
# 	end
# end
