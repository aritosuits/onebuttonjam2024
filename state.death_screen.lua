-- death_scr screen state

death_scr = state.create('death_screen')
death_scr.fade = true

function cause_of_death(name)
	printh(name)
end

function death_scr.enter()
	
end

function death_scr.update(dt)
	
end

function death_scr.draw()
	rectfill(33, 0, 128, 128, 15) -- paper
	spr(192, 34, 2, 8, 4) -- logo
	for x = 34, 128, 2 do pset(x, 36, 2) end -- dotted line
	local x = 35
	local y = 40
	print('employment terminated', x, y, 2) y += 10
	print('reason:', x, y, 2) y += 6
	
	print('      press 🅾️ to restart', x, y, 2) y += 7
	
end

function death_scr.press() end
function death_scr.hold(secs) end
function death_scr.release(secs)

end

function death_scr.leave()
end
