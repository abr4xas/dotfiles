# 41-functions-docker.zsh - Docker utility functions

# Docker Compose shortcuts
dbuild() {
  docker-compose build
}

dstart() {
  docker-compose up -d
}

dexec() {
  docker-compose exec $1 bash
}

dstop () {
  docker-compose stop
}

# Get IP addresses of database containers
mysqlIp() {
  docker exec $1 ping mysql
}

mariaIp() {
  docker exec $1 ping mariadb
}

# Remove all Docker containers, images, and volumes
ddall () {
  docker stop $(docker ps -a -q)
  docker rm -f $(docker ps -a -q)
  docker rmi $(docker images -q)
  docker rm -v $(docker ps -a -q)
}

# Kill Docker Desktop app and VM (excluding vmnetd service)
function kdo() {
 ps ax|grep -i docker|egrep -iv 'grep|com.docker.vmnetd'|awk '{print $1}'|xargs kill
}
