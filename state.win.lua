-- win screen state

win = state.create('win')
win.fade = true

function win.enter()
	win.lock = 120
	music(-1)
	music(10)
	scroll.init(win, 9, 'employee #' .. (flr(rnd(1000)) + 1000) .. '|contract complete||congratulations|please enjoy this tune|and a fully working|printer that is|entirely thanks to you||you earned $' .. score.points .. '|in bonuses which|will be paid out|in a few years||.....................|.....................|.....................|........ ........:...|...%.. .#.:....:.. ..|.%#%.%.@#&:*..: :.. ..|    : . . .  ! . .|:press/🅾️:to re-apply#')
end

function win.update(dt)
	win.lock -= 1
	scroll.update(dt)
end

function win.draw()
	scroll.draw()
end

function win.press() end
function win.hold(secs) end
function win.release(secs)
	if win.lock <= 0 then
		sfx(40)
		reload()
		state.switch('title')
	end
end

function win.leave()
end
