-- this is the parent file for the game's state machine
-- all dependant states will have their own lua file with a prefix of 's'

require('states/sMenu') -- main menu
require('states/sPlay') -- playfield
require('states/sCredits') -- credits
require('states/sHelp') -- how-to-play

-- function called to init the state engine (should be only called once)
function statesLoad()
	-- global var for tracking current state. use all lowercase
	-- menu 	- sMenu
	-- play 	- sPlay
	-- credits 	- sCredits
	-- help 	- sHelp
	gameState = "menu"

	sMenuLoad() -- move this menu stuff?

end

-- extension of love.update(dt)
function statesUpdate(dt)
	if gameState == "menu" then
		sMenuUpdate(dt)
	elseif gameState == "play" then
		sPlayUpdate(dt)
	elseif gameState == "credits" then
		sCreditsUpdate(dt)
	elseif gameState == "help" then
		sHelpUpdate(dt)
	else
		error("Bad State(update):" .. gameState)
	end

end

-- extension of love.draw()
function statesDraw()
	love.graphics.print(gameState, 10, 10)
	if gameState == "menu" then
		sMenuDraw()
	elseif gameState == "play" then
		sPlayDraw()
	elseif gameState == "credits" then
		sCreditsDraw()
	elseif gameState == "help" then
		sHelpDraw()
	else
		error("Bad State(draw):" .. gameState)
	end

end

-- function to transition states
function statesChangeState(newstate)
	if newstate == "menu" then
		sMenuLoad()
		gameState = "menu"
	elseif newstate == "play" then
		sPlayLoad()
		gameState = "play"
	elseif newstate == "credits" then
		sCreditsLoad()
		gameState = "credits"
	elseif newstate == "help" then
		sHelpLoad()
		gameState = "help"
	elseif newstate == "quit" then
		love.event.quit()
	else
		error("statesChangeState(".. newstate .."): Bad State")
	end

end

-- extends love.keypressed(k,u)
function statesKeyPressed(k,u)
	if gameState == "menu" then
		sMenuKeyPressed(k,u)
	elseif gameState == "play" then
		sPlayKeyPressed(k,u)
	elseif gameState == "credits" then
		sCreditsKeyPressed(k,u)
	elseif gameState == "help" then
		sHelpKeyPressed(k,u)
	else
		error("Bad State(keypressed):" .. gameState)
	end

end

-- extends love.keyreleased(k,u)
function statesKeyReleased(k,u)
	if gameState == "menu" then
		sMenuKeyReleased(k,u)
	elseif gameState == "play" then
		sPlayKeyReleased(k,u)
	elseif gameState == "credits" then
		sCreditsKeyReleased(k,u)
	elseif gameState == "help" then
		sHelpKeyReleased(k,u)
	else
		error("Bad State(keyreleased):" .. gameState)
	end


end

-- extends love.mousepressed(x,y,button)
function statesMousePressed(x,y,button)
	if gameState == "menu" then
		sMenuMousePressed(x,y,button)
	elseif gameState == "play" then
		sPlayKeyMousePressed(x,y,button)
	elseif gameState == "credits" then
		sCreditsMousePressed(x,y,button)
	elseif gameState == "help" then
		sHelpMousePressed(x,y,button)
	else
		error("Bad State(mousepressed):" .. gameState)
	end

end


-- extends love.mousereleased(x,y,button)
function statesMouseReleased(x,y,button)
	if gameState == "menu" then
		sMenuMouseReleased(x,y,button)
	elseif gameState == "play" then
		sPlayKeyMouseReleased(x,y,button)
	elseif gameState == "credits" then
		sCreditsMouseReleased(x,y,button)
	elseif gameState == "help" then
		sHelpMouseReleased(x,y,button)
	else
		error("Bad State(mousereleased):" .. gameState)
	end

end