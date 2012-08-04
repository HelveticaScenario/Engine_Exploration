function load()
	number = 0
	displayGrid = generateGrid(500,500)
	vp = initViewPort(8)
	leftX = findHorizOffset(vp)
	topY = findVertOffset(vp)
	x = 0
	y = 0
	min_dt = 1/60  --	FPS to cap at
	next_time = love.timer.getMicroTime()	--	works to cap FPS
	checkClock = 0
	interval = 3
end

function update(dt)
	next_time = next_time + min_dt --	Caps FPS
	checkClock = checkClock + dt
	if math.ceil(checkClock) % interval == 0 then
		displayGrid = updateGrid(displayGrid)
		checkClock = checkClock + 1
	end
	number = number + dt
	
	if love.keyboard.isDown("up")  then
    vp.top = vp.top - 1
    vp.bot = vp.bot - 1
    topY = findVertOffset(vp)
  end
  if love.keyboard.isDown("down")  then
    vp.top = vp.top + 1
    vp.bot = vp.bot + 1
    topY = findVertOffset(vp)
  end
  if love.keyboard.isDown("left")  then
    vp.left = vp.left - 1
    vp.right = vp.right - 1
    leftX = findHorizOffset(vp)
  end
  if love.keyboard.isDown("right")  then
    vp.left = vp.left + 1
    vp.right = vp.right + 1
    leftX = findHorizOffset(vp)
  end
	
end

function draw()
	love.graphics.print(leftX.actual .. " " .. topY.actual,300,300)
--	love.graphics.rectangle( "fill", x, y, 64, 64 )
	drawDisplay(displayGrid, vp, leftX, topY)
	local cur_time = love.timer.getMicroTime()
	if next_time <= cur_time then
		next_time = cur_time
		return
	end
	love.timer.sleep((next_time - cur_time))
end

function drawDisplay(grid, vp, leftX, topY)
	virtX = leftX.virtual
	offX = leftX.actual
	tileX = leftX.tile
	while virtX <= vp.right do
		virtY = topY.virtual
		offY = topY.actual
		tileY = topY.tile
		while virtY <= vp.bot do
--			print(tileX .. tileY .. type(grid[tileX]))
			if grid[tileX] == nil then
				grid[tileX] = {}
			end
			if grid[tileX][tileY] == nil then
				grid[tileX][tileY] = -1
			end
			if grid[tileX][tileY] ~= nil then
				if grid[tileX][tileY] == -1 then
					love.graphics.rectangle("line",offX,offY,vp.tileSize,vp.tileSize)
				elseif grid[tileX][tileY] == 1 then
					love.graphics.rectangle("fill",offX,offY,vp.tileSize,vp.tileSize)
				end
			end
			virtY = virtY + vp.tileSize
			offY = offY + vp.tileSize
			tileY = tileY + 1
		end
		virtX = virtX + vp.tileSize
		offX = offX + vp.tileSize
		tileX = tileX + 1
	end
end

function findVertOffset(vp) 

topY = {}
topY.tile = math.floor(vp.top/vp.tileSize)
topY.virtual = topY.tile * vp.tileSize
topY.actual = topY.virtual - vp.top

return topY
end

function findHorizOffset(vp)

leftX = {}
leftX.tile = math.floor(vp.left/vp.tileSize)
leftX.virtual = leftX.tile * vp.tileSize
leftX.actual = leftX.virtual - vp.left

return leftX
end

function initViewPort(tileSize)
	width, height, fullscreen, vsync, fsaa = love.graphics.getMode()
--	topL, topR, botL, botR = {}
	local vp = {}
	vp.top = 0
	vp.left = 0
	vp.bot = height-1
	vp.right = width-1
	vp.tileSize = tileSize
	return vp
end

function generateGrid(width, height)
	local displayGrid = {}
	local x, y = 1
	for x = 1, width do
		displayGrid[x] = {}
		for y = 1, height do
			if x == 1 or y == 1 or x == width or y == height then
				displayGrid[x][y] = -1
			elseif math.random(5) == 5 then
				displayGrid[x][y] = 1
			else
				displayGrid[x][y] = 0
			end
--			print("init " .. x .. " " .. y .. " " .. displayGrid[x][y])			
		end
	end
--	print("\n\n\nDONE\n\n\n")
	return displayGrid
end

function updateGrid(grid)
	-- FIX: calculates right and bottom -1 values
	
	local bufferGrid = grid
	local x, y, i, j
	for x = 1, #grid do
		for y = 1, #grid[x] do
--			print("update " .. x .. " " .. y .. " " .. grid[x][y])
			if grid[x][y] ~= -1 then
				local neighbors = 0
				for j = y-1, y+1 do
					for i = x-1, x+1 do
						if j ~= y and i ~= x then
							if grid[i][j] == 1 then
								neighbors = neighbors + 1
							end
						end
					end
				end
				if neighbors < 2 or neighbors > 3 then
					bufferGrid[x][y] = 0
				elseif neighbors == 3 then
					bufferGrid[x][y] = 1
				end
			end
		end
	end
--	print("\n\n\nDONE\n\n\n")
--	love.event.push("quit",a,b,c,d)
	return bufferGrid
end