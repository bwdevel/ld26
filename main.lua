-- includes
require('states')


-- loads once on engine load
function love.load()
	statesLoad()
	font12 = love.graphics.newFont("fonts/PressStart2P.ttf",12)

end


-- processes every engine cycle. dt = delta time since last cycle
function love.update(dt)
	statesUpdate(dt)

end


-- processes each cycle during the screen draw (draw stuff in this function)
function love.draw()
	statesDraw()

end


-- fires on each key press. k = key pressed, u = unicode of key pressed
function love.keypressed(k,u)
	statesKeyPressed(k,u)
end


-- fires one each key released. k = key released, y = unicode of key released
function love.keyreleased(k,u)
	if k == 'q' then love.event.quit() end -- quick-kill command, remove for release
	statesKeyReleased(k,u)
end


-- fires when mouse button is pressed, x,y = coords of mouse, button = button pressed
function love.mousepressed(x,y,button)
	statesMousePressed(x,y,button)

end

-- fires when mouse button is pressed, x,y = coords of mouse, button = button released
function love.mousereleased(x,y,button)
	statesMouseReleased(x,y,button)
end


-- called when game ends
function love.quit()

end

function table.copy(t)
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = v
	end
	return t2
end

function getDist(x1,y1,x2,y2)
	return math.sqrt(math.abs(x1-x2)^2 + math.abs(y1-y2)^2)
end
