#!/bin/bash
# Viernes, Abril 11/2014
# Script para instalar solo los paquetes necesarios para mi equipo
# Developed by abr4xas <me@abr4xas.org>

if [[ $USER != root ]]; then
	echo "##########################################"
	echo "# Error: Debe tener privilegios de ROOT ##"
	echo "##########################################"
   exit 1
fi
apt-get update -q
apt-get update -y
## Alguna dependencia rota
apt-get install -f
add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get install -y git nodejs irssi filezilla squid3 ruby2.0 libreoffice-l10n-es
gem install sass
## squid.conf pertenece a @sinfallas
sed -i 's_tmpfs /var/spool_#tmpfs /var/spool_g' /etc/fstab
mkdir -p /var/spool/squid3
chown -R root /var/spool/squid3
chmod -R 0766 /var/spool/squid3
service squid3 stop
echo "http_port 3128" > /etc/squid3/squid.conf
echo "icp_port 0" >> /etc/squid3/squid.conf
echo "htcp_port 0" >> /etc/squid3/squid.conf
echo "snmp_port 0" >> /etc/squid3/squid.conf
echo "coredump_dir /var/spool/squid3" >> /etc/squid3/squid.conf
echo "access_log /var/log/squid3/access.log" >> /etc/squid3/squid.conf
echo "cache_log /var/log/squid3/cache.log" >> /etc/squid3/squid.conf
echo "cache_mem 256 MB" >> /etc/squid3/squid.conf
echo "maximum_object_size_in_memory 1024 KB" >> /etc/squid3/squid.conf
echo "maximum_object_size 50 MB" >> /etc/squid3/squid.conf
echo "cache_replacement_policy heap LFUDA" >> /etc/squid3/squid.conf
echo "memory_replacement_policy heap LFUDA" >> /etc/squid3/squid.conf
echo "cache_dir aufs /var/spool/squid3 8192 128 128" >> /etc/squid3/squid.conf
echo "pipeline_prefetch on" >> /etc/squid3/squid.conf
echo "shutdown_lifetime 2 second" >> /etc/squid3/squid.conf
echo "acl all src all" >> /etc/squid3/squid.conf
echo "acl localhost src 127.0.0.1/32" >> /etc/squid3/squid.conf
echo "acl to_localhost dst 127.0.0.0/8 0.0.0.0/32" >> /etc/squid3/squid.conf
echo "acl localnet src 192.168.1.0/24 # internal network" >> /etc/squid3/squid.conf
echo "acl SSL_ports port 443 # https" >> /etc/squid3/squid.conf
echo "acl SSL_ports port 563 # snews" >> /etc/squid3/squid.conf
echo "acl SSL_ports port 873 # rsync" >> /etc/squid3/squid.conf
echo "acl Safe_ports port 80 # http" >> /etc/squid3/squid.conf
echo "acl Safe_ports port 21 # ftp" >> /etc/squid3/squid.conf
echo "acl Safe_ports port 443 # https" >> /etc/squid3/squid.conf
echo "acl Safe_ports port 70 # gopher" >> /etc/squid3/squid.conf
echo "acl Safe_ports port 210 # wais" >> /etc/squid3/squid.conf
echo "acl Safe_ports port 1025-65535 # unregistered ports" >> /etc/squid3/squid.conf
echo "acl Safe_ports port 280 # http-mgmt" >> /etc/squid3/squid.conf
echo "acl Safe_ports port 488 # gss-http" >> /etc/squid3/squid.conf
echo "acl Safe_ports port 591 # filemaker" >> /etc/squid3/squid.conf
echo "acl Safe_ports port 777 # multiling http" >> /etc/squid3/squid.conf
echo "acl Safe_ports port 631 # cups" >> /etc/squid3/squid.conf
echo "acl Safe_ports port 873 # rsync" >> /etc/squid3/squid.conf
echo "acl Safe_ports port 901 # SWAT" >> /etc/squid3/squid.conf
echo "acl downloads urlpath_regex [-i] \.dll$ \.bin$ \.cab$ \.asx$ \.vbs$ \.bat$ \.lnk$ \.scr$ \.pif$ \.msi$ \.exe$ \.mp3$ \.wmv$ \.zip$ \.mpg$ \.torrent$ \.ppt$ \.rar$ \.avi$ \.flv$ \.pps$ \.wma$" >> /etc/squid3/squid.conf
echo "acl purge method PURGE" >> /etc/squid3/squid.conf
echo "acl CONNECT method CONNECT" >> /etc/squid3/squid.conf
echo "http_access allow purge localhost" >> /etc/squid3/squid.conf
echo "http_access deny purge" >> /etc/squid3/squid.conf
echo "http_access allow to_localhost" >> /etc/squid3/squid.conf
echo "http_access allow localnet" >> /etc/squid3/squid.conf
echo "http_access allow localhost" >> /etc/squid3/squid.conf
echo "http_access allow downloads" >> /etc/squid3/squid.conf
echo "http_access deny !Safe_ports" >> /etc/squid3/squid.conf
echo "http_access deny CONNECT !SSL_ports" >> /etc/squid3/squid.conf
echo "http_access allow all" >> /etc/squid3/squid.conf
squid3 -z
service squid3 start
echo "export http_proxy=http://127.0.0.1:3128/" >> /root/.bashrc
echo "export https_proxy=http://127.0.0.1:3128/" >> /root/.bashrc
echo "export ftp_proxy=http://127.0.0.1:3128/" >> /root/.bashrc
apt-get autoremove -y