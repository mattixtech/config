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
set fish_vi_force_cursor yes
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

function fish_greeting
end

