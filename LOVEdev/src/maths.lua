matrix = require "matrix"
camera = require "libs.hump.camera"
function load()
	width, height = love.graphics.getMode()
cam1 = camera(width/2, height/2)
end


function update(dt)
	cam1:rotate(dt)--:move(dt,dt)
end


function draw()
--	drawWorld()
	cam1:draw(drawWorld)
end


drawWorld = function()
	love.graphics.print("Hello",300,200)
end


--function rotate(x, y, angle)
--	_x = (x*math.cos(angle))-(y*math.sin(angle))
--	_y = (x*math.sin(angle))+(y*math.cos(angle))
--	return _x, _y
--end
--
--function center(x, y)
--	
--end
--
--
--z = matrix{{0},{5}}
--function rot(angle, x, y, cenX = 0, cenY = 0)
--	
--	_m1 = matrix{{math.cos(angle),-math.sin(angle)},{math.sin(angle),math.cos(angle)}}
--	return _m1
--end
--r = rot(math.rad(90))
--

	