function eEnemyLoad()
	eEnemies = {}


end


function eEnemyUpdate(dt)
	for i, v in ipairs(eEnemies) do

	end

end

function eEnemyDraw()
	for i, v in ipairs(eEnemies) do
		love.graphics.setColor(0,0,0,v.alpha)
		love.graphics.circle("fill", v.x, v.y, v.r, 32)
		love.graphics.setColor(v.rgb[1], v.rgb[2], v.rgb[3], v.alpha)
		love.graphics.circle("fill", v.x, v.y, v.r*0.9, 32)

	end
end

function eEnemySpawn(x,y,radius)

	table.insert(eEnemies, { x = x, y = y, r = radius, rgb = {255,255,255}, alpha = 255})
end

