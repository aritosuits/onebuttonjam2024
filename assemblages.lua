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
	e:attach('player')
	return e
end)

--[[
--|| A helper function to make a player bullet.
--]]
assemblage.create('player_bullet', function(x, y, speed)
	e = entity.create('player_bullet', x, y)
	e:attach('damage', 1)
	e:attach('sprite', 1)
	e:attach('collider', 2, 2, 4, 4)
	e:attach('physics', speed or 10, 0, 0)
	e:attach('health', 1)
	e:attach('despawn', 60)
	return e
end)

assemblage.create('enemy_bullet', function(x, y, speed)
	e = entity.create('enemy_bullet', x, y)
	e:attach('damage', 1)
	e:attach('sprite', 1)
	e:attach('collider', 2, 2, 4, 4)
	e:attach('physics', -1 * speed or -10, 0, 0)
	e:attach('health', 1)
	e:attach('despawn', 60)
	return e
end)

--[[
--|| A helper function that adds all general
--|| components that an enemy machine would need.
--]]
assemblage.create('machine', function(type, x, y, health)
	e = entity.create('machine', x, y)
	if type == 'copier' then 
		e:attach('sprite', 0)
		e.health = 2
		e:attach('ai_stationary')
	elseif type == 'fax' then 
		e:attach('sprite', 0)
		e.health = 17
		e:attach('ai_shooting')
	else 
		e:attach('sprite', 0)
		e:attach('health', 3)
		e:attach('ai_stationary')
	end
	e:attach('physics')
	e:attach('collider', 0, 0, 8, 8)
	-- ...
	return e
end)
