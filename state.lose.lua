-- lose screen state

lose = state.create('lose')
lose.fade = true

function lose.enter()
	
end

function lose.update(dt)
	
end

function lose.draw()
	local x = 35
	local y = 40
	print('you\'re fired!', x, y, 2) y += 6
	
end

function lose.press() end
function lose.hold(secs) end
function lose.release(secs)
	state.switch('title')
end

function lose.leave()
end
