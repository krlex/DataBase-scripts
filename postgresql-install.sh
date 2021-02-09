#!/usr/bin/env bash

install_debian() {
  $SUDO apt update
  $SUDO apt install -y curl wget postgresql-11 postgresql postgresql-contrib
  $SUDO apt clean
  clear

  echo "initialize  and enabled the database"
  $SUDO systemctl start postgresql
  $SUDO systemctl enable postgresql

  clear
  echo " Postgresql is ready for Debian "
  echo " Config root user and password "
  echo " "
  echo " sudo su - postgres"

}

install_ubuntu() {
  $SUDO apt update
  $SUDO apt install -y curl wget postgresql-10 postgresql postgresql-contrib
  clear

  echo "initialize  and enabled the database"
  $SUDO systemctl start postgresql
  $SUDO systemctl enable postgresql

  clear
  echo " Postgresql is ready for Ubuntu "
  echo " Config root user and password "
  echo " "
  echo " sudo su - postgres"

}

install_fedora() {
  $SUDO dnf update -y
  $SUDO dnf -y install dnf-plugins-core curl wget postgresql-server  postgresql-contrib

  $SUDO dnf makecache
  $SUDO dnf update
  clear

  echo "initialize  and enabled the database"
  $SUDO postgresql-setup initdb
  $SUDO systemctl start postgresql
  $SUDO systemctl enable postgresql

  clear
  echo " Postgresql is ready for Fedora "
  echo " Config root user and password "
  echo " "
  echo " sudo passwd postgres "

}

install_centos() {
  $SUDO yum update -y
  $SUDO yum install -y yum-utils curl wget  postgresql-server  postgresql-contrib
  clear

  echo "initialize  and enabled the database"
  $SUDO postgresql-setup initdb
  $SUDO systemctl start postgresql
  $SUDO systemctl enable postgresql

  clear
  echo " Postgresql is ready for CentOS "
  echo " Config root user and password "
  echo " "
  echo " sudo passwd postgres "

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
