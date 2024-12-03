-- assemblages

--[[
--|| A helper function that adds all general
--|| components that a player needs.
--]]
assemblage.create('player', function(x, y)
	e = entity.create('player', x, y)
	e:attach('controller')
	e:attach('health', 0, 17)
	e:attach('sprite', 0, 2, 3)
	e:attach('physics')
	e:attach('offensive_collider', 0, 18, 17, 6)
	e:attach('defensive_collider', 4, 2, 9, 18)
	e.offensive_collider.enabled = false
	e:attach('knockable')
	e:attach('collector')
	e:attach('tossable', 1, 1.25, true)
	e:attach('stats')
	e:attach('sound_on_despawn', 30)
	e:attach('sound_on_damage', 31)
	e:attach('on_damage', subsystem.throw_code)
	if GOD_MODE then
		e:attach('on_despawn', function() return true end)
	else
		e:attach('on_despawn', function()
			state.switch('lose')
		end)
	end
	e:attach('frames')
	e:attach('scorer')
	e:attach('damage', 1)
	add_anim(e, 'default', '0')
	add_anim(e, 'jump', '64')
	add_anim(e, 'kick', '66')
	add_anim(e, 'walk', '2,4,6,8,10,12,14')
	e.frames.delay = 3
	change_anim(e, 'walk')
	e:attach('player')
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
	e:attach('health', 1, 1)
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

assemblage.create('box', function(x, y)
	e = entity.create(type, x, y)
	e:attach('frames')
	e:attach('enemy_team')
	e:attach('health', 1, 1)
	e:attach('knockback', -2)
	e:attach('sprite', 62, 1, 1, 2)
	e:attach('bounce', 0, -5)
	add_anim(e, 'default', '62')
	add_anim(e, 'crushed', '63')
	change_anim(e, 'default')
	e:attach('defensive_collider', 1, 2, 12, 14)
	e:attach('floating')
	e:attach('damage', 0)
	e:attach('crushable')
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
	e:attach('damage', 1)
	e:attach('enemy_team')
	e:attach('health', 1, 1)
	e:attach('scorable', 10)
	e:attach('tossable')
	e:attach('knockback', -2)
	if type == 'copier' or type == 'computer' or type == 'shredder' then
		e:attach('collector')
		e:attach('defensive_collider', 0, 0, 16, 16)
		e:attach('offensive_collider', 2, 2, 16 - 4, 16 - 4)
		if type == 'copier' then
			e:attach('sprite', 68, 2, 2, 1)
			e:attach('ai_boss')
			e:attach('on_despawn', subsystem.boss_complete)
			add_anim(e, 'default', '68')
			add_anim(e, 'idle', '68,70')
			add_anim(e, 'shoot', '72')
			add_anim(e, 'lunge', '74')
			e.frames.delay = 4
			change_anim(e, 'idle')
			e:attach('bounce')
			e:attach('health', 4, 4)
			e:attach('movement')
			e:detach('knockback')
		elseif type == 'computer' then
			e:attach('sprite', 52, 1, 1, 2)
			e:attach('ai_shoot_smrt')
			add_anim(e, 'default', '52')
			add_anim(e, 'idle', '52,53')
			add_anim(e, 'shooting', '54')
			e.frames.delay = 3
			change_anim(e, 'idle')
			e:attach('bounce')
		elseif type == 'shredder' then
			e:attach('sprite', 55, 1, 1, 2)
			add_anim(e, 'default', '55')
			add_anim(e, 'idle', '55,56')
			add_anim(e, 'shooting', '56')
			e.frames.delay = 3
			change_anim(e, 'idle')
			e:attach('ai_shoot_dumb')
			e:attach('bounce')
		end
	elseif type == 'cone' or type == 'wall' or type == 'fan' then
		e:attach('floating')
		if type == 'cone' then
			e:attach('sprite', 114, 1, 1, 1.5)
			add_anim(e, 'default', '114,115')
			e.frames.delay = 3
			change_anim(e, 'default')
			e:attach('offensive_collider', 4, 2, 4, 12)
		elseif type == 'wall' then
			e:attach('sprite', 78, 1, 1)
			e.sprite.h = 3
			add_anim(e, 'default', '78,79')
			e:attach('offensive_collider', 2, 1, 2, 23)
		elseif type == 'fan' then
			e:attach('sprite', 76, 2, 1)
			e.sprite.scale = 2
			add_anim(e, 'default', '76,92,108')
			e.frames.delay = 1
			e:attach('offensive_collider', 10, 10, 14, 4)
			e:attach('knockback', -3, 7)
		end
	end
	return e
end)

assemblage.create('button', function(x, y)
	e = entity.create('button', x, y)
	e:attach('health', 1)
	e.name = 'button'
	e:attach('sprite', 59, 1, 1)
	e.sprite.scale = 2
	e:attach('defensive_collider', 0, 6, 16, 8)
	e:attach('on_despawn', subsystem.push_button)
	e:attach('frames')
	add_anim(e, 'default', '59')
	add_anim(e, 'pressed', '60')
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

function rnd_str(str)
	local i = flr(rnd(#str)) + 1
	return sub(str, i, i)
end

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
		e:attach('defensive_collider', -1, -1, 9, 10)
	end
	e:attach('recttext', 12, letter or rnd_str('01234567890abcdef'))
	return e
end)

assemblage.create('ceiling', function(x, y)
	local vx = rnd(2) - 1
	local vy = rnd(2) - 4
	e = entity.create('ceiling', x, y)
	e:attach('gravity')
	e:attach('friction')
	e:attach('physics', vx, vy)
	e:attach('sprite', 174)
	e:attach('defensive_collider')
	e:attach('despawn', 60)
	return e
end)
