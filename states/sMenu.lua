function sMenuLoad()
	menuItems = {"menu", "play", "help", "credits", "quit"}
	menuItem = 2
end


function sMenuUpdate(dt)


end


function sMenuDraw()
	love.graphics.setFont(font12)
	for x = 2, 5 do
		local text = menuItems[x]
		if x == menuItem then
			text = ">> " .. text .. " <<"
		end
		love.graphics.print(text, math.floor(love.graphics.getWidth()/2 - (font12:getWidth(text)/2)), math.floor(love.graphics.getHeight()/11*((x-1)*2)) )
	end

end


function sMenuKeyPressed(k,u)

end


function sMenuKeyReleased(k,u)
	if k == 'down' or k == 's' then menuItem = menuItem + 1 end
	if k == 'up' or k == 'w' then menuItem = menuItem - 1 end
	if menuItem > 5 then menuItem = 2 end
	if menuItem < 2 then menuItem = 5 end
	if k == 'return' then statesChangeState(menuItems[menuItem]) end

end


function sMenuMousePressed(x,y,button)

end


function sMenuMouseReleased(x,y,button)

end