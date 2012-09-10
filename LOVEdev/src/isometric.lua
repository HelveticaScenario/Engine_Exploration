function load()
	width, height = love.graphics.getMode()
	tileImage = love.graphics.newImage("gfx/tile.png")
	block_width = tileImage:getWidth()
	block_height = tileImage:getHeight()
	block_depth = block_height / 2
	grid_x,grid_y = 0,0
	grid_size = 50
	grid = {}
	for x = 1,grid_size do
	   grid[x] = {}
	   for y = 1,grid_size do
	      grid[x][y] = 1
	   end
	end
	grid_x = width/2
	grid_y = height/2
	grass = tileImage
end


function update(dt)
	if love.keyboard.isDown('w') then grid_y = grid_y - (dt*30) end
	if love.keyboard.isDown('s') then grid_y = grid_y + (dt*30) end
	if love.keyboard.isDown('a') then grid_x = grid_x - (dt*30) end
	if love.keyboard.isDown('d') then grid_x = grid_x + (dt*30) end
end


function draw()
	for x = 1,grid_size do
	   for y = 1,grid_size do
	      if grid[x][y] == 1 then
	         love.graphics.draw(grass,
	            grid_x + ((y-x) * (block_width / 2)),
	            grid_y + ((x+y) * (block_depth / 1.7)) - (block_depth * (grid_size / 2)))-- - block_depth)
--	      else -- grid[x][y] == 2
--	         love.graphics.draw(dirt,
--	            grid_x + ((y-x) * (block_width / 2)),
--	            grid_y + ((x+y) * (block_depth / 2)) - (block_depth * (grid_size / 2)))
	      end
	   end
	end
end