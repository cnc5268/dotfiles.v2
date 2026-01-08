if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting	"Welcome to 🎣️"
end

bind \b backward-kill-word

alias neofetch="fastfetch"

#oh-my-posh --init --shell fish --config $HOME/.config/ohmyposh/themes/zash.toml | source

set fish_color_autosuggestion '#4F5E68'
set fish_color_cancel -r
set fish_color_command '#CFC1BA'
set fish_color_comment red
set fish_color_cwd green
set fish_color_cwd_root red
set fish_color_end green
set fish_color_error '#A8334C'
set fish_color_escape brcyan
set fish_color_history_current --bold
set fish_color_host normal
set fish_color_host_remote '#F88379'
set fish_color_keyword '#4F5E68'
set fish_color_normal normal
set fish_color_operator brcyan
set fish_color_param cyan
set fish_color_quote yellow
set fish_color_redirection 'cyan'  '--bold'
set fish_color_search_match 'bryellow'  '--background=brblack'
set fish_color_selection 'white'  '--bold'  '--background=brblack'
set fish_color_status red
set fish_color_user '#F88379'
set fish_color_valid_path '#CFC1BA'

