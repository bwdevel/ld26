function ePlayerLoad()
	ePlayer = {}
		ePlayer.x = 400
		ePlayer.y = 400
		ePlayer.r =	32		-- radius/size
		ePlayer.s = 1		-- scale
		ePlayer.dx = 0		-- x velocity (delta x)
		ePlayer.dy = 0		-- y velocity (delta y)
		ePlayer.rgb = {255,255,255}
		ePlayer.alpha = 255
		ePlayer.active = true
		ePlayer.thrust = 0.25

		ePlayer.left = false
		ePlayer.right = false
		ePlayer.up = false
		ePlayer.down = false

	camera = {} -- unimplemented
		camera.x = ePlayer.x
		camera.y = ePlayer.y
		camera.s = ePlayer.s -- eventually adjusts draw range based on camera zoom	



end

function ePlayerUpdate(dt)
	camera.s = 1/((800/32) / (800/ePlayer.s))
	if ePlayer.active == true then
		if ePlayer.left == true then ePlayer.dx = ePlayer.dx - (ePlayer.thrust * dt) end
		if ePlayer.right == true then ePlayer.dx = ePlayer.dx + (ePlayer.thrust * dt) end
		if ePlayer.up == true then ePlayer.dy = ePlayer.dy - (ePlayer.thrust * dt) end
		if ePlayer.down == true then ePlayer.dy = ePlayer.dy + (ePlayer.thrust * dt) end

		ePlayer.x = ePlayer.x + ePlayer.dx
		ePlayer.y = ePlayer.y + ePlayer.dy
	end

end


function ePlayerDraw()
	if ePlayer.active == true then
		local c = ePlayer.rgb
		love.graphics.setColor(c[1], c[2], c[3],ePlayer.alpha)
		love.graphics.circle("fill", ePlayer.x, ePlayer.y, ePlayer.r*ePlayer.s, 32)
	end
end

function ePlayerKeyPressed(k,u)
	if ePlayer.active == true then
		if k == 'a' or k == 'left' then ePlayer.left = true end
		if k == 'w' or k == 'up' then ePlayer.up = true end
		if k == 'd' or k == 'right' then ePlayer.right = true end
		if k == 's' or k == 'down' then ePlayer.down = true end
	end
end

function ePlayerKeyReleased(k,u)
	if ePlayer.active == true then
		if k == 'a' or k == 'left' then ePlayer.left = false end
		if k == 'w' or k == 'up' then ePlayer.up = false end
		if k == 'd' or k == 'right' then ePlayer.right = false end
		if k == 's' or k == 'down' then ePlayer.down = false end
	end

end