-- assemblages

--[[
--|| A helper function that adds all general
--|| components that a player needs.
--]]
assemblage.create('player', function(x, y)
	e = entity.create('player', x, y)
	e:attach('controller')
	e:attach('autorun', 30)
	e:attach('health', 3, true)
	e:attach('sprite', 0, 2, 3)
	e:attach('physics')
	e:attach('collider', 0, 0, 8, 8)
	e:attach('weapon', 0)
	e:attach('frames')
	add_anim(e, 'default', {{ num = 0 }})
	add_anim(e, 'jump', {{ num = 64 }})
	add_anim(e, 'kick', {{ num = 66 }})
	add_anim(e, 'walk', {{ num = 2 }, { num = 4 }, { num = 6 }, { num = 8 }, { num = 10 }, { num = 12 }, { num = 14 }})
	e.frames.delay = 3
	change_anim(e, 'walk')
	e:attach('player')
	return e
end)

--[[
--|| A helper function to make a player bullet.
--]]
assemblage.create('player_bullet', function(x, y, speed)
	e = entity.create('player_bullet', x, y)
	e:attach('damage', 1)
	e:attach('recttext', 6, 'A')
	e:attach('despawn', 60) -- 2 seconds
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
	e:attach('physics')
	e:attach('collider', 0, 0, 8, 8)
	e:attach('frames')
	if type == 'copier' then 
		e:attach('sprite', 52)
		e.health = 2
		e:attach('ai')
		e:attach('damage',1)
	elseif type == 'computer' then 
		e:attach('sprite', 52)
		e.health = 10
		e:attach('ai')
		e:attach('ai_brain')
		e:attach('bullet',1)
		add_anim(e, 'default', {{ num = 52 }})
		add_anim(e, 'idle', {{ num = 52 }, { num = 53 }})
		add_behavior(e, 'shooter', {{54, 2}})
		e.frames.delay = 3
		change_anim(e, 'idle')
		--add_anim(e, 'shoot', {{num = 220}})
	elseif type == 'cone' then
		e:attach('sprite', 114, 1, 1, 12, 12)
		e.health = 20
		--e:attach('sprite', 114, 1, 1)
		-- this damage is somehow never dealt.
		e:attach('damage', 10)
		e:attach('floating')
		e:attach('bullet',1)
		add_anim(e, 'default', {{ num = 114 }, {num = 115}})
		e.frames.delay = 3
		change_anim(e, 'default')
	else 
		e:attach('sprite', 52)
		e:attach('health', 3)
		e:attach('floating')
		e:attach('ai')
		e:attach('ai_brain')
		e:attach('bullet',1)
		e:attach('movement', 20, 15, 0, true)
		add_anim(e, 'default', {{ num = 52 }})
		add_anim(e, 'idle', {{ num = 52 }, { num = 53 }})
		change_anim(e, 'idle')
	end
	-- ...

	return e
end)

--assemblage.create('healthSprite', function(index, full)
--	e = entity.create('healthSprite', (index - 1) * 9, y or 3, full or true)
--	printh("full: " ..tostr(full))
--	if full then 
--		e:attach('sprite', 223)
--	else 
--		e:attach('sprite', 207)
--	end
--	e:attach('physics')
--	e:attach('autorun', 30)
--	return e
--end)
