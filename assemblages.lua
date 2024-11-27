-- assemblages

--[[
--|| A helper function that adds all general
--|| components that a player needs.
--]]
assemblage.create('player', function(x, y)
	e = entity.create('player', x, y)
	e:attach('controller')
	e:attach('autorun', 30)
	e:attach('health', 3)
	e:attach('sprite', 0)
	e:attach('physics')
	e:attach('collider', 0, 0, 8, 8)
	e:attach('weapon', 0)
	e:attach('frames')
	add_anim(e, 'jump', {{ num = 32, delay = 1 }, { num = 33, delay = 2 }})
	add_anim(e, 'walk', {{ num = 48 }, { num = 49 }, { num = 50 }, { num = 51 }})
	change_anim(e, 'walk')
	return e
end)

--[[
--|| A helper function to make a player bullet.
--]]
assemblage.create('player_bullet', function(x, y, speed)
	e = entity.create('player_bullet', x, y)
	e:attach('projectile', 1)
	e:attach('sprite', 1)
	e:attach('despawn', 60) -- 2 seconds
	e:attach('collider', 2, 2, 4, 4)
	e:attach('physics', speed or 10, 0, 0)
	return e
end)

--[[
--|| A helper function that adds all general
--|| components that an enemy machine would need.
--]]
assemblage.create('machine', function(type, x, y)
	e = entity.create('machine', x, y)
	e:attach('health', 3) -- default
	if type == 'copier' then
		e:attach('sprite', 1)
		e.health = 2
		e:attach('ai_stationary')
	elseif type == 'fax' then
		e.health = 17
		e:attach('sprite', 2)
		e:attach('ai_jump')
		e:attach('ai_shoot')
	end
	e:attach('physics')
	-- ...
	return e
end)
