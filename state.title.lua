-- title screen state

title = state.create('title')
title.fade = true

function title.enter()
	title._sign = false
	title._leaving = false
	title._signature = 0
	title._accumulator = 0
	title._hand_x = 43
	title._hand_y = 104
end

function title.update(dt)
end

function title.draw()
	rectfill(33, 0, 128, 128, 15) -- paper
	spr(192, 34, 2, 8, 4) -- logo
	for x = 34, 128, 2 do pset(x, 36, 2) end -- dotted line
	local x = 35
	local y = 40
	print('employment agreement', x, y, 2) y += 10
	print('thank you for applying', x, y, 2) y += 6
	print('to dome enterprises. we', x, y, 2) y += 6
	print('instantly hire every', x, y, 2) y += 6
	print('applicant, and we have', x, y, 2) y += 6
	print('the safest facilities!', x, y, 2) y += 10
	print('      press 🅾️ to sign', x, y, 2) y += 7
	for x = 34, 128, 2 do pset(x, y, 2) end -- dotted line
	line(40, 105, 45, 110, 2) -- x
	line(40, 106, 45, 111, 2) -- x
	line(45, 105, 40, 110, 2) -- x
	line(45, 106, 40, 111, 2) -- x
	line(40, 113, 119, 113, 2) -- signature line
	print('○2024 dangerous office', x, 116, 2)
	print(' machine enterprises', x, 122, 2)
	if title._signature > 0 then
		spr(200, 55, 104, title._signature, 1) -- signature
	end
	spr(216, title._hand_x, title._hand_y, 4, 3) -- hand
end

function title.press() end
function title.hold(secs) end
function title.release(secs)
	title._sign = true
end

function title.leave()
end
