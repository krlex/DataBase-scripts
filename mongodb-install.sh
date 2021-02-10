#!/usr/bin/env bash

install_debian() {
  $SUDO apt update
  $SUDO apt install -y curl wget gnupg
  $SUDO wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
  #$SUDO echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.4 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
  $SUDO echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
  $SUDO apt update
  $SUDO apt install -y mongodb-org mongodb-org-server
  $SUDO apt clean

  # Optional. Although you can specify any available version of MongoDB

  # echo "mongodb-org hold" | sudo dpkg --set-selections
  # echo "mongodb-org-server hold" | sudo dpkg --set-selections
  # echo "mongodb-org-shell hold" | sudo dpkg --set-selections
  # echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
  # echo "mongodb-org-tools hold" | sudo dpkg --set-selections

  clear

  echo "initialize  and enabled the database"
  $SUDO systemctl start mongod
  $SUDO systemctl enable mongod

  clear
  echo " Mongodb is ready for Debian "
  echo " Config root user and password "
  echo " "
  echo " sudo mongo"
  echo " For other help go to:"
  echo "https://docs.mongodb.com/manual/administration/install-on-linux/"

}

install_ubuntu() {

  $SUDO apt update
  $SUDO apt install -y curl wget gnupg
  $SUDO wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
  #$SUDO echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
  #$SUDO echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focial/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
  $SUDO echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
  $SUDO apt update
  $SUDO apt install -y mongodb-org
  $SUDO apt clean

  # Optional. Although you can specify any available version of MongoDB

  # echo "mongodb-org hold" | sudo dpkg --set-selections
  # echo "mongodb-org-server hold" | sudo dpkg --set-selections
  # echo "mongodb-org-shell hold" | sudo dpkg --set-selections
  # echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
  # echo "mongodb-org-tools hold" | sudo dpkg --set-selections

  clear

  echo "initialize  and enabled the database"
  $SUDO systemctl start mongod
  $SUDO systemctl enable mongod

  clear
  echo " Mongodb is ready for Ubuntu"
  echo " Config root user and password "
  echo " "
  echo " sudo mongo"
  echo " For other help go to:"
  echo "https://docs.mongodb.com/manual/administration/install-on-linux/"

}


install_fedora() {
  sh ./templates/fedora-repo.sh
  $SUDO dnf update -y
  $SUDO dnf -y install dnf-plugins-core curl wget mongodb-org mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools

  $SUDO dnf makecache
  $SUDO dnf update
  clear

  echo "initialize  and enabled the database"
  $SUDO systemctl start mongod
  $SUDO systemctl enable mongod

  clear
  echo " Mongodb is ready for Fedora "
  echo " Config root user and password "
  echo " "
  echo " sudo mongo"
  echo " For other help go to:"
  echo "https://docs.mongodb.com/manual/administration/install-on-linux/"

}

install_centos() {
  sh ./templates/centos-repo.sh
  $SUDO yum update -y
  $SUDO yum install -y yum-utils curl wget  mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools mongodb-org
  clear

  echo "initialize  and enabled the database"
  $SUDO systemctl start mongod
  $SUDO systemctl enable mongod

  clear
  echo " Mongodb is ready for CentOS "
  echo " Config root user and password "
  echo " "
  echo " sudo mongo"
  echo " For other help go to:"
  echo "https://docs.mongodb.com/manual/administration/install-on-linux/"

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
