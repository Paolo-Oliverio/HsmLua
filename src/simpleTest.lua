Hsm = require("src/hsm")

local root = {}

function root:Enter(hsm)
  print("root: Enter")
  if hsm:is_current() then
    --return 
    hsm:switch_to("s1")
  end
end

function root:Event(hsm)
  if(hsm.e == "jump") then
    print("Event Jump")
    hsm:switch_to("root2")
    return true
  end
end

function root:Exit(hsm)
  print("root: Exit")
end

local root2= {}

function root2:Enter(hsm)
  print("Enter root2")
end

function root2:Event(hsm)
  if (hsm.e == "jump") then
    print("Event Jump")
    hsm:switch_to("root")
    return true
  elseif (hsm.e == "toggle") then
    print("Event Toggle")
    print("I cannot toggle from root2")
    return true
  end
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
    print("Event Toggle")
    sm:switch_to("s2")
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
  print("Event Toggle")
  sm:switch_to("s1")
  return true
end
return false

end

function s2:Exit(sm)
  print("s2:Exit")
end

--Create StateMachine Model
local mod = Hsm.Model.Create()
--Add states to the model in random order to test the dependency fixer
mod:add("s1", s1, "root")
local r = mod:add("root", root)
--s2 uses the preferred root state instead of ref to parent by string
mod:add("s2", s2, r)
mod:add("root2", root2)

--Create StateMachine Instance
local m = Hsm.M.Create(mod)
m:start("root")
m:event("toggle")
m:event("toggle")
m:event("toggle")
m:event("toggle")
m:event("jump")
m:event("toggle")
m:event("jump")
m:stop()

--[[ Output:
  Starting the state machine
  root: Enter
  s1:Enter
  Event Toggle
  s1:Exit
  s2:Enter
  Event Toggle
  s2:Exit
  s1:Enter
  Event Toggle
  s1:Exit
  s2:Enter
  Event Toggle
  s2:Exit
  s1:Enter
  Event Jump
  s1:Exit
  root: Exit
  root2: Enter
  Event Toggle
  I cannot toggle from root2
  Event Jump
  root2: Exit
  root: Enter
  s1:Enter
  Stopping the state machine7
  s1:Exit
  root: Exit
]]