-- title screen state

title = state.create('title')
title.fade = true

function title.enter()
	music(10)
	title.line = -30
	title.paw = false
	title.char = 0
	title.accumulator = 0
	title.text = split('employment agreement|......................||thank you for applying|to dome enterprises.||your job will be to|investigate why the|printer isn\'t wo%King|correctly after|embers, ari and sun|our program#ers|insta!!ed the last|buggy upd*te. .$)&&&$|   1 btn$* j@m *! ^  :|your supervisor %&*|requests{ that you|refrain* from stomping|or jumping in your|cubicle += we have|sustained recent|damage from <undef>|employees doing so.|   i1   \' ` ~!:  .|press 🅾️ to sign this|agreement and clock in!|$*%)@!mwa#ah!@*@(@#||X..........%:.:.......||○2024 dangerous office| machine enterprises|         #::.|*  ($% ]*  (&h @% @#$', '|')
end

function title.update(dt)
	title.accumulator = (title.accumulator + 1) % 1
	if title.accumulator == 0 then
		if title.line > #title.text then return end
		local m = 0
		if title.line > 0 then
			m = #title.text[title.line]
		end
		title.char += 1
		if title.char > m then
			sfx(43)
			title.line += 1
			title.char = 1
		end
	end
end

function title.draw()
	cls()
	camera(0, title.line * 4)
	rectfill(18, 0, 128 - 17, 250, 15) -- paper
	-- spr(192, 34, 2, 8, 4) -- logo
	spr_r(192, 8, 4, 64, 20, 1.0075, 0.999)

	local xo = 21
	local yo = 41
	if title.line > 0 then
		for y = 1, title.line - 1 do
			print(title.text[y], xo, yo)
			yo += 6
		end
		if title.char > 0 then for x = 1, title.char - 1 do
			local c = sub(title.text[title.line], 1, x)
			print(c, xo, yo, 2)
		end end
	end

	if title.paw then
		spr(106, 40, 202, 2, 2)
	end

--[[
	print('x, y, 2) y += 10
	print(', x, y, 2) y += 6
	print(''
	      '', x, y, 2) y += 6
	print('', x, y, 2) y += 6
	print('x, y, 2) y += 6
	print(', x, y, 2) y += 6
	print(', x, y, 2) y += 10
	print(' x, y, 2) y += 7
	for x = 34, 128, 2 do pset(x, y, 2) end -- dotted line
	line(40, 105, 45, 110, 2) -- x
	line(40, 106, 45, 111, 2) -- x
	line(45, 105, 40, 110, 2) -- x
	line(45, 106, 40, 111, 2) -- x
	line(40, 113, 119, 113, 2) -- signature line
	print(', x, 116, 2)
	print('x, 122, 2)
	if title.signature > 0 then
		spr(200, 55, 104, title.signature, 1) -- signature
	end
	spr(216, title.hand_x, title.hand_y, 4, 3) -- hand
	]]
end

function title.press() end
function title.hold(secs) end
function title.release(secs)
	title.paw = true
	sfx(40)
	state.switch('game')
end

function title.leave()
	music(-1)
end
