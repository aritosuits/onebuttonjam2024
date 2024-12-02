-- scroll system

scroll = {}

function scroll.init(obj, color, text)
	scroll.obj = obj
	scroll.obj.line = -30
	scroll.obj.char = 0
	scroll.obj.color = color
	scroll.obj.accumulator = 0
	scroll.obj.logo = rnd(1) / 100 + 1
	scroll.obj.text = split(text, '|')
	scroll.obj.height = #scroll.obj.text * 6 + 50
	scroll.obj.mult = flr(scroll.obj.height / 55)
end

function scroll.update(dt)
	scroll.obj.accumulator = (scroll.obj.accumulator + 1) % 1
	if scroll.obj.accumulator == 0 then
		if scroll.obj.line > #scroll.obj.text then return end
		local m = 0
		if scroll.obj.line > 0 then
			m = #scroll.obj.text[scroll.obj.line]
		end
		scroll.obj.char += 1
		if scroll.obj.char > m then
			sfx(43)
			scroll.obj.line += 1
			scroll.obj.char = 1
		end
	end
end

function scroll.draw()
	cls()
	camera(0, scroll.obj.line * scroll.obj.mult)
	rectfill(18, 0, 128 - 17, scroll.obj.height, scroll.obj.color) -- paper
	spr_r(192, 7.9, 4, 64, 20, scroll.obj.logo, 0.999)

	local xo = 21
	local yo = 41
	if scroll.obj.line > 0 then
		for y = 1, scroll.obj.line - 1 do
			print(scroll.obj.text[y], xo, yo)
			yo += 6
		end
		if scroll.obj.char > 0 then for x = 1, scroll.obj.char - 1 do
			local c = sub(scroll.obj.text[scroll.obj.line], 1, x)
			print(c, xo, yo, 2)
		end end
	end
end
