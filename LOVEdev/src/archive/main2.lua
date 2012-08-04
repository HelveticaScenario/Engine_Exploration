function love.load()
	image = love.graphics.newImage("gfx/tiles.bmp")
	image2 = image
	racesImage = love.graphics.newImage("gfx/races.png")
	blank = love.image.newImageData(800, 600)
	racesSpriteBatch = love.graphics.newSpriteBatch(image2, 260)
	test = love.image.newImageData("gfx/test.png")
	r, g, b, a = test:getPixel(1,1)
	string =  r .. " " .. g .. b .. a
	print(string)
	string2 = "000255"
	if string == string2
	then print("match")
	end
	races = {}
	tiles = {}
	sizeSq = 48          -- create the matrix
	for i=0,1 do
		races[i] = {}     -- create a new row
		for j=0,12 do
			races[i][j] = love.graphics.newQuad(i*sizeSq, j*sizeSq, sizeSq, sizeSq, racesImage:getWidth(), racesImage:getHeight())
		end
	end
	for i=0,0 do
		tiles[i] = {}     -- create a new row
		for j=0,4 do
			tiles[i][j] = love.graphics.newQuad(i*sizeSq, j*sizeSq, sizeSq, sizeSq, racesImage:getWidth(), racesImage:getHeight())
		end
	end
	for i=0,15 do
		for j=0,15 do
			racesSpriteBatch:addq(tiles[0][0], i*sizeSq, j*sizeSq)
		end
	end
end

function love.draw()

	love.graphics.setBlendMode('alpha')
	love.graphics.setBackgroundColor(150,150,150)
	love.graphics.draw(racesSpriteBatch, 0, 0)
	for i=0,1 do
		for j=0,12 do
			love.graphics.drawq(racesImage, races[i][j], i*96, j*96)
		end
	end
	local x, y = love.mouse.getPosition()
	love.mouse.setVisible(False)
	love.graphics.drawq(racesImage, races[1][1], x-32, y-32)
	-- love.graphics.print(string, 400, 300)




	--love.graphics.draw(image2, 150, 150)
	-- love.graphics.print(races[5][5], 400, 300)
end
