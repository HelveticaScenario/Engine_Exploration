function love.load()
	-- map variables
	map_w = 63
   	map_h = 63
   	map_x = 0
   	map_y = 0
   	map_offset_x = 0
   	map_offset_y = 0
   	map_display_w = 20
   	map_display_h = 14
   	tile_w = 48
   	tile_h = 48
   	walking = love.graphics.newImage("gfx/walkinghuman.png")
   	up = {}
   	down = {}
   	left= {}
   	right = {}
   	upleft = {}
   	upright = {}
   	downleft = {}
   	downright = {}
   	up[0] = love.graphics.newQuad(0, 2*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	up[1] = love.graphics.newQuad(48, 2*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	down[0] = love.graphics.newQuad(0, 0, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	down[1] = love.graphics.newQuad(48, 0, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	left[0] = love.graphics.newQuad(0, 1*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	left[1] = love.graphics.newQuad(48, 1*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	right[0] = love.graphics.newQuad(0, 1*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	right[1] = love.graphics.newQuad(48, 1*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	upleft[0] = love.graphics.newQuad(0, 2*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	upleft[1] = love.graphics.newQuad(48, 2*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	upright[0] = love.graphics.newQuad(0, 2*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	upright[1] = love.graphics.newQuad(48, 2*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	downleft[0] = love.graphics.newQuad(0, 0*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	downleft[1] = love.graphics.newQuad(48, 0*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	downright[0] = love.graphics.newQuad(0, 0*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	downright[1] = love.graphics.newQuad(48, 0*48, tile_w, tile_h, walking:getWidth(), walking:getHeight())
   	steps = 0
   	creatures = love.graphics.newImage("gfx/races.png")
   	player = love.graphics.newQuad(0, 0, tile_w, tile_h, creatures:getWidth(), creatures:getHeight())
	ref = love.graphics.newImage("gfx/tiles.png")
	tile = {}
	for i=0,4 do
		tile[i] = love.graphics.newQuad(0, i*48, tile_w, tile_h, ref:getWidth(), ref:getHeight())
	end
	mapData = love.image.newImageData("gfx/testMap.png")
	map = {}
	for i=0,map_w do
		map[i] = {}
		for j=0,map_h do
			if mapData:getPixel(i,j) == 0
				then map[i][j] = math.random(10000,1000000)%3
				print(map[i][j])
			end
			if mapData:getPixel(i,j) == 255
				then map[i][j] = (math.random(10000,1000000)%2)+3
				print(map[i][j])
			end
		end
	end
end

function love.update( dt )
    -- get input
    if love.keyboard.isDown( "up" ) then
        map_y = map_y-1
    end
    if love.keyboard.isDown( "down" ) then
        map_y = map_y+1
    end

    if love.keyboard.isDown( "left" ) then
        map_x = map_x -1
    end
    if love.keyboard.isDown( "right" ) then
        map_x = map_x+1
    end
    if love.keyboard.isDown( "escape" ) then
        love.event.push( "q" )
    end

    -- check boundaries. remove this section if you don't wish to be constrained to the map.
    if map_x < 0 then
        map_x = 0
    end

    if map_y < 0 then
        map_y = 0
    end 
 
    if map_x > map_w * tile_w - map_display_w * tile_w - 1 then
        map_x = map_w * tile_w - map_display_w * tile_w - 1
    end
 
    if map_y > map_h * tile_h - map_display_h * tile_h - 1 then
        map_y = map_h * tile_h - map_display_h * tile_h - 1
    end

end

function love.draw()
	for i=0,map_display_w do
		for j=0,map_display_h do
			love.graphics.drawq(ref, tile[map[i+map_x][j+map_y]], (i*tile_w)+map_offset_x, (j*tile_h)+map_offset_y)
		end
	end
	if love.keyboard.isDown( "left" ) then
	    love.graphics.drawq(walking, left[steps%2], (11*tile_w)+map_offset_x, (6*tile_h)+map_offset_y, 0, -1, 1)
    	steps = steps + 1
	elseif love.keyboard.isDown( "right" ) then
	    love.graphics.drawq(walking, right[steps%2], (10*tile_w)+map_offset_x, (6*tile_h)+map_offset_y)
    	steps = steps + 1
	elseif love.keyboard.isDown( "up" ) then
    	love.graphics.drawq(walking, up[steps%2], (10*tile_w)+map_offset_x, (6*tile_h)+map_offset_y)
    	steps = steps + 1
	elseif love.keyboard.isDown( "down" ) then
	    love.graphics.drawq(walking, down[steps%2], (10*tile_w)+map_offset_x, (6*tile_h)+map_offset_y)
    	steps = steps + 1
	else end
	love.timer.sleep(.15)
end

