# 42-functions-git.zsh - Git utility functions

# Delete all branches except the specified one
dbranch () {
  git branch | grep -v $1 | xargs git branch -D
}
