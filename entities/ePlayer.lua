function ePlayerLoad()
	ePlayer = {}
		ePlayer.x = 400
		ePlayer.y = 400
		ePlayer.r =	75		-- radius/size
		ePlayer.s = 1		-- scale
		ePlayer.dx = 0		-- x velocity (delta x)
		ePlayer.dy = 0		-- y velocity (delta y)
		ePlayer.maxV = 5
		ePlayer.rgb = {255,255,255} -- color
		ePlayer.alpha = 255			-- alpha blending
		ePlayer.active = true
		ePlayer.thrust = 0.25
		ePlayer.friction = 0.995

		-- player movement states
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

		-- apply thrust
		if ePlayer.left == true then ePlayer.dx = ePlayer.dx - (ePlayer.thrust * dt) end
		if ePlayer.right == true then ePlayer.dx = ePlayer.dx + (ePlayer.thrust * dt) end
		if ePlayer.up == true then ePlayer.dy = ePlayer.dy - (ePlayer.thrust * dt) end
		if ePlayer.down == true then ePlayer.dy = ePlayer.dy + (ePlayer.thrust * dt) end
		-- apply friction to absense of lateral movement
		if ePlayer.left == false and ePlayer.right == false then ePlayer.dx = ePlayer.dx *(1 - (ePlayer.friction*dt)) end
		if ePlayer.up == false and ePlayer.down == false then ePlayer.dy = ePlayer.dy *(1 - (ePlayer.friction*dt)) end


		ePlayer.x = ePlayer.x + ePlayer.dx
		ePlayer.y = ePlayer.y + ePlayer.dy
	end

	-- temporary collision boundary
	if (ePlayer.x - ePlayer.r < 0 and ePlayer.dx < 0) or (ePlayer.x + ePlayer.r > 800 and ePlayer.dx > 0) then ePlayer.dx = -(ePlayer.dx) end
	if (ePlayer.y - ePlayer.r < 0 and ePlayer.dy < 0) or (ePlayer.y + ePlayer.r > 800 and ePlayer.dy > 0) then ePlayer.dy = -(ePlayer.dy) end

	-- collision with enemy
	for i, v in ipairs(eEnemies) do
		v.angle = math.atan2((v.y - ePlayer.y), (v.x - ePlayer.x))

		--collision/drain
		local dist = getDist(ePlayer.x, ePlayer.y, v.x, v.y)
		if dist < (v.r + ePlayer.r) * 1.20 then 

			if ePlayer.r > v.r and ePlayer.r > minSize then
				ePlayer.r = ePlayer.r - (drainRate * dt)
				v.r = v.r + (drainRate * dt)
			elseif ePlayer.r < v.r and v.r > minSize then
				ePlayer.r = ePlayer.r + (drainRate * dt)
				v.r = v.r - (drainRate * dt)
			end

			if dist < v.r + ePlayer.r then			
				local md = v.r/ePlayer.r/2			-- mass delta
				v.dx = v.dx + (ePlayer.dx*md)
				v.dy = v.dy + (ePlayer.dy*md)
				ePlayer.dx = ePlayer.dx - (v.dx*md)
				ePlayer.dy = ePlayer.dy - (v.dy*md)
			end
		end
	end

	-- this is ugly; fix
	local size = ePlayer.r
	size = size - 10
	if size > 50 then
		ePlayer.rgb[1] = 255
		ePlayer.rgb[2] = 255 - (255 * (size-50)/50)
	else
		ePlayer.rgb[1] = size/50*255
		ePlayer.rgb[2] = 255
	end
	ePlayer.rgb[3] = 0
		


end


function ePlayerDraw()

	if ePlayer.active == true then
		love.graphics.setColor(0,0,0,ePlayer.alpha)
		love.graphics.circle("fill", ePlayer.x, ePlayer.y, ePlayer.r*ePlayer.s, 32)
		local c = ePlayer.rgb
		love.graphics.setColor(c[1], c[2], c[3],ePlayer.alpha)
		love.graphics.circle("fill", ePlayer.x, ePlayer.y, ePlayer.r*ePlayer.s*0.9, 32)
	end

end

function ePlayerKeyPressed(k,u)
	if k == 'a' or k == 'left' then ePlayer.left = true end
	if k == 'w' or k == 'up' then ePlayer.up = true end
	if k == 'd' or k == 'right' then ePlayer.right = true end
	if k == 's' or k == 'down' then ePlayer.down = true end
end

function ePlayerKeyReleased(k,u)
	if k == 'a' or k == 'left' then ePlayer.left = false end
	if k == 'w' or k == 'up' then ePlayer.up = false end
	if k == 'd' or k == 'right' then ePlayer.right = false end
	if k == 's' or k == 'down' then ePlayer.down = false end
end