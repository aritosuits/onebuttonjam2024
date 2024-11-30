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
	e:attach('sprite', 0, 2, 3)
	e:attach('physics')
	e:attach('offensive_collider', 2, 18, 12, 6)
	e:attach('defensive_collider', 4, 2, 9, 20)
	e:attach('weapon', 0)
	e:attach('knockback')
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
	e:attach('offensive_collider', 2, 2, 4, 4)
	e:attach('physics', speed or 10, 0, 0)
	e:attach('health', 1)
	e:attach('despawn', 60)
	e:attach('parent', hero)
	return e
end)

assemblage.create('enemy_bullet', function(parent, x, y, speed)
	e = entity.create('enemy_bullet', x, y )
	e:attach('damage', 1)
	e:attach('sprite', 48, 1, 1, 2)
	e:attach('physics', (speed or -10), 0, 0)
	e:attach('offensive_collider', 2, 2, 4, 4)
	e:attach('health', 1)
	e:attach('despawn', 60)
	e:attach('parent', parent)
	if parent.name == 'copier' then  
		e.sprite.num = 51
	elseif parent.name == 'computer' then 
		e.sprite.num = 50
		e.sprite.scale = 1
	elseif parent.name == 'shredder' then 
		e.sprite.num = rnd({57,58})
		e.physics.vx = 0
		e.physics.vy = -5
	end
	return e
end)

--[[
--|| A helper function that adds all general
--|| components that an enemy machine would need.
--]]
assemblage.create('machine', function(type, x, y)
	e = entity.create('machine', x, y)
	e.name = type
	e:attach('physics')
	e:attach('offensive_collider', 0, 0, 8, 8)
	e:attach('frames')
	e:attach('damage',1)
	e:attach('health', 1)
	if type == 'copier' then 
		e:attach('sprite', 52)
		e:attach('defensive_collider', -1, -1, 10, 10)
		e:attach('ai')
	elseif type == 'computer' then 
		e:attach('sprite', 52, 1, 1, 2)
		e:attach('ai_shoot_smrt')
		e:attach('defensive_collider', -1, -1, 10, 10)
		add_anim(e, 'default', {{ num = e.sprite.num }})
		add_anim(e, 'idle', {{ num = e.sprite.num }, { num = 53 }})
		add_anim(e, 'shooting', {{num = 54}})
		e.frames.delay = 3
		change_anim(e, 'idle')
	elseif type == 'shredder' then
		e:attach('sprite', 55, 1, 1, 2)
		e:attach('defensive_collider', -1, -1, 10, 10)
		add_anim(e, 'idle', {{ num = e.sprite.num }, {num = 56}})
		add_anim(e, 'shooting', {{num = 56}})
		e.frames.delay = 3
		change_anim(e, 'idle')
		e:attach('ai_shoot_dumb')
	elseif type == 'cone' then
		e:attach('sprite', 114, 1, 1, 2)
		e:attach('floating')
		add_anim(e, 'default', {{ num = e.sprite.num }, {num = 115}})
		e.frames.delay = 3
		change_anim(e, 'default')
	elseif type == 'wall' then
		e:attach('sprite', 78, 1, 1)
		e.sprite.h = 3
		add_anim(e, 'default', {{ num = e.sprite.num }, {num = 79}})
		e:attach('floating')
	else 
		e:attach('sprite', 1)
		e:attach('floating')
		--e:attach('ai_shoot_dumb')
		add_anim(e, 'default', {{ num = 1 }})
		add_anim(e, 'idle', {{ num = 1 }})
		change_anim(e, 'idle')
	end
	-- ...

	return e
end)
