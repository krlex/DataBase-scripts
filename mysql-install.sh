#!/usr/bin/env bash

install_debian() {
  $SUDO apt update
  $SUDO apt install -y curl wget mariadb-server
  $SUDO apt clean

  clear
  echo " Mariadb is ready for Debian "
  echo " Config root user and password "
  echo " "
  echo " sudo mysql_secure_installation "

}

install_ubuntu() {
  $SUDO apt update
  $SUDO apt install curl wget mariadb-server -y

  clear
  echo " Mariadb is ready for Ubuntu "
  echo " Config root user and password "
  echo " "
  echo " sudo mysql_secure_installation "

}

install_fedora() {
  $SUDO dnf update -y
  $SUDO dnf -y install dnf-plugins-core curl wget mariadb-server

  $SUDO dnf makecache
  $SUDO dnf update

  clear
  echo " Mariadb is ready for Fedora "
  echo " Config root user and password "
  echo " "
  echo " sudo mysql_secure_installation "

}

install_centos() {
  $SUDO yum update -y
  $SUDO yum install -y yum-utils curl wget  mariadb-server

  clear
  echo " Mariadb is ready for CentOS "
  echo " Config root user and password "
  echo " "
  echo " sudo mysql_secure_installation "

}

usage() {
  echo
  echo "Linux distribution not detected"
  echo "Use: ID=[ubuntu|debian|centos|fedora]"
  echo "Other distribution not yet supported"
  echo

}

if [ -f /etc/os-release ]; then
  . /etc/os-release
elif [ -f /etc/debian_version ]; then
  $ID=debian
fi

if [[ $EUID -ne 0 ]]; then
  SUDO='sudo -H'
else
  SUDO=''
fi

case $ID in
        'ubuntu')
                install_ubuntu
        ;;
        'debian')
                install_debian
        ;;
        'centos')
                install_centos
        ;;
        'fedora')
                install_fedora
        ;;
        *)
          usage
        ;;
esac
