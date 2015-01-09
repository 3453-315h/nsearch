-- Helper Module
--
local setup = require "setup"
local dbmodule = require "dbmodule"
local config = require "config"
scriptdb = config.scriptdb
local helper = {}

helper.mainMenu = {"Help (h)", "Initial Setup (i)", "Search by Name of Script (s)", "Search by Category (c)", "Create script.db backup (b)", "Exit (q)"}
helper.searchMenu ={ "Search by Name (s)", "Main Menu (b)", "Exit (q)"}

function helper.banner()

  banner=[[
   _   _  _____  _____                     _
   | \ | |/  ___||  ___|                   | |
   |  \| |\ `--. | |__    __ _  _ __   ___ | |__
   | . ` | `--. \|  __|  / _` || '__| / __|| '_ \
   | |\  |/\__/ /| |___ | (_| || |   | (__ | | | |
   \_| \_/\____/ \____/  \__,_||_|    \___||_| |_|
  ]]

  return banner
end

function getScirptDesc( nse )
  io.write('\nDo yo want more info about any script, choose the script using id [1-'..#nse..'] or quit (q) ')
  local option = io.read("*n")
  if nse[option]  then
    print("\n")
    local file = config.scriptsPath..nse[option]
    local lines = lines_from(file)
    for k,v in pairs(lines) do
      local i = string.find(v, "license")
      if not i then
        print('\27[96m'..v..'\27[0m')
      else
        getScirptDesc(nse)
      end
    end
  elseif option == "q" then
    hepler.searchConsole()
  else
    helper.Main()
  end
end

function resultList(nse)
  if #nse > 0 then
    print('\27[1m \27[36m'..helper.banner()..'\27[21m \27[0m')
    print("\nTotal Scripts Found "..#nse.."\n")
    for k,v in ipairs(nse) do
      print('\27[92m'..k.." "..v..'\27[0m')
    end
    getScirptDesc(nse)
  else
    print('\27[1m \27[36m'..helper.banner()..'\27[21m \27[0m')
    print("\nNot Results Found\n")
    io.write("Do you want search again? [y/n]: ")
    local action = io.read()
    if action == 'y' then
      hepler.searchConsole()
    else
      helper.Main()
  end
end

function helper.menu(menulist)
  print('\27[1m \27[36m'..helper.banner()..'\27[21m \27[0m')
  for key,value in ipairs(menulist) do
    print(key.." "..value)
  end
  return menulist
end

function hepler.searchConsole()
  io.write('\nnsearch> ')
  local command = io.read()
  if command == "help" or command == nil then
    os.execute("clear")
    print('\27[1m \27[36m'..helper.banner()..'\27[21m \27[0m')
    print("name : search by script's name ")
    print("exit : close the console")
    print("back : returns to the main menu")
    print("\n Usage name:http")
    hepler.searchConsole()
  elseif string.find(command,"name:") then
    string = command:gsub("name:","")
    os.execute("clear")
    dbmodule.findScript(string,helper.banner())
  elseif string.find(command,"exit") then
    os.exit()
  elseif string.find(command,"back") then
    os.execute("clear")
    helper.menu(helper.mainMenu)
    helper.Main()
  else
    print("bad string")
   hepler.searchConsole()
  end
end

function searchMenu()
  io.write('\n What do you want to do? : ')
  local action = io.read()
  if action == "q" or action == "3" then
    os.exit()
  elseif action == "b" or action == "2" then
   os.execute( "clear" )
    helper.menu(helper.mainMenu)
    helper.Main()
  elseif action == "s" or action == "1" then
    os.execute("clear")
    print('\27[1m \27[36m'..helper.banner()..'\27[21m \27[0m')
    helper.searchConsole()
  else
    os.execute()
  end
end

function helper.Main()
 io.write('\n What do you want to do? : ')
 local action = io.read()
 if action == "q" or action == "6" then
  os.exit()
 elseif action == "i" or action == "2" then
  os.execute( "clear" )
  setup.install(helper.banner())
 elseif action == "s" or action == "3" then
  os.execute( "clear" )
  print('\27[1m \27[36m'..helper.banner()..'\27[21m \27[0m')
  helper.searchConsole()
 elseif action == "b" or action == "4" then
  setup.createBackup(helper.banner())
  os.execute( "clear" )
  helper.menu(mainMenu)
  helper.Main()
 else
  os.exit()
 end
end


return helper
