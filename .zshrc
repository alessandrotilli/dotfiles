[ -r ~/.aliases ] && source ~/.aliases

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Android sdk stuff...
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/Contents/Home

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST

function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=''
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}✗$LAST_EXIT_CODE%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  else
    echo "%{$fg[green]%}✔%{$reset_color%}"
  fi
}

NEWLINE=$'\n'
source "$(brew --prefix)/opt/zsh-git-prompt/zshrc.sh"
PROMPT='$(check_last_exit_code) %~%b $(git_super_status) $NEWLINE$ '

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
