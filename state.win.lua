-- win screen state

win = state.create('win')
win.fade = true

function win.enter()
	
end

function win.update(dt)
	
end

function win.draw()
	local x = 35
	local y = 40
	print('employment agreement', x, y, 2) y += 10
	print('contract complete', x, y, 2) y += 6
	print('press x to re-apply!', x, y, 2) y += 6
	
end

function win.press() end
function win.hold(secs) end
function win.release(secs)
	state.switch('title')
end

function win.leave()
end
