```
================================================
  _   _  _____  _____                     _
 | \ | |/  ___||  ___|                   | |
 |  \| |\ `--. | |__    __ _  _ __   ___ | |__
 | . ` | `--. \|  __|  / _` || '__| / __|| '_ \
 | |\  |/\__/ /| |___ | (_| || |   | (__ | | | |
 \_| \_/\____/ \____/  \__,_||_|    \___||_| |_|
================================================
 Version 0.2     |   @jjtibaquira
================================================
```
### Nmap Script Enginee Search

### Description
#### nsearch , is a tool that helps you find scripts that are used nmap ( nse ) , can be searched using the name or category , it is also possible to see the documentation of the scripts found.

### Version
0.2

### Requeriments

#### Debian(Ubuntu)

```
# apt-get install unzip libreadline-gplv2-dev build-essential checkinstall unzip sqlite3 libsqlite3-dev -y
```

#### REDHAT(CentOS)

```
# yum -y install bzip2 groupinstall "Development Tools"
```

### Installation
#### To install the application is necessary run as root user the installation script (install.sh), for the time, the script is only for OS based on debian, for OS based on Red Hat (CentOS), MacOSX or other UNIX  it's better do the installation for each dependency manually.

#### Automatic Installation

```
# sh install.sh
```

#### Manual Installation

##### Nmap Installation

```
$ curl -R -O http://nmap.org/dist/nmap-6.47.tar.bz2
$ bzip2 -cd nmap-6.47.tar.bz2 | tar xvf -
$ cd nmap-6.47
$ ./configure && make
# make install
```

##### Lua Installation

```
$ cd /tmp
$ curl -R -O http://www.lua.org/ftp/lua-5.3.0.tar.gz
$ tar zxvf lua-5.3.0.tar.gz -C $HOME/
$ cd $HOME/lua-5.3.0
$ make linux test
# ln -s $HOME/lua-5.3.0/src/lua /usr/local/bin/lua
```

##### Luarocks Installation

```
$ cd /tmp
$ curl -O -R http://luarocks.org/releases/luarocks-2.2.0.tar.gz
$ tar xvzf luarocks-2.2.0.tar.gz
$ cd luarocks-2.2.0
$./configure --lua-version=5.3
# make install
# luarocks install lsqlite3
```

##### File Configuration
###### Find the script.db's path, use the command below
```
$ find /usr -type f -name "script.db" 2>/dev/null | awk 'gsub("script.db","")'
```
###### Then create a config.lua file, on the main path of the script
```
-- config.lua
local config = {}

config.scriptsPath = '/nmap/scripts/path'
config.filePath = config.scriptsPath..'script.db'
config.fileBackup = 'scriptbkp.db'
config.scriptdb = 'nmap_scripts.sqlite3'
config.categories = {
                      "auth","broadcast","brute","default","discovery","dos","exploit",
                      "external","fuzzer","intrusive","malware","safe","version","vuln"
                      }
return config
```

### USAGE:

```
$ lua nsearch.lua
```

#### Main Menu
#### Initial Setup

```
 ================================================
    _   _  _____  _____                     _
   | \ | |/  ___||  ___|                   | |
   |  \| |\ `--. | |__    __ _  _ __   ___ | |__
   | . ` | `--. \|  __|  / _` || '__| / __|| '_ \
   | |\  |/\__/ /| |___ | (_| || |   | (__ | | | |
   \_| \_/\____/ \____/  \__,_||_|    \___||_| |_|
 ================================================
   Version 0.2     |   @jjtibaquira
 ================================================

Creating Database :nmap_scripts.sqlite3
Creating Table For Script ....
Creating Table for Categories ....
Creating Table for Scripts per Category ....
Upload Categories to Categories Table ...
```

#### Main Console

```
 ================================================
    _   _  _____  _____                     _
   | \ | |/  ___||  ___|                   | |
   |  \| |\ `--. | |__    __ _  _ __   ___ | |__
   | . ` | `--. \|  __|  / _` || '__| / __|| '_ \
   | |\  |/\__/ /| |___ | (_| || |   | (__ | | | |
   \_| \_/\____/ \____/  \__,_||_|    \___||_| |_|
  ================================================
   Version 0.2     |   @jjtibaquira
  ================================================

    name     : search by script's name
    category : search by category
    clear    : Clean the console
    exit     : Close the Application

     Usage:
       name:http
       category:exploit

    nsearch>
```

```
   ================================================
    _   _  _____  _____                     _
   | \ | |/  ___||  ___|                   | |
   |  \| |\ `--. | |__    __ _  _ __   ___ | |__
   | . ` | `--. \|  __|  / _` || '__| / __|| '_ \
   | |\  |/\__/ /| |___ | (_| || |   | (__ | | | |
   \_| \_/\____/ \____/  \__,_||_|    \___||_| |_|
  ================================================
   Version 0.2     |   @jjtibaquira
  ================================================

  nsearch> name:http

  Total Scripts Found 101

    1 http-adobe-coldfusion-apsa1301.nse
    2 http-affiliate-id.nse
    3 http-apache-negotiation.nse
    4 http-auth-finder.nse
    5 http-auth.nse
    6 http-awstatstotals-exec.nse
    7 http-axis2-dir-traversal.nse
    8 http-backup-finder.nse
    9 http-barracuda-dir-traversal.nse
    .
    .
    .
    100 membase-http-info.nse
    101 riak-http-info.nse

    Do yo want more info about any script, choose the script using id [1-101] or quit (0) 1

    description = [[
    Attempts to exploit an authentication bypass vulnerability in Adobe Coldfusion servers (APSA13-01: http://www.adobe.com/support/security/advisories/apsa13-01.html) to retrieve a valid administrator's session cookie.
    ]]

    ---
    -- @usage nmap -sV --script http-adobe-coldfusion-apsa1301 <target>
    -- @usage nmap -p80 --script http-adobe-coldfusion-apsa1301 --script-args basepath=/cf/adminapi/ <target>
    --
    -- @output
    -- PORT   STATE SERVICE
    -- 80/tcp open  http
    -- | http-adobe-coldfusion-apsa1301:
    -- |_  admin_cookie: aW50ZXJhY3RpdmUNQUEyNTFGRDU2NzM1OEYxNkI3REUzRjNCMjJERTgxOTNBNzUxN0NEMA1jZmFkbWlu
    --
    -- @args http-adobe-coldfusion-apsa1301.basepath URI path to administrator.cfc. Default: /CFIDE/adminapi/
    --
    ---

    author = "Paulino Calderon <calderon@websec.mx>"

    Do yo want more info about any script, choose the script using id [1-101] or quit (0)
```

### TODO
* Fast-Tarck
* Searching by Author
* Serching by name, category, author in the same query
* Create a pretty output
* Create a file output
* Version for Windows
* Set like a favorite script

### FeedBack
#### Feel free to fork the project, submit any kind of comment, issue or contribution.

* Twitter: [@jjtibaquira](https://twitter.com/jjtibaquira)
* Email: jko@dragonjar.org
* Foro: http://comunidad.dragonjar.org
