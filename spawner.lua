-- spawning system

function in_table(needle, haystack)
	for k, v in pairs(haystack) do
		if v == needle then
			return true
		end
	end
	return false
end
function table_index(needle, haystack)
	for k, v in pairs(haystack) do
		if v == needle then
			return k
		end
	end
	return -1
end

spawner = {}

spawner.lookup = { 'player', 'cone', 'wall', 'shredder', 'computer', '', '', 'copier' }
spawner.items = { 204, 205, 206, 207, 220, 221, 222, 223 }
spawner.queue = {}

function spawner.init()
	spawner.queue = {}
	for x = 0, 16 do
		for y = 0, 16 do
			for i in pairs(spawner.items) do
				if in_table(mget(x, y), spawner.items) then
					local which = table_index(mget(x, y), spawner.items)
					mset(x, y, nil)
					add(spawner.queue, { x = x * 8, y = y * 8, type = spawner.lookup[which] })
				end
			end
		end
	end
end

function spawner.update(dt)
	-- screen left is hero.x - 30
	screen_right = flr((hero.x - 30) / 8) + 16
	for s in all(spawner.queue) do
		if s.x <= screen_right then
			assemblage.machine(s.type, s.x, s.y)
			del(spawner.queue, s)
		end
	end
end
