#!/bin/bash

nmapversion=$(nmap -V 2>/dev/null)
luaversion=$(lua -v 2>/dev/null)
luarocks=$(luarocks 2>/dev/null)

if [[ $nmapversion ]]; then
  echo "Nmap Installed"
  $nmapversion
else
  while true; do
    read -p "Do you wish to install nmap?" yn
    case $yn in
      [Yy]* ) make install; break;;
      [Nn]* ) break;;
      * ) echo "Please answer yes or no.";;
    esac
  done
fi

if [[ $luaversion ]]; then
  echo "Lua Installed"
  $luaversion
else
  while true; do
    read -p "Do you wish to install lua?" yn
    case $yn in
      [Yy]* ) make install; break;;
      [Nn]* ) break;;
      * ) echo "Please answer yes or no.";;
    esac
  done
fi

if [[ $luarocks ]]; then
  echo "Lua rocks installed"
  $luarocks
else
  while true; do
    read -p "Do you wish to install luarocks?" yn
    case $yn in
      [Yy]* ) make install; break;;
      [Nn]* ) break;;
      * ) echo "Please answer yes or no.";;
    esac
  done
fi


<<COMMENT1
dbpath=$(find /usr -type f -name "script.db" 2>/dev/null | awk 'gsub("script.db","")')
nmappath=$(find /usr -type f -name "nmap" 2>/dev/null)
luapath=$(find /usr -type f -name "lua" 2>/dev/null)
luarockspath=$(find /usr -type f -name "luarocks*" 2>/dev/null)

if [[ $dbpath ]]; then
  echo $dbpath
  echo -e "local settings = {} \n" > settings.lua
  echo -e "settings.scriptsPath='$dbpath'" >> settings.lua
  echo -e "settings.filePath = settings.scriptsPath..'script.db'" >> settings.lua
  echo -e "settings.fileBackup = 'scriptbkp.db'" >> settings.lua
  echo -e "settings.scriptdb = 'nmap_scripts.sqlite3'" >> settings.lua
  echo -e 'settings.categories = {"auth","broadcast","brute","default","discovery","dos","exploit","external","fuzzer","intrusive","malware","safe","version","vuln"}\n' >> settings.lua
  echo -e "return settings" >> settings.lua
fi

if [[ $nmappath ]]; then
  echo "Nmap Found $nmappath"
else
  echo "Installing Nmap"
fi

if [[ $luapath ]]; then
  echo "lua Found $nmappath"
else
  echo "Installing Lua"
fi

if [[ $luarockspath ]]; then
  echo "luarocks Found $luarockspath"
else
  echo "Installing Lua Rocks"
fi

ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')

if [ -f /etc/lsb-release ]; then
  . /etc/lsb-release
  OS=$DISTRIB_ID
  VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
  OS=Debian  # XXX or Ubuntu??
  VER=$(cat /etc/debian_version)
elif [ -f /etc/redhat-release ]; then
  echo "Use Yum"
else
  OS=$(uname -s)
  VER=$(uname -r)
fi
COMMENT1