local foo = nil
local bar = { }
bar.a = 1
load = function()
  print("hello")
  return foo()
end
update = function(dt) end
draw = function() end
foo = function()
  return print("bar")
end
