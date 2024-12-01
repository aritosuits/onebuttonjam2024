-- assemblages

--[[
--|| A helper function that adds all general
--|| components that a player needs.
--]]
assemblage.create('player', function(x, y)
	e = entity.create('player', x, y)
	e:attach('controller')
	e:attach('health', 3)
	e:attach('sprite', 0, 2, 3)
	e:attach('physics')
	e:attach('offensive_collider', 2, 18, 14, 6)
	e:attach('defensive_collider', 4, 2, 9, 20)
	e.offensive_collider.enabled = false
	e:attach('weapon', 0)
	e:attach('knockable')
	e:attach('frames')
	e:attach('damage', 1)
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
	e:attach('bullet')
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

assemblage.create('enemy_bullet', function(parent, x, y, speed, knockback_vx)
	e = entity.create('enemy_bullet', x, y )
	e:attach('bullet')
	e:attach('damage', 1)
	e:attach('sprite', 48, 1, 1, 2)
	e:attach('physics', (speed or -10), 0, 0)
	e:attach('offensive_collider', 2, 2, 4, 4)
	e:attach('defensive_collider', 2, 2, 4, 4)
	e:attach('health', 1)
	e:attach('enemy_team')
	e:attach('tossable')
	e:attach('bounce')
	e:attach('knockback', knockback_vx or -2)
	e:attach('despawn', 60)
	e:attach('parent', parent)
	if parent.name == 'copier' then
		e.sprite.num = 51
		e.sprite.scale = 1.33
		e:detach('knockback')
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
	e = entity.create(type, x, y)
	e:attach('physics')
	e:attach('offensive_collider', 0, 0, 8, 8)
	e:attach('frames')
	e:attach('damage',1)
	e:attach('enemy_team')
	e:attach('health', 1)
	e:attach('scorable', 10)
	e:attach('tossable')
	e:attach('knockback', -2)
	if type == 'copier' then 
		e:attach('sprite', 52, 2, 2, 1)
		e:attach('defensive_collider', 1, -1, 16, 16)
		e:attach('offensive_collider', 3, 1, 8, 8)
		e:attach('ai_boss')
		add_anim(e, 'default', {{num = 68}})
		add_anim(e, 'idle', {{num = e.sprite.num}, {num = 70}})
		add_anim(e, 'shoot', {{num = 72}})
		add_anim(e, 'lunge', {{num = 74}})
		e.frames.delay = 4
		change_anim(e, 'idle')
		e:attach('bounce')
		e:attach('health', 4)
		e:attach('movement')
		e:detach('tossable')
		e:detach('knockback')

		--  e:attach('repeat_every', 90, function(e)
		-- 	if e.ai_boss.can_shoot then
		-- 		if e.ai_boss.ttsa <= 0 then
		-- 		-- printh('boss shooting player')
		-- 	 	change_anim(e, 'shooting', true)
		-- 	 	assemblage.enemy_bullet(e, e.x + 2, e.y + 1, -2, 0)
		-- 	 	change_anim(e, 'idle', false)
		-- 	 	e.ai_boss.ttsa = 30
		-- 		else 
		-- 			e.ai_boss.ttsa -= 1
		-- 		end
		-- 	end
		--  end)

		--  e:attach('do_after', 180, function(e)
		-- 	if not e.ai_boss.is_lunging then
		-- 		e.ai_boss.can_shoot = false
		-- 		e.ai_boss.is_lunging = true
		-- 		e.attach('physics', 20, 0, 0)
		-- 	elseif (abs(e.x - hero.x) <= 5) then 
		-- 		e.attach('physics', -20, 0, 0)
		-- 	else

		-- 	end
		--  end)
		--  e:attach('do_after', 420, function(e)
		-- 	e.ai_boss.can_shoot = true
		--  end)
-- 
		-- e:attach('repeat_every', 30, function(e)
			-- if (abs(e.x - hero.x) <= e.ai_boss.max_range_lunge) and (abs(e.x - hero.x) > 5) then
				-- printh('trying to lunge at player') 
				-- change_anim(e, 'lunge', true)
				-- is_lunging = true
				-- printh('moving forward!')
				-- e.physics.speed = -15
				-- lerp(hero.x, e.x, 30)
			-- end
		-- end)
		-- e:attach('repeat_every', 30, function(e)
			-- if (abs(e.x - hero.x) <= e.ai_boss.max_range_lunge) then
				-- printh('trying to move back') 
				-- change_anim(e, 'lunge', true)
				-- is_lunging = false
				-- printh('moving forward!')
				-- e.physics.speed = -10
				-- e.physics.vx -=16
			-- end
		-- end)

	elseif type == 'computer' then 
		e:attach('sprite', 52, 1, 1, 2)
		e:attach('ai_shoot_smrt')
		e:attach('defensive_collider', -1, -1, 10, 10)
		add_anim(e, 'default', {{ num = e.sprite.num }})
		add_anim(e, 'idle', {{ num = e.sprite.num }, { num = 53 }})
		add_anim(e, 'shooting', {{num = 54}})
		e.frames.delay = 3
		change_anim(e, 'idle')
		e:attach('defensive_collider', 0, 0, e.sprite.scale * 8, e.sprite.scale * 8)
		e:attach('bounce')
	elseif type == 'shredder' then
		e:attach('sprite', 55, 1, 1, 2)
		e:attach('defensive_collider', -1, -1, 10, 10)
		add_anim(e, 'default', {{ num = e.sprite.num }})
		add_anim(e, 'idle', {{ num = e.sprite.num }, {num = 56}})
		add_anim(e, 'shooting', {{num = 56}})
		e.frames.delay = 3
		change_anim(e, 'idle')
		e:attach('ai_shoot_dumb')
		e:attach('defensive_collider', 0, 0, e.sprite.scale * 8, e.sprite.scale * 8)
		e:attach('bounce')
	elseif type == 'cone' then
		e:attach('sprite', 114, 1, 1, 1.5)
		e:attach('floating')
		add_anim(e, 'default', {{ num = e.sprite.num }, {num = 115}})
		e.frames.delay = 3
		change_anim(e, 'default')
		e:attach('offensive_collider', 4, 2, 4, 12)
	elseif type == 'wall' then
		e:attach('sprite', 78, 1, 1)
		e.sprite.h = 3
		add_anim(e, 'default', {{ num = e.sprite.num }, {num = 79}})
		e:attach('offensive_collider', 2, 1, 2, 23)
		e:attach('floating')
	elseif type == 'fan' then
		e:attach('sprite', 76, 2, 1)
		e.sprite.scale = 2
		add_anim(e, 'default', {{ num = e.sprite.num }, {num = 92 }, {num = 108}})
		e.frames.delay = 1
		e:attach('offensive_collider', 10, 10, 14, 4)
		e:attach('floating')
		e:attach('knockback', -3, 7)
	elseif type == 'box' then
		e:attach('sprite', 62, 1, 1, 2)
		e:attach('bounce', 0, -5)
		add_anim(e, 'default', {{ num = e.sprite.num }})
		add_anim(e, 'crushed', {{num = 63}})
		change_anim(e, 'default')
		e:attach('defensive_collider', 6, 2, 4, 14)
		e:detach('offensive_collider')
		e:attach('floating')
		e:detach('damage')
		e:attach('damage', 0)
		e:attach('crushable')
		e:detach('tossable')
	else 
		printh("using default machine flow")
		e:attach('sprite', 1)
		e:attach('floating')
		add_anim(e, 'default', {{ num = 1 }})
		add_anim(e, 'idle', {{ num = 1 }})
		change_anim(e, 'idle')
	end
	return e
end)

assemblage.create('button', function (x, y)
	e = entity.create('button', x, y)
	e:attach('tutorial')
	e:attach('health', 1)
	e.name = 'button'
	e:attach('sprite', 59, 1, 1)
	e.sprite.scale = 2
	e:attach('defensive_collider', 0, 6, e.sprite.scale * 8, 8)
	e:attach('frames')
	add_anim(e, 'default', {{num = e.sprite.num}})
	add_anim(e, 'pressed', {{num = 60}})
	return e
end)

assemblage.create('door', function(type, x, y, tele_x, tele_y, autorun, ends_game)
	e = entity.create(type, x, y)
	e:attach('sprite', 101, 2, 2)
	e.sprite.scale = 1.5
	e:attach('teleport', tele_x or (2 * 8), tele_y or (9 * 8), autorun, ends_game)
	e:attach('defensive_collider', 17, -8, e.sprite.scale * 19, e.sprite.scale * 16)
	return e
end)

assemblage.create('collectable', function(type, x, y, letter, vx, vy)
	vx = vx or 0
	vy = vy or 0
	e = entity.create(type, x, y)
	e:attach('collectable', type)
	e:attach('gravity')
	e:attach('friction')
	if vx != 0 or vy != 0 then
		e:attach('physics', vx, vy)
		e:attach('collectable_delay')
	else
		e:attach('defensive_collider')
	end
	e:attach('recttext', 12, letter or rnd({'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'a', 'b', 'c', 'd', 'e', 'f'}))
	return e
end)
