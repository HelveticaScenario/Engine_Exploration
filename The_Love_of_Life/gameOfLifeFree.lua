function load()
	alive = {}
	addToNewAliveList(alive, 2, 7)
	addToNewAliveList(alive, 4, 7)
	addToNewAliveList(alive, 4, 6)
	addToNewAliveList(alive, 6, 5)
	addToNewAliveList(alive, 6, 4)
	addToNewAliveList(alive, 6, 3)
	addToNewAliveList(alive, 8, 3)
	addToNewAliveList(alive, 8, 4)
	addToNewAliveList(alive, 8, 2)
	addToNewAliveList(alive, 9, 3)
	generation = 0
	time = 0
	vp = initViewPort(2)
	pop = 5
	leftX = findHorizOffset(vp)
	topY = findVertOffset(vp)
	x = 0
	y = 0
	love.graphics.getCaption("For the Love of Life")
--	min_dt = 1/60  --	FPS to cap at
--	next_time = love.timer.getMicroTime()	--	works to cap FPS
--	checkClock = 0
--	interval = 3
	pause = 1
end

function update(dt)
--	next_time = next_time + min_dt --	Caps FPS
	time = time + dt
	_dt = dt
	if love.keyboard.isDown("q") then
		print(time, generation, #alive, pop)
		for i=1, #alive do
			print(alive[i].x, alive[i].y)
		end
		love.event.push("quit",a,b,c,d)
	end
	if love.keyboard.isDown(" ") then
		pause = (pause + 1) % 2
		love.timer.sleep(.1)
	end
	if love.keyboard.isDown("down")  then
		vp.top = vp.top - 1
		vp.bot = vp.bot - 1
		topY = findVertOffset(vp)
	end
	if love.keyboard.isDown("up")  then
		vp.top = vp.top + 1
		vp.bot = vp.bot + 1
		topY = findVertOffset(vp)
	end
	if love.keyboard.isDown("right")  then
		vp.left = vp.left - 1
		vp.right = vp.right - 1
		leftX = findHorizOffset(vp)
	end
	if love.keyboard.isDown("left")  then
		vp.left = vp.left + 1
		vp.right = vp.right + 1
		leftX = findHorizOffset(vp)
	end
	if pause == 0 then
		alive, generation, pop = iterateGeneration(alive, generation)
		--		if generation > 2 then
		--			print(time, generation, #alive, pop)
		--			for i=1, #alive do
		--				print(alive[i].x, alive[i].y)
		--			end
		--			love.event.push("quit",a,b,c,d)
		--		end
--		for i=1, #alive do
--			print(alive[i].x, alive[i].y)  
--		end
--		print("\n")
		--pause = 1
		--love.timer.sleep(.2)
	end
end

function draw()
	drawDisplay(alive, vp, leftX, topY)
	love.graphics.print(leftX.actual .. "\n" .. topY.actual .. "\n" .. leftX.virtual .. "\n" .. topY.virtual .. "\n" .. vp.top .. "\n" .. vp.left .. "\n" .. vp.right .. "\n" .. vp.bot .. "\n" .. pop .. "\n" .. generation .. "\n" .. _dt,300,300)


end

function drawDisplay(alive, vp, leftX, topY)
	for i=1, #alive do
		if alive[i].x ~= nil and alive[i].y ~= nil then
			if (alive[i].x * vp.tileSize) > leftX.virtual
			and (alive[i].x * vp.tileSize) < vp.right
			and (alive[i].y * vp.tileSize) > topY.virtual
			and (alive[i].y * vp.tileSize) < vp.bot then
				love.graphics.rectangle("fill",(alive[i].x * vp.tileSize) - leftX.virtual - leftX.actual,(alive[i].y * vp.tileSize) - topY.virtual - topY.actual,vp.tileSize,vp.tileSize)
			end
		end
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
	vp.top = -300
	vp.left = -400
	vp.bot = height-301
	vp.right = width-401
	vp.tileSize = tileSize
	return vp
end


function iterateGeneration(aliveList, generation)
	--[=[
	this function iterates through the list of living cells,
	for each cell iterating through its 8 surrounding cells,
	each of which it refrences against the list of living cells,
	then iterating through the 8 surrounding cells of any of first 8
	surrounding cells it doesnt find a reference to in the list of living cells,
	referenceing each of those cells against the list of living cells,
	in order to determine the number of living cells each of the first list
	of surrounding cells has as a neighbor.
	then, for each of those cells, if the number of living neighbors is exactly
	3, it creates a new entry in a new list of living cells, called newAlive,
	listing that cell as living.
	once the function has iterated over all of the entries in the original
	list of living cells, it returns the new list, newAlive, the generation, and the new population.

	in its iteration, it also determines whether or not each of the initial
	living cells will survive or not.

	the key feature that keeps this function from taking exponetially more
	time to execute as the population increases is that for each cell that is
	checked to see if living or not, it creates an entry in a list called
	checked, indexed with the coordinates of the cell, with the value 1
	for living and 0 for dead. the function then, before
	--]=]
	if generation == nil then generation = 0 end
	local _generation = generation + 1
	local newAliveList = fillNewAliveList(aliveList)
	local population = #newAliveList
	return newAliveList, _generation, population
end

function checkIfAdded(list, x, y) 
	local _list = list
	if _list.added[x] == nil then
		return false
	elseif _list.added[x][y] == nil then
		return false
	else
		return true
	end
end

function addToAdded(list, x, y) 
	local _list = list
	if _list.added[x] == nil then
		_list.added[x] = {}
		_list.added[x][y] = 1
	elseif _list.added[x][y] == nil then
		_list.added[x][y] = 1
	end
	return _list
end

function addToTable(newAliveList, x, y, neighbors, level) 
	if level == 1 and (neighbors == 2 or neighbors == 3)then
		addToNewAliveList(newAliveList, x, y)
	elseif level == 2 and neighbors == 3 then
		addToNewAliveList(newAliveList, x, y)
	end
end

function addToNewAliveList(newAliveList, x, y)
	-- if newAliveList == nil then newAliveList = {} end
	if newAliveList.added == nil then newAliveList.added = {} end
	if (checkIfAdded(newAliveList, x, y) == false) then
		newAliveList[(#newAliveList)+1] = {}
		newAliveList[(#newAliveList)].x = x
		newAliveList[(#newAliveList)].y = y
		newAliveList = addToAdded(newAliveList, x, y)
	end
end

function createAliveIndex(aliveList) -- tested, works
	local aliveIndex = {}
	for entry,pntr in ipairs(aliveList) do
		if aliveIndex[pntr.x] == nil then
			aliveIndex[pntr.x] = {}
			aliveIndex[pntr.x][pntr.y] = 1
		elseif aliveIndex[pntr.x][pntr.y] == nil then
			aliveIndex[pntr.x][pntr.y] = 1
		end
	end
	return aliveIndex
end

function checkAgainstIndex(aliveIndex, x, y, neighbors) -- tested, works
	local dead
	if aliveIndex[x] == nil then
		dead = true
		return neighbors, dead
	elseif aliveIndex[x][y] == 1 then
		neighbors = neighbors + 1
		dead = false
		return neighbors, dead
	end
	dead = true
	return neighbors, dead
end

function deadCellRules(index, newList, x, y) -- tested, works
	local neighbors = 0
	local _x, _y
	local _newList = newList
	for _x = x-1, x+1 do
		for _y = y-1, y+1 do
			if _x ~= x or _y ~= y then
				neighbors, dead = checkAgainstIndex(index, _x, _y, neighbors)
			end
		end
	end
	addToTable(_newList, x, y, neighbors, 2)
	return _newList
end

function fillNewAliveList(aliveList)
	local newAliveList = {}
	newAliveList.added = {}
	local aliveIndex = createAliveIndex(aliveList)
	local entry, pntr
	for entry, pntr in ipairs(aliveList) do
		local neighbors = 0
		local x, y, dead
		for x = (pntr.x)-1, (pntr.x)+1 do
			for y = (pntr.y)-1, (pntr.y)+1 do
				if x ~= pntr.x or y ~= pntr.y then
					neighbors, dead = checkAgainstIndex(aliveIndex, x, y, neighbors)
				end
				if dead == true then --enters inner
					newAliveList = deadCellRules(aliveIndex, newAliveList, x, y)
				end --exits inner
			end
		end
		addToTable(newAliveList, pntr.x, pntr.y, neighbors, 1)
	end
	newAliveList.added = nil
	return newAliveList
end