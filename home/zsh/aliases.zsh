alias reload!='. ~/.zshrc'
alias e='vim'

alias vim='/usr/local/bin/mvim -v'

# cd
alias ..='cd ..'


# ruby
alias be='bundle exec'
alias eb='export PATH=./bin:$PATH'


# git
# alias gl='git pull --prune'
# alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
# alias gp='git push'
# alias gd='git diff'
# alias gc='git commit'
# alias gca='git commit -a'
# alias gco='git checkout'
# alias gb='git branch'
# alias gs='git status -sb'
# alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"

# docker
alias dk='docker'


# shortcut to add aliases
alias zea='$EDITOR ~/.zsh/aliases.zsh'

# todo.sh: https://github.com/ginatrapani/todo.txt-cli
function t() {
  if [ $# -eq 0 ]; then
    todo.sh ls
  else
    todo.sh $*
  fi
}

# always start tmux with 256 color support
alias tmux="tmux -2"
