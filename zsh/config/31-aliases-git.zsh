# 31-aliases-git.zsh - Git aliases

# Reset and clean
alias nope='git reset --hard;git clean -df'

# Push/Pull operations
alias pushlive="git push origin master && git push live master"
alias pushmaster='git push origin master'
alias pom="git pull origin master"

# Cleanup
alias gclean='git clean -df' # Remove all untracked files & directories

# Commit shortcuts
alias wip="git add . && git commit -m ' Fixed what needed fixing and squished some bugs. :bug:'"
alias fix="git diff --name-only | uniq | xargs code"
alias undocommit="git reset HEAD~1"
alias yolo="git add . && git commit -m \"\$(whatthecommit)\""
alias donetoday="git add . && git commit -m 'To be honest, I do not quite remember everyting I changed here today ¯\_(ツ)_/¯ But it is all good, I tell ya.'"

# Log
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
