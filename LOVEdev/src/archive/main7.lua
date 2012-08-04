
--mapWidth, mapHeight -- width and height in tiles
--
--mapX, mapY-- view x,y in tiles. can be a fractional value like 3.25.
--
--tilesDisplayWidth, tilesDisplayHeight -- number of tiles to show
--zoomX, zoomY
--
--tilesetImage
--tileSize -- size of tiles in pixels
tileQuads = {} -- parts of the tileset used for different tiles
--tilesetSprite

rotation = 225
upperLeft = {}
upperLeft.x = 0
upperLeft.y = 0
center = {}

function love.load()
	require "map"
	Camera = require "libs.hump.camera"
	Vector = require "libs.hump.vector"
	
	
--	mapPath = "gfx/testMap.png"
--	mapData = love.image.newImageData(mapPath)
--	loadMap(mapData)
	
	generateMap(512,512)
--	setupMap()
	tileSize = 48
	setupMapView()
	updateDispSize()
	cam = Camera:new()
	
	
end

--function setupMap()
  mapWidth = 600
  mapHeight = 400
--  
--  map = {}
--  for x=0,mapWidth-1 do
--    map[x] = {}
--    for y=0,mapHeight-1 do
--      map[x][y] = math.random(0,2)
--    end
--  end
--end

function updateDispSize()
	width, height, fullscreen, vsync, fsaa = love.graphics.getMode()
	tilesDispWidth = math.ceil(width/tileSize)
	tilesDispHeight = math.ceil(height/tileSize)
	dispDiag = math.sqrt((tilesDispWidth * tileSize)^2 + (tilesDispHeight * tileSize)^2)
	renderSizeTiles = math.ceil(dispDiag / tileSize)
	renderSize = renderSizeTiles * tileSize
	setupTileset()
end

function setupTileset()
  tilesetImage = love.graphics.newImage( "gfx/placeholder.png" )
  tilesetImage:setFilter("nearest", "linear") -- this "linear filter" removes some artifacts if we were to scale the tiles
  center.x = tilesDispWidth*tileSize/2
  center.y = tilesDispHeight*tileSize/2
  
  
  -- grass
  tileQuads[0] = love.graphics.newQuad(0 * (tileSize+1), 2 * (tileSize+1), tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
  -- kitchen floor tile
  tileQuads[1] = love.graphics.newQuad(0 * (tileSize+1), 1 * (tileSize+1), tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
  -- parquet flooring
  tileQuads[2] = love.graphics.newQuad(0 * (tileSize+1), 0 * (tileSize+1), tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
  -- middle of red carpet
--  tileQuads[3] = love.graphics.newQuad(3 * tileSize, 9 * tileSize, tileSize, tileSize,
--    tilesetImage:getWidth(), tilesetImage:getHeight())
  
  tilesetBatch = love.graphics.newSpriteBatch(tilesetImage, renderSizeTiles * renderSizeTiles)
  
  updateTilesetBatch()
end

function updateTilesetBatch()
  tilesetBatch:clear()
  for x=0, renderSizeTiles-1 do
    for y=0, renderSizeTiles-1 do
      tilesetBatch:addq(tileQuads[map[x+math.floor(mapX)][y+math.floor(mapY)]],
        x*tileSize, y*tileSize)
    end
  end
end

function setupMapView()
  mapX = 1
  mapY = 1
  zoomX = 1
  zoomY = 1
end

function moveMap(dx, dy)
  oldMapX = mapX
  oldMapY = mapY
  mapX = math.max(math.min(mapX + dx, mapWidth - tilesDispWidth), 1)
  mapY = math.max(math.min(mapY + dy, mapHeight - tilesDispHeight), 1)
  -- only update if we actually moved
  if math.floor(mapX) ~= math.floor(oldMapX) or math.floor(mapY) ~= math.floor(oldMapY) then
    updateTilesetBatch()
  end
end

function love.update(dt)
  if love.keyboard.isDown("up")  then
    moveMap(0, -0.2 * tileSize * dt)
  end
  if love.keyboard.isDown("down")  then
    moveMap(0, 0.2 * tileSize * dt)
  end
  if love.keyboard.isDown("left")  then
    moveMap(-0.2 * tileSize * dt, 0)
  end
  if love.keyboard.isDown("right")  then
    moveMap(0.2 * tileSize * dt, 0)
  end
  if love.keyboard.isDown("w")  then
    rotation = rotation + 15
    love.timer.sleep(0.1)
  end
  upperLeft.y = (math.sin(math.rad(rotation)) * math.sqrt(2) * center.y) + center.y
  upperLeft.x = (math.cos(math.rad(rotation)) * math.sqrt(2) * center.x) + center.x
end

function draw()
	love.graphics.draw(tilesetBatch,
    upperLeft.x + math.floor(-(mapX%1)*tileSize), upperLeft.y + math.floor(-(mapY%1)*tileSize),
    math.rad(rotation), zoomX, zoomY)
  love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
  
end

function love.draw()
	draw()
  
	
end