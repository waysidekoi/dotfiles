# Change tmux title to command name before executing
# function preexec() {
#   if [[ $TERM =~ screen ]]; then
#     # strip bundle exec and only print first word of command
#     TITLE=$(echo $1 | sed 's/bundle exec//' | awk '{print $1;}')
#     CWD=$(basename $(pwd))
#     tmux rename-window "$CWD-$TITLE"
#   fi
# }
#
# # Change tmux title to cwd after command
# function precmd() {
#   if [[ $TERM =~ screen ]]; then
#     CWD=$(basename $(pwd))
#     tmux rename-window $CWD
#   fi
# }
