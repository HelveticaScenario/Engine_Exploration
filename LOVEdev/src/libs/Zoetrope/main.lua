STRICT = true
DEBUG = true

require 'zoetrope'

MyApp = App:extend
{
	onNew = function (self)
		self:add(Text:new
		{
			y = 300, width = the.app.width, align = 'center',
			text = 'Welcome to Zoetrope! Edit main.lua to get started.'
		})
	end
}

function love.load()
	local app = MyApp:new()
	app:run()
end
