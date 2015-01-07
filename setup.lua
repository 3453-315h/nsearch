-- module for initial setup

local config = require "config"
local categoryList = config.categories

local dbmodule = require "dbmodule"
-- scriptdb = config.scriptdb
local setup = {}

function setup.install(lines)
  dbmodule.InitSetup("wc")
  local t ={}
  local id_script = 0
  for k,v in ipairs(lines) do
    v = v:gsub('%Entry { filename = "',""):gsub('", categories = { "',',"'):gsub('", } }','"'):gsub('", "','","')
    for i,c in ipairs(categoryList) do
      v = v:gsub('"'..c..'"',i)
    end
    for a in string.gmatch(v,"([^,]+)") do
      table.insert(t,a)
    end
    for key,value in ipairs(t) do
      if t[1] == value then
        local val = {value}
        id_script = dbmodule.InsertScript(val,"scripts")
      else
        dbmodule.InsertCategory(id_script,value)
      end
    end
    t = {}
  end
end
return setup
