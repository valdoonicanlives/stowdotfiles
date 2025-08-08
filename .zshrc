setopt interactivecomments
source /home/delboy/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

source /home/delboy/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



# source extra config file, all files tht end in .zsh will be used
for config (~/.zsh/*.zsh) source $config  
# Extend PATH.
# finaly this one below works and scripts can run from ~/bin without typing the full path
path=(~/.bin $path)

# Export environment variables.
export GPG_TTY=$TTY

# Autoload functions.
autoload -Uz zmv

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_ignore_space
bindkey '^p' history-search-backward
bindkey '^n' history-serach-forward

# simplel prompt
PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

fzfchoose () {
    ~/.bin/fzfscriptmenu
}

## my added
function zzz()
{
systemctl suspend
}
# for z file dir helper
source /home/delboy/.zsh/zsh-z.plugin.zsh


# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu
. /home/delboy/.jrc
alias vj="cd ~/Documents/vimjournal && nvim \"$(date +%Y.%m.%d).txt\""
#alias zippass= "zip -er"
zippass() { zip -er "$1"}
