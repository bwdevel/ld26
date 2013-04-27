function eEnemyLoad()
	eEnemies = {}
	maxVel = 3
	drainRate = 10 -- units per second of drain
	drainDist = 1.20 -- percentage of distance between centers at which draining occurs


end


function eEnemyUpdate(dt)
	for i, v in ipairs(eEnemies) do

		--apply natural friction (later set it only if ent isn't actively moving)
		v.dx = v.dx *(1 - (ePlayer.friction*dt))
		v.dy = v.dy *(1 - (ePlayer.friction*dt))

		-- bounce off walls
		if (v.x - v.r < 0 and v.dx < 0) or (v.x + v.r > 800 and v.dx >0) then v.dx = -(v.dx) end
		if (v.y - v.r < 0 and v.dy < 0) or (v.y + v.r > 800 and v.dy >0) then v.dy = -(v.dy) end

		-- collide with other enemies (broke as fuck)
		for ii, vv in ipairs(eEnemies) do
			if v.x ~= vv.x and v.y ~= vv.y then -- make sure not the same object
				local dist = getDist(vv.x,vv.y,v.x,v.y) -- distance between object
				-- drain range
				if dist < (vv.r + v.r) * drainDist then
					if vv.r < v.r  and vv.r > minSize then
						vv.r = vv.r - (drainRate*dt)
						v.r = v.r + (drainRate*dt)
					elseif vv.r > v.r and v.r > minSize then
						vv.r = vv.r + (drainRate *dt)
						v.r = v.r - (drainRate * dt)
					end

					--collision range
					if dist < vv.r + v.r then
						local md = vv.r/v.r/3 -- (was /2 ) mass delta
						vv.dx = vv.dx + (v.dx*md)
						vv.dy = vv.dy + (v.dy*md)
						v.dx = v.dx - (vv.dx*md)
						v.dy = v.dy - (vv.dy*md)
					end
				end
			end
		end

		-- choke out high velocities
		if v.dx > maxVel then 
			v.dy = (v.dx - maxVel)/v.dx
			v.dx = maxVel
		end
		if v.dy > maxVel then
			v.dx = (v.dx - maxVel)/v.dx
			v.dy = maxVel
		end

		-- update movement
		v.x = v.x + v.dx
		v.y = v.y + v.dy

		-- update Color
		local size = v.r
		size = size - 10
		if size > 50 then
			v.rgb[1] = 255
			v.rgb[2] = 255 - (255 * (size-50)/50)
		else
			v.rgb[1] = size/50*255
			v.rgb[2] = 255
		end
		v.rgb[3] = 0

	end

end

function eEnemyDraw()
	for i, v in ipairs(eEnemies) do
		love.graphics.setColor(0,0,0,v.alpha)
		love.graphics.circle("fill", v.x, v.y, v.r, 32)
		love.graphics.setColor(v.rgb[1], v.rgb[2], v.rgb[3], v.alpha)
		love.graphics.circle("fill", v.x, v.y, v.r*0.9, 32)
		
		-- angle debug code
		-- love.graphics.setColor(0,255,0,255)
		-- love.graphics.print(v.angle, v.x, v.y)

	end
end

function eEnemySpawn(x,y,radius)

	table.insert(eEnemies, { x = x, y = y, r = radius, angle = 0, dx = 0, dy = 0, rgb = {255,255,255}, alpha = 255, rigid = true})
end

