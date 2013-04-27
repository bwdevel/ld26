require('/entities/ePlayer')
require('/entities/eEnemy')

function sPlayLoad()
	ePlayerLoad()
	eEnemyLoad()

	-- temp location of spawn code
	eEnemySpawn(100,100,5)
	eEnemySpawn(700,700,15)
	eEnemySpawn(100,700,35)
	eEnemySpawn(700,100,75)

	love.graphics.setBackgroundColor(64,64,64)

end


function sPlayUpdate(dt)
	ePlayerUpdate(dt)
	eEnemyUpdate(dt)

end


function sPlayDraw()
	ePlayerDraw()
	eEnemyDraw()

end


function sPlayKeyPressed(k,u)
	if ePlayer.active == true then ePlayerKeyPressed(k,u) end

end


function sPlayKeyReleased(k,u)
	if ePlayer.active == true then ePlayerKeyReleased(k,u) end
	if k == 'escape' then statesChangeState("menu") end

end


function sPlayMousePressed(x,y,button)

end


function sPlayMouseReleased(x,y,button)

end