require "library.Polygamy.init" "./library/Polygamy/" -- must be outside the load callback.
                                                -- since it creates a custom love.run loop

local state, goto, pkeyboard = Polygamy.state, Polygamy.state.goto, Polygamy.keyboard   -- for convenience

Hero={
	move=function(self,direction)print("Hero moves "..tostring(direction)..".") end,
	shoot=function()print("Pew pew ...") end
}

-- load your ressources, initialize your code... then : 


--------------------------------------------------------------------------------

title = state( "Title Screen" )
              --============--

function title.before() pkeyboard.use( "title" ); print"menu" end
function title.update(dt)  --[[ your title update callback ]] end
function title.draw()      --[[ draw your fine title here  ]] end

pkeyboard( "title" ):setConfig( "pressed", {
	[{" ", "return"}] = function() goto("In Game")       end,
	escape            = function() love.event.push('quit') end,
	[Polygamy.default] = print
})


---------------------------------------------------------------------------------

ingame = state( "In Game" )
               --=======--

function ingame.before( from, to, ... )
	if from == "Title Screen" then --[[Game.state.reset()]] end
	Polygamy.timer:resume()
	pkeyboard.use( to ) -- selfhandle == "In game" in this case
	print "In Game"
end

function ingame.update( dt ) --[[ instill life in your game world ]] end

function ingame.draw()   --[[ and render it in its full glory ]] end

function ingame.after( from, to, ... )
	Polygamy.timer:pause()	
	if to == "Pause Screen" then
		-- dim the screen, take a screenshot
	end
end



pkeyboard("In Game"):setConfig("pressed", {
	
	[" %arrows "] = { held = function(key,_,_,dt) Hero:move(key,dt); end },
	[" "]  = function() Hero:shoot()           end,
	escape = function() goto( "Title Screen" ) end,
	p      = function() goto( "Pause Screen" ) end
})


----------------------------------------------------------------------------------

pauseState = state( "Pause Screen" )
                   --============--
function pauseState.before() pkeyboard.use( "pause" ); print"Pause" end
function pauseState.update(dt) end -- if you don't define it, the previous callback remains active.
function pauseState.draw() --[[ display "Paused" on top of the screenshot.]] end


pkeyboard( "pause" ):setConfig( "pressed", {
	escape = function() goto( "Title Screen" ) end,
	p      = function() goto( "In Game" )      end
})

-- then get the ball rolling :-)

function love.load() print"Start" goto("Title Screen") end

