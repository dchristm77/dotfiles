
# Enable vi mode
bindkey -v

export EDITOR=nvim
export VISUAL=nvim

export XDG_CONFIG_HOME=~/.config

alias ll='ls -al'
alias mfa=~/.aws/get-aws-creds.sh
alias vim=nvim
alias tree="find . -print -maxdepth 3 | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

#Tab completion
autoload -Uz compinit && compinit

# history setup
HISTFILE=$HOME/.zsh_history
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

#Git prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%b'

export CONF_ENV=dev
export AWS_SDK_LOAD_CONFIG=1

# Unbind the escape-/ binding because it gets triggered when I try to do a history search with "/".
bindkey -r '^[/'

. "$HOME/.asdf/asdf.sh"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
fi

source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/opt/pkg/sdkman"
[[ -s "/opt/pkg/sdkman/bin/sdkman-init.sh" ]] && source "/opt/pkg/sdkman/bin/sdkman-init.sh"
