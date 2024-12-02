-- lose screen state

lose = state.create('lose')
lose.fade = true

function lose.enter()
	
end

function lose.update(dt)
	
end

function lose.draw()
	rectfill(33, 0, 128, 128, 15) -- paper
	spr(192, 34, 2, 8, 4) -- logo
	for x = 34, 128, 2 do pset(x, 36, 2) end -- dotted line
	local x = 35
	local y = 40
	print('employment terminated', x, y, 2) y += 10
	print('reason:', x, y, 2) y += 6
	
	print('      press 🅾️ to restart', x, y, 2) y += 7
	
end

function lose.press() end
function lose.hold(secs) end
function lose.release(secs)

end

function lose.leave()
end
