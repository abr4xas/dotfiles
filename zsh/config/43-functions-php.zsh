# 43-functions-php.zsh - PHP testing functions

# Run Pest or PHPUnit tests
function p() {
   if [ -f vendor/bin/pest ]; then
      vendor/bin/pest "$@"
   else
      vendor/bin/phpunit "$@"
   fi
}

# Run tests with filter
function pf() {
   if [ -f vendor/bin/pest ]; then
      vendor/bin/pest --filter "$@"
   else
      vendor/bin/phpunit --filter "$@"
   fi
}
