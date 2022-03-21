alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias mkiso="hdiutil makehybrid -iso -joliet -o"

# git shortcuts
alias gps="git push"
alias gpl="git pull"
alias gfrs="git flow release start"
alias gfrf="git flow release finish"
alias gfhs="git flow hotfix start"
alias gfhf="git flow hotfix finish"
alias gffs="git flow feature start"
alias gfff="git flow feature finish"

# dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

