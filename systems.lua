-- systems

gravity = 8
ground = 0

-- From: https://pico-8.fandom.com/wiki/Draw_zoomed_sprite_(zspr)
function zspr(n,w,h,dx,dy,dz)
	sx = 8 * (n % 16)
	sy = 8 * flr(n / 16)
	sw = 8 * w
	sh = 8 * h
	dw = sw * dz
	dh = sh * dz
	sspr(sx,sy,sw,sh, dx,dy,dw,dh)
  end

system.create('display', {'sprite'},
	nil,
	function(e)
		if e.hidden then return end
		local s = e.sprite.num
		if e:has('frames') and e.frames[e.frames.anim] then
			s = e.frames[e.frames.anim][e.frames.frame][1]
		end
		local iframes = false
		if e:has('iframes') and e.iframes.flash then
			iframes = true
			for n = 1, 16 do
				pal(n, 7)
			end
		end
		if e.sprite.scale > 1 then 
			zspr(s, e.sprite.w, e.sprite.h, e.x, e.y, e.sprite.scale)
		else
			spr(s, e.x, e.y, e.sprite.w, e.sprite.h)
		end
		if iframes then pal() end
	end
)

function recttext(frame, letter, x, y)
	if e.hidden then return end
	spr(124 + frame, x, y)
	if frame == 0 then
		print(letter, x + 2, y + 1, 7)
	elseif frame == 1 or frame == 3 then
		print('|', x + 2, y + 1, 7)
	end
end
system.create('recttext_display', {'recttext'},
	function(e, dt)
		e.recttext.accumulator = (e.recttext.accumulator % e.recttext.delay) + 1
		if e.recttext.accumulator == e.recttext.delay - 1 then
			e.recttext.frame = (e.recttext.frame + 1) % 4
		end
	end,
	function(e)
		recttext(e.recttext.frame, e.recttext.char, e.x, e.y)
	end
)

system.create('controller', {'controller', 'physics'},
	function(e, dt)
		if e.physics.smashing >= 0 then e.physics.smashing += 1 end
		if e.controller.press then
			e.controller.press = false
			if e.physics.grounded then
				e.physics.vy = -6.5
				particle.create('smoke', e.x + 10, e.y + 21, 5)
				sfx(32)
			else
				e.physics.vy = 6
				change_anim(e, 'kick')
				e.physics.smashing = 0
				e:attach('smash')
				e.offensive_collider.enabled = true
				particle.create('trail', e.x + 8, e.y + 12, 8)
			end
		elseif e.controller.release then
			e.controller.release = false
		elseif e.controller.hold then
			e.controller.hold = false
		end
	end,
	nil
)

system.create('machine', {'omg', 'controller', 'physics'},
	function(e, dt)
		if e.controller.press then
			e.controller.press = false
			if e:has('player') then
				assemblage.player_bullet(e.x + 2, e.y + 1, 6)
			else 
				assemblage.enemy_bullet(e, e.x + 2, e.y + 1, 6)
			end
		elseif e.controller.release then
			e.controller.release = false
		elseif e.controller.hold then
			e.controller.hold = false
			if e.controller.secs >= 0.1 and e.physics.grounded then
				e.physics.vy = -3.5
			end
		end
	end,
	nil
)

system.create('gravity', {'defensive_collider', 'physics'},
	function(e, dt)
		if e:has('floating') then return end 
		if e.physics.mass <= 0 then return end
		-- the hardcoded 80 should be removed
		-- and a ground collider added if we want pits
		local scale = 1
		local height = 8
		if e:has('sprite') then
			scale = e.sprite.scale
			height = e.sprite.h * 8
		end
		if e.y + height * scale < ground then
			e.physics.vy += gravity * dt
			if e.physics.grounded then
				e.physics.grounded = false
				if e:has('frames') then
					change_anim(e, 'jump')
				end
			end
		else
			e.physics.vy /= 1.5
			e.y = ground - height * scale
		 	if not e.physics.grounded then
				e.physics.grounded = true
				if e:has('frames') then
					change_anim(e, 'walk')
				end
				if e:has({'smash'}) then
					subsystem.smash_collide(e)
				else
					particle.create('smoke', e.x + 10, e.y + 21, 10)
				end
			end
		end
	end,
	nil
)

system.create('friction', {'friction', 'defensive_collider', 'physics'},
	function(e, dt)
		local scale = 1
		local height = 8
		if e:has('sprite') then
			scale = e.sprite.scale
			height = e.sprite.h * 8
		end
		if e.y + height * scale >= ground then
			e.physics.vx *= 0.95
		end
	end,
	nil
)

system.create('autorun', {'physics', 'autorun'},
	function(e, dt)
		e.physics.vx /= 1.05
		e.physics.vx += 2.0 * dt
		if e.physics.vx >= e.autorun.speed * dt then
			e.physics.vx = e.autorun.speed * dt
		end
	end,
	nil
)

system.create('boss_autorun', {'physics', 'boss_autorun'},
	function(e, dt)
		e.physics.vx /= 1.05
		e.physics.vx += 222.0 * dt
		if e.physics.vx >= e.boss_autorun.speed * dt then
			e.physics.vx = e.boss_autorun.speed * dt
		end
	end,
	nil
)

system.create('physics', {'physics'},
	function(e, dt)
		e.x += e.physics.vx
		e.y += e.physics.vy
	end,
	nil
)

function overlap(e, o, e_collider, o_collider)
	e_collider = e_collider or 'offensive_collider'
	o_collider = o_collider or 'defensive_collider'
	return e.x + e[e_collider].ox < o.x + o[o_collider].ox + o[o_collider].w and o.x + o[o_collider].ox < e.x + e[e_collider].ox + e[e_collider].w and e.y + e[e_collider].oy < o.y + o[o_collider].oy + o[o_collider].h and o.y + o[o_collider].oy < e.y + e[e_collider].oy + e[e_collider].h
end

system.create('teleporter', {'teleport', 'defensive_collider'}, 
	function(e, dt)
		if hero:has('defensive_collider') and overlap(hero, e, 'defensive_collider', 'defensive_collider') then
			e:detach('defensive_collider')
			hero.x = e.teleport.x
			hero.y = e.teleport.y
			hero.physics.vx = 0
			hero.physics.vy = 0
			--hero:detach('smash')
			--hero.offensive_collider.enabled = false
			shake.screen(2, 1)
			hero.physics.smashing = -1
			sfx(37)
			music(-1)
			if e.name == 'door1' or e.name == 'door3' then
				music(30, 300)
				hero:attach('timer')
				hero.timer.start_time = time()
				-- hero.attach('autorun')
				hero.autorun.speed = 0
			elseif e.name == 'door2' then
				music(0, 500) 
				ground = 104 + 128
				world.each(nil, function(e)
					if not e:has('player') then 
						del(world.entities, e)
					end
				end)
				spawner.init()
			elseif e.name == 'door4' then 
				state.switch('win')
			end
		end
	end
)

system.create('repeat_every', {'repeat_every'},
	function(e, dt)
		e.repeat_every.delay -= 1
		if e.repeat_every.delay <= 0 then
			e.repeat_every.code(e)
			e.repeat_every.delay = e.repeat_every.reset
		end
	end,
	nil
)
system.create('do_after', {'do_after'},
	function(e, dt)
		e.do_after.delay -= 1
		if e.do_after.delay <= 0 then
			e.do_after.code(e)
			e:detach('do_after')
		end
	end,
	nil
)

system.create('do_ceiling_harm',
	{'damage', 'offensive_collider', 'sprite'},
	function(e, dt)
		local mx = flr((e.x + (e.sprite.w / 2)) / 8)
		local my = flr((e.y + 4) / 8)
		local t = mget(mx, my)
		if e.y < ground - 80 or e.y > ground then return end
		for x = mx, mx + e.sprite.w do
			if t == 174 then
				mset(x, my, 190)
				sfx(42)
				particle.create('smoke', x * 8 + 4, my * 8 + 4, 5)
				assemblage.ceiling(x * 8, my * 8)
				if e:has('scorer') then
					score.add(20)
				end
			end
		end
	end,
	nil
)

system.create('do_harm',
	{'damage', 'offensive_collider'},
	function(e, dt)
		world.each({'defensive_collider', 'health'}, function(o)
			if e == o then return end -- not itself
			if not e.offensive_collider.enabled then return end -- not turned off
			if not o.defensive_collider.enabled then return end -- not turned off
			if e:has('bullet') and o:has('bullet') then return end
			if (e:has('parent') and e.parent == o) or (o:has('parent') and e == o.parent) then return end -- not the source
			if e:has('enemy_team') and o:has('enemy_team') then return end -- no friendly fire
			if not overlap(e, o) then return end
			if o:has('iframes') then return end
			if o:has('knockable') and e:has('knockback') then
				subsystem.knock(e, o)
			end
			local dam = max(e.damage, 1) -- limit to one damage?
			o.health.current -= dam
			if o:has('bounce') then subsystem.bounce(o, e) end
			if o.health.current >= 1 then --
				o:attach('iframes', o)
				if o:has('redirectable') then subsystem.projectile_redirect(o) end
				if o:has('sound_on_damage') then
					sfx(o.sound_on_damage)
				end
				if o:has('on_damage') then o.on_damage(o, dam) end
				return
			end
			-- entity will be destroyed
			o.health.current = 0
			-- particle.create('smoke', e.x + 10, e.y + 21, 5)
			if o:has('tossable') then
				subsystem.toss(o)
			else
				o:attach('despawn', 1)
			end
			if o:has('crushable') then subsystem.crush(o) end
			if o:has('stats') then score.killed_by = e.name end
			if e:has('scorer') and o:has('scorable') then subsystem.score(o, e) end
		end)
	end
)

system.create('animation', {'frames'},
	function(e, dt)
		if e.frames.animating then
			local delay = (e.frames[e.frames.anim] and e.frames[e.frames.anim][e.frames.frame] and e.frames[e.frames.anim][e.frames.frame][2]) and e.frames[e.frames.anim][e.frames.frame][2] or e.frames.delay
			e.frames.tick = (e.frames.tick + 1) % delay
			if e.frames.tick == 0 then
				if e.frames.frame == #e.frames[e.frames.anim] and e.frames.one_shot then
					e.frames.frame = 1
					e.frames.anim = 'default'
				else
					e.frames.frame = e.frames.frame % #e.frames[e.frames.anim] + 1
				end
			end
		end
	end,
  nil
)

system.create('despawner', {'health', 'despawn'},
	function(e, dt)
		e.despawn.ttl -= 1
		if e.despawn.ttl <= 0 then
			if e:has('sound_on_despawn') then
				sfx(e.sound_on_despawn)
			end
			local r = false
			if e:has('on_despawn') then
				r = e.on_despawn(e)
			end
			if r then -- cancelled
				e:detach('despawn')
			else
				del(world.entities, e)
			end
		end
	end,
	nil
)

-- -1 on x and or y to not move in that direction?
system.create('movement', {'physics', 'movement'},
	function(e, dt)
		e.physics.vx += 0.5
		e.movement.max_y = e.movement.max_y or 5 * dt
		if e.physics.vx >= e.movement.speed * dt then
			e.physics.vx = e.movement.speed * dt
		end
		e.physics.vy += 0.5 * dt
		if e.physics.vy >= e.movement.speed * dt then
			e.physics.vy = e.movement.speed * dt
		end
	end,
	nil
)


system.create('ai_shoot_dumb', {'ai_shoot_dumb', 'frames'}, function(e, dt)
	if e.ai_shoot_dumb.ttsa <= 0 then
		change_anim(e, 'shooting', true)
	 	assemblage.enemy_bullet(e, e.x + 2, e.y + 1, -5)
	 	e.ai_shoot_dumb.ttsa = 20
	 	--printh(e.ai_shoot_dumb.ttsa)
	else
		 e.ai_shoot_dumb.ttsa -= 1
	end
   end, nil
)

system.create('ai_shoot_smrt', {'ai_shoot_smrt', 'frames'}, function(e, dt)
	if e.ai_shoot_smrt.ttsa <= 0 then
		if abs(e.y - hero.y) < 20 then
			if e.x - hero.x <= e.ai_shoot_smrt.max_range then
				change_anim(e, 'shooting', true)
				assemblage.enemy_bullet(e, e.x + 2, e.y + 1, -2)
				change_anim(e, 'idle', false)
			else 
				change_anim(e, 'idle', false)
			end
			e.ai_shoot_smrt.ttsa = rnd({40, 50, 60, 80})
		else
	end
	else
	 e.ai_shoot_smrt.ttsa -= 1
	end
   end, nil
) 


system.create('ai_boss', {'ai_boss', 'frames', 'health'}, function(e, dt)
	if not hero:has('timer') then return end --I hate this
	if e.ai_boss.ttsa <= 0 and not e.ai_boss.is_lunging then
		-- change_anim(e, 'shooting', true)
		-- 	local max = (t() - hero.timer.start_time > 10) and 2 or 0
		-- 	for i = 0, max do 
		-- 		assemblage.enemy_bullet(e, e.x + (3*(i+1)), e.y + (2*(i*2)), -3, 0)
		-- 		change_anim(e, 'idle', false)
		-- 	end
		subsystem.boss_projectile_attack(e, 10, 2)
		e.ai_boss.ttsa = 55
	elseif (e.ai_boss.ttla <= 0) and not e.ai_boss.is_lunging then 
		local run = (t() - hero.timer.start_time < 20) and 0 or -20
		e:attach('boss_autorun', rnd({-65 + run, -70 + run, -80 + run, -95 + run}))
		e.ai_boss.is_lunging = true

	elseif e.ai_boss.is_lunging then
		if (abs(e.x - hero.x) <= 9) and not e.ai_boss.is_returning then
			e.ai_boss.is_returning = true
			local run2 = (t() - hero.timer.start_time > 15) and 0 or 50
			e:attach('boss_autorun', rnd({150 + run2, 260 + run2}))
		elseif abs(e.x - hero.x) >= 64 then
			e:detach('boss_autorun')
			e.ai_boss.is_lunging = false
			e.ai_boss.is_returning = false
			e.ai_boss.ttla = 40
		end
	else
		e.ai_boss.ttsa -= 1
		e.ai_boss.ttla -= 1
	end
end, 
nil
)

system.create('ai_boss_comp', {'ai_boss_comp', 'frames', 'health'}, function(e, dt)
	if not hero:has('timer') then return end --I hate this
	if e.ai_boss_comp.ttsa <= 0 then
		-- change_anim(e, 'shooting', true)
		-- 	local max = (t() - hero.timer.start_time > 10) and 4 or 0
		-- 	for i = 0, max do 
		-- 		-- assemblage.enemy_bullet(e, e.x + (3*(i+2)), e.y + (2*(i*2)), -2, 0)
		-- 		-- assemblage.enemy_bullet(e, e.x + (3*(i+2)), e.y + (3*(i*2)), -2, 0)
		-- 		assemblage.enemy_bullet(e, e.x + (3*(i+2)), e.y + (4*(i*2)), -2, 0)
		-- 		change_anim(e, 'idle', false)
		-- 	end
		subsystem.boss_projectile_attack(e, 10, 2)
		e.ai_boss_comp.ttsa = 55
	elseif e.ai_boss_comp.charge_time <= 0 then
		printh("spawning big bullet")
		assemblage.enemy_bullet(e, e.x + 2, e.y + 4, -2, 0, true)
		e.ai_boss_comp.charge_time = 160
	else
		e.ai_boss_comp.ttsa -= 1
		e.ai_boss_comp.charge_time -= 1
	end
end, 
nil
)

system.create('iframes', {'iframes'},
	function(e, dt)
		e.iframes.flash = not e.iframes.flash
		e.iframes.ttl -= 1
		if e.iframes.ttl <= 0 then
			if e:has('defensive_collider') then e.defensive_collider.enabled = true end
			e:detach('iframes')
		end
	end,
	nil
)

-- From https://www.lexaloffle.com/bbs/?tid=3936
function spr_r(spr,sw,sh,px,py,r,s)
	sw *= 8
	sh *= 8
	local sr = flr(spr / 16)
	local sc = (spr % 16)
	local sx = sc * 8
	local sy = sr * 8
	for y=sy,sy+sh,1 do for x=sx,sx+sw,1 do
		col = sget(x,y)
		if (col != 0) then
			local xx = (x-sx)-sw/2
			local yy = (y-sy)-sh/2
			local x2 = (xx*cos(r) - yy*sin(r))*s
			local y2 = (yy*cos(r) + xx*sin(r))*s
			local x3 = flr(x2+px)
			local y3 = flr(y2+py)
			if (s >= 1) then
				local w = flr(x2+px+s)
				local h = flr(y2+py+s)
				rectfill(x3,y3,w,h,col)
			else
				pset(x3,y3,col)
			end
		end
	end	end
end

toss_gravity = 4.0
system.create('tossing', {'toss'},
	function(e, dt)
		if e.toss.started then
			e.x += e.toss.vx * dt
			e.toss.vy += toss_gravity
			e.y += e.toss.vy * dt
		end
		if e.toss.bounce then
			e.toss.rotation = lerp(e.toss.desired_rotation, e.toss.rotation, e.toss.ttl / e.toss.lifetime)
			e.toss.zoom = lerp(e.toss.desired_zoom, e.toss.zoom, e.toss.ttl / e.toss.lifetime)
			e.toss.ttl -= 1
			if e.y >= (ground + 70) then
				e:attach('despawn', 1)
			end
		elseif not e.toss.started then
			e.toss.desired_rotation = rnd(e.tossable.rot)
			e.toss.desired_zoom = e.toss.zoom + rnd(e.tossable.zoom)
			e.toss.vx = (e.x - hero.x) * 8
			e.toss.vy = e.tossable.simple and 20 or 200
			e.x += flr(e.toss.w * 8 / 2)
			e.y += flr(e.toss.h * 8 / 2)
			e.toss.started = true
			e.toss.rotation = 0
			e.toss.lifetime = 120
			e.toss.ttl = e.toss.lifetime
			e.toss.bounce = e.tossable.simple
		elseif not e.toss.bounce then
			if e.y >= (ground + 0) then
				e.toss.vx /= 2
				e.toss.vy = -80 + rnd(40)
				e.toss.bounce = true
			end
		end
	end,
	function(e)
		spr_r(e.toss.sprite, e.toss.w, e.toss.h, e.x, e.y, e.toss.rotation, e.toss.zoom)
	end
)

system.create('collectable_delay', {'collectable_delay'},
	function(e, dt)
		e.collectable_delay -= 1
		if e.collectable_delay <= 0 then
			e:attach('defensive_collider')
			e:detach('collectable_delay')
		end
	end,
	nil
)

system.create('pickups',
	{'collector', 'defensive_collider'},
	function(e, dt)
		world.each({'collectable', 'defensive_collider'}, function(c)
			if overlap(e, c, 'defensive_collider', 'defensive_collider') then
				if e:has('health') and c.collectable.type == 'code' and e.health.current < e.health.limit then
					if e:has('player') and e.health.current == 0 then e.health.current = 1 end -- player hack
					local l = '0'
					if c:has('recttext') then
						l = c.recttext.char
					end
					e.health.current += 1
					e.collector.letters = e.collector.letters .. l
					if e:has('scorer') then
						score.add(5)
					end
				end
				sfx(40)
				del(world.entities, c)
			end
		end)
	end
)

-- system.create('bounding_box_debug', {'offensive_collider'},
-- 	nil,
-- 	function(e)
-- 		if not DEV_COLLIDERS then return end
-- 		if not e.offensive_collider.enabled then return end
-- 		rect(e.x + e.offensive_collider.ox, 
-- 			e.y + e.offensive_collider.oy, e.x + e.offensive_collider.ox + e.offensive_collider.w - 1, 
-- 			e.y + e.offensive_collider.oy + e.offensive_collider.h - 1,
-- 			14
-- 		)
-- 	end
-- )
-- system.create('defensive_bounding_box_debug', {'defensive_collider'},
-- 	nil,
-- 	function(e)
-- 		if not DEV_COLLIDERS then return end
-- 		if not e.defensive_collider.enabled then return end
-- 		rect(e.x + e.defensive_collider.ox, 
-- 			e.y + e.defensive_collider.oy, e.x + e.defensive_collider.ox + e.defensive_collider.w - 1, 
-- 			e.y + e.defensive_collider.oy + e.defensive_collider.h - 1,
-- 			12
-- 		)
-- 	end
-- )
