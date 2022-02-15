Hsm = require("hsm")

local root = {}

function root:Enter(hsm)
  print("root: Enter")
  if hsm:isCurrent() and hsm:switchTo("s1") then
    return true
  end
end

function root:Event(hsm)
  if(hsm.e == "jump") then
    hsm:switchTo("root2")
  end
end

function root:Exit(hsm)
  print("root: Exit")
end

local root2= {}

function root2:Enter(hsm)
  print("Enter root2")
end

function root2:Exit(hsm)
  print("Exit root2")
end

local s1 = {}

function s1:Enter (sm)
  print("s1:Enter")
end

function s1:Event(sm)
  if(sm.e == "toggle") then
    print("Toggle s1")
    sm:switchTo("s2")
    return true
  end
  return false
end

function s1:Exit (sm)
  print("s1:Exit")
end

local s2 = {}

function s2:Enter(sm)
  print("s2:Enter")
end

function s2:Event(sm)
  if (sm.e == "toggle") then
  print("Toggle s2")
  sm:switchTo("s1")
  return true
end
return false

end

function s2:Exit(sm)
  print("s2:Exit")
end

local mod = Hsm.Model.create()


mod:add("s1", s1, "root")
local r = mod:add("root", root)
mod:add("s2", s2, "root")
mod:add("root2", root2)

local m = Hsm.M.create(mod)
m:start("root")
m:event("toggle")
m:event("toggle")
m:event("toggle")
m:event("toggle")
m:exit()
