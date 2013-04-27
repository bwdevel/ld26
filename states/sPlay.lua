require('/entities/ePlayer')

function sPlayLoad()
	ePlayerLoad()

end


function sPlayUpdate(dt)
	ePlayerUpdate(dt)

end


function sPlayDraw()
	ePlayerDraw()

end


function sPlayKeyPressed(k,u)
	ePlayerKeyPressed(k,u)

end


function sPlayKeyReleased(k,u)
	ePlayerKeyReleased(k,u)
	if k == 'escape' then statesChangeState("menu") end

end


function sPlayMousePressed(x,y,button)

end


function sPlayMouseReleased(x,y,button)

end