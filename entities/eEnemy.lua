function eEnemyLoad()
	eEnemies = {}


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

--[[
		for ii,vv in ipairs(eEnemies) do
			if not (v.x == vv.x and v.y==vv.y) then
				if math.sqrt(math.abs(vv.x - v.x)^2 + math.abs(vv.y - v.y)^2) < vv.r + v.r and vv.rigid == true then
					
					local md = vv.r/v.r/2 -- mass delta
					vv.dx = vv.dx + (v.dx*md)
					vv.dy = vv.dy + (v.dy*md)
					v.dx = v.dx - (vv.dx*md)
					v = v.dy - (vv.dy*md)
				end

			end
		end
	]]
		-- update location
		v.x = v.x + v.dx
		v.y = v.y + v.dy
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

