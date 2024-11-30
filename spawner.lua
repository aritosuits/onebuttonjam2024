-- spawning system

hero = {}

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
	for x = 0, 128 do
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
	spawner.update(1/30)
end

function spawner.update(dt)
	-- screen left is hero.x - 30
	local hero_x = (hero and hero.x) or 0
	local screen_right = flr((hero_x - 30)) + 128 + 32
	for s in all(spawner.queue) do
		if s.x <= screen_right then
			if s.type == 'player' then
				hero = assemblage.player(s.x, s.y)
			else
				assemblage.machine(s.type, s.x, s.y)
			end
			del(spawner.queue, s)
		end
	end
end
