--camera = {}
--camera.x = 0
--camera.y = 0
--camera.scaleX = 1
--camera.scaleY = 1
--camera.rotation = 0
--
--function camera:set()
--  love.graphics.push()
--  love.graphics.rotate(-self.rotation)
--  love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
--  love.graphics.translate(-self.x, -self.y)
--end
--
--function camera:unset()
--  love.graphics.pop()
--end
--
--function camera:move(dx, dy)
--  self.x = self.x + (dx or 0)
--  self.y = self.y + (dy or 0)
--end
--
--function camera:rotate(dr)
--  self.rotation = self.rotation + dr
--end
--
--function camera:scale(sx, sy)
--  sx = sx or 1
--  self.scaleX = self.scaleX * sx
--  self.scaleY = self.scaleY * (sy or sx)
--end
--
--function camera:setPosition(x, y)
--  self.x = x or self.x
--  self.y = y or self.y
--end
--
--function camera:setScale(sx, sy)
--  self.scaleX = sx or self.scaleX
--  self.scaleY = sy or self.scaleY
--end


local lg = love.graphics
local cos = math.cos
local sin = math.sin
local abs = math.abs

function load()
tileQuads = {} -- parts of the tileset used for different tiles
--tilesetSprite

rotation = 225
upperLeft = {}
upperLeft.x = 0
upperLeft.y = 0
center = {}
tileSize = 32
width, height, fullscreen, vsync, fsaa = love.graphics.getMode()
	tilesDispWidth = math.ceil(width/tileSize)
	tilesDispHeight = math.ceil(height/tileSize)
	dispDiag = math.sqrt((tilesDispWidth * tileSize)^2 + (tilesDispHeight * tileSize)^2)
	renderSizeTiles = math.ceil(dispDiag / tileSize)
	renderSize = renderSizeTiles * tileSize

camera = require "libs.hump.camera"
cam1 = camera(width/2,height/2)

tilesetImage = love.graphics.newImage( "gfx/GOODWALVAGINASL.png" )
tilesetImage:setFilter("linear", "linear") -- this "linear filter" removes some artifacts if we were to scale the tiles
  center.x = tilesDispWidth*tileSize/2
  center.y = tilesDispHeight*tileSize/2
  
  twoPi= math.pi*2
  angle = 90
  
  sqrt2 = math.sqrt(2)
  invSqrt2 = 1/math.sqrt(2)
  timefidy = (tilesetImage:getWidth()*sqrt2)/2
  --sqrt(((1/sqrt(2))^2)*2)
  shearY = 0
  shearX = 0
  scaleX = 1
  scaleY = 1
  -- grass
--  tileQuads[0] = love.graphics.newQuad(158, 182, 100, 77,
--    tilesetImage:getWidth(), tilesetImage:getHeight())

end

--function keypressed(key,unicode)
--	if key == "i" then scaleX = scaleX + 0.1 end
--	if key == "o" then scaleX = scaleX - 0.1 end
--	if key == "y" then scaleY = scaleY + 0.1 end
--	if key == "u" then scaleY = scaleY - 0.1 end
--	if key == "k" then shearY = shearY + 0.1 end
--	if key == "l" then shearY = shearY - 0.1 end
--end

--function update(dt)
--	if love.keyboard.isDown("i") then scaleX = scaleX + dt end
--	if love.keyboard.isDown("o") then scaleX = scaleX - dt end
--	if love.keyboard.isDown("y") then scaleY = scaleY + dt end
--	if love.keyboard.isDown("u") then scaleY = scaleY - dt end
--	if love.keyboard.isDown("k") then shearY = shearY + dt end
--	if love.keyboard.isDown("l") then shearY = shearY - dt end
--	if love.keyboard.isDown("h") then shearX = shearX + dt end
--	if love.keyboard.isDown("j") then shearX = shearX - dt end
--end

function update(dt)
--	if love.keyboard.isDown("i") then scaleX = scaleX + .005 end
--	if love.keyboard.isDown("o") then scaleX = scaleX - .005 end
--	if love.keyboard.isDown("y") then scaleY = scaleY + .005 end
--	if love.keyboard.isDown("u") then scaleY = scaleY - .005 end
	if love.keyboard.isDown("k") then 
		angle = angle + 1  
	end
	if love.keyboard.isDown("l") then 
		angle = angle - 1 
	end
--	if love.keyboard.isDown("h") then 
--		cam1:rotate(.01)	
--	end
--	if love.keyboard.isDown("j") then 
--		cam1:rotate(-.01)	
--	end
	actAngle = (angle % 90) +90
	actAngle2 = ((angle) % 90) + 180
	
--	if actAngle >= 180 then
--		value2 = -(math.sin(math.rad(actAngle))) + (math.cos(math.rad(actAngle)))
--	elseif  actAngle < 180 then
--		value2 = (math.sin(math.rad(actAngle)) - math.cos(math.rad(actAngle)))
--	end
	--scaleX = (math.sin(math.rad(actAngle)) - math.cos(math.rad(actAngle)))
--	((math.sqrt(2)-1) * 25)
	scaleX = math.sin(math.rad(actAngle))
	shearY = (math.cos(math.rad(actAngle)))
	scaleX2 = math.sin(math.rad(actAngle2))
	shearY2 = (math.cos(math.rad(actAngle2)))
	--shearY = (math.sin(math.rad(actAngle)) + math.cos(math.rad(actAngle)))
--	tranx = math.cos(math.rad(actAngle*2))*50
	tranx = math.sin(math.rad(actAngle-135))*timefidy
--	trany = -math.sin(math.rad(actAngle*4))* ((math.sqrt(2)-1) * 25)
	trany = math.cos(math.rad(actAngle-135))*timefidy
--	if cam1.rot ~= angle then
		
--	end
end


-- IMPORTANT
function drawBox(tilesetImage,actAngle,scaleX,shearY,scaleX2,shearY2)
	love.graphics.draw(tilesetImage,300,200,-math.rad(actAngle),1,1,0,0,0,0)
	love.graphics.draw(tilesetImage,300,200,0,(scaleX)*1,
						--(math.sin(math.rad(45))+math.cos(math.rad(45)))*
						1,
						0,
						0,
						0,
						shearY)
	love.graphics.draw(tilesetImage,300,200,0,(scaleX2)*1,
						--(math.sin(math.rad(45))+math.cos(math.rad(45)))*
						1,
						0,
						0,
						0,
						shearY2)
end

function draw()
	
	cam1:attach()
		love.graphics.translate(tranx,trany)
		drawBox(tilesetImage,actAngle,scaleX,shearY,scaleX2,shearY2)
	cam1:detach()
	
	love.graphics.print("shearY " .. shearY .. "\n" .. 
						"shearY2 " .. shearY2 .. "\n" .. 
						"scaleX " .. scaleX .. "\n" .. 
						"scaleX2 " .. scaleX2 .. "\n" .. 
					--	"value2 " .. value2 .. "\n" .. 
						"tranx " .. tranx .. "\n" .. 
						"trany " .. trany .. "\n" .. 
--						"scaleX " .. scaleX .. "\n" .. 
--						"scaleY " .. scaleY .. "\n" .. 
						"cam1.r " .. cam1.r .. "\n" .. 
						"actAngle " .. actAngle,
						10,
						10)
--	love.graphics.point(math.sin(math.rad(actAngle*2+90))*30+100,math.cos(math.rad(actAngle*2+90))*30+100)
--	love.graphics.point(100,200)
--	love.graphics.line(300,200, (300+(tilesetImage:getWidth()*4)),200)
--	love.graphics.line(300,200, 300,(200+(tilesetImage:getHeight()*4)))
	
end