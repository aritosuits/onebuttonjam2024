-- systems

--[[
from: https://pico-8.fandom.com/wiki/Draw_zoomed_sprite_(zspr)
Arguments:
--n: standard sprite number
--w: number of sprite blocks wide to grab
--h: number of sprite blocks high to grab
--dx: destination x coordinate
--dy: destination y coordinate
--dz: destination scale/zoom factor
]]
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
			s = e.frames[e.frames.anim][e.frames.frame].num
		end
		local ouch = false
		if e:has('ouch') and e.ouch.enabled then
			ouch = true
			for n = 1, 16 do
				pal(n, 7)
			end
		end
		if e.sprite.scale > 1 then 
			zspr(s, e.sprite.w, e.sprite.h, e.x, e.y, e.sprite.scale)
		else
			spr(s, e.x, e.y, e.sprite.w, e.sprite.h)
		end
		if ouch then pal() end
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

gravity = 8
ground = 104
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
				if e:has({'player', 'smash'}) then
					particle.create('smash', e.x + 10, e.y + 21, 10)
					e:detach('smash')
					e.offensive_collider.enabled = false
					sfx(33)
					sfx(34)
					shake.screen(hero.health.current * 0.75 + 0.25, lerp(3, 5, hero.health.current / 16))
					e.physics.smashing = -1
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
		if overlap(hero, e, 'defensive_collider', 'defensive_collider') then
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
			if e.name == 'door1' then
				music(10, 300)
			elseif e.name == 'door2' then
				music(0, 500) 
				ground = 104 + 128
				world.each(nil, function(e)
					if not e:has('player') then 
						del(world.entities, e)
					end
				end)
				spawner.init()
			elseif e.name == 'door3' then 
				music(10, 1300)
			elseif e.name == 'door4' then 
				world.destroy()
				state.switch('end')
			end
		end
	end
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

system.create('do_harm', {'damage', 'offensive_collider'},
	function(e, dt)
		world.each({'defensive_collider', 'health'}, function(o)
			if e == o then return end -- not itself
			if not e.offensive_collider.enabled then return end -- not turned off
			if not o.defensive_collider.enabled then return end -- not turned off
			if (e:has('parent') and e.parent == o) or (o:has('parent') and e == o.parent) then return end -- not the source
			if e:has('enemy_team') and o:has('enemy_team') then return end -- no friendly fire
			if not overlap(e, o) then return end
			if time() < o.health.iframes then return end
			o.health.iframes = time() + 0.5
			o:attach('ouch')
			if o:has('knockable') and e:has('knockback') then
				o.physics.vx = e.knockback.vx
				o.physics.vy = e.knockback.vy
			end
			if not o:has('player') then -- not towards player
				sfx(31) -- might need new sound?
				o.health.current -= e.damage
				if o.health.current <= 0 then
					o.health.current = 0
				end
				if o:has('tutorial') then -- tutorial button
					change_anim(o, 'pressed')
					sfx(36)
					hero:attach('autorun', 30)
					o:detach('tutorial')
					o:detach('defensive_collider')
				else -- not tutorial button
					-- particle.create('smoke', e.x + 10, e.y + 21, 5)
					if o:has('bounce') then
						if e:has('physics') then
							e.physics.vx += o.bounce.vx
							e.physics.vy = o.bounce.vy
						end
						-- smash again
						particle.create('smash', e.x + 10, e.y + 21, 10)
						e:detach('smash')
						e.offensive_collider.enabled = false
						sfx(33)
						sfx(34)
						shake.screen(hero.health.current * 0.75 + 0.25, lerp(3, 5, hero.health.current / 16))
						e.physics.smashing = -1
					end
					if o:has('tossable') then
						o:detach('physics')
						o:detach('offensive_collider')
						o:detach('defensive_collider')
						o:attach('toss', o.sprite)
						o:detach('sprite')
						o:detach('ai_shoot_smrt')
						o:detach('ai_shoot_dumb')
					else
						o:attach('despawn', 1)
					end
					if e:has('player') and o:has('scorable') then -- caused by player
						local s = score.calculate(o.scorable, e.physics.smashing, hero.health.current)
						printh('base score: ' .. o.scorable .. ' smash frames: ' .. e.physics.smashing .. ' health: ' .. hero.health.current .. ' total: ' .. s)
						score.add(s)
					end
				end
				if e:has('bullet') then
					del(world.entities, e) -- remove bullet
				end
			else -- towards player
				if hero.health.current <= 0 then
					sfx(30)
					-- PLAYER DEAD
				else
					sfx(31)
					local m = min(16, #hero.health.letters)
					local r = rnd(1)
					for i = 1, m do
						local vx = sin(i / m + r) * 2
						local vy = cos(i / m + r) * 2
						assemblage.collectable('code', hero.x, hero.y, sub(hero.health.letters, i, i), vx, vy)
					end
					hero.health.current = 0
					hero.health.letters = ''
					sfx(41)
				end
			end
		end)
	end,
	nil
)

system.create('animation', {'frames'},
  function(e, dt)
    if e.frames.animating then
      local delay = (e.frames[e.frames.anim] and e.frames[e.frames.anim][e.frames.frame] and e.frames[e.frames.anim][e.frames.frame].delay) and e.frames[e.frames.anim][e.frames.frame].delay or e.frames.delay
      e.frames.tick = (e.frames.tick + 1) % delay
      if (e.frames.tick == 0) then
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
			del(world.entities, e)
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
		printh("cooled down, moving on")
		if abs(e.y - hero.y) < 20 then
			printh("player is on same y within 5 units")
			if e.x - hero.x <= e.ai_shoot_smrt.max_range then
				printh("shooting player")
				change_anim(e, 'shooting', true)
				assemblage.enemy_bullet(e, e.x + 2, e.y + 1, -2)
				printh("shot bullet, return to idle")
				change_anim(e, 'idle', false)
			else 
				printh("dist: "..e.x - hero.x)
				printh("max range: "..e.ai_shoot_smrt.max_range)
				change_anim(e, 'idle', false)
			end
			printh("refreshing ttsa to 40")
			e.ai_shoot_smrt.ttsa = 40
		else
			printh("y distance: "..abs(e.y - hero.y))
	end
	else
	 e.ai_shoot_smrt.ttsa -= 1
	 printh("cooling down: ".. e.ai_shoot_smrt.ttsa)
	end
   end, nil
) 

system.create('ouch', {'ouch'},
	function(e, dt)
		e.ouch.enabled = not e.ouch.enabled
		e.ouch.ttl -= 1
		if e.ouch.ttl <= 0 then
			e:detach('ouch')
		end
	end,
	nil
)

-- From https://www.lexaloffle.com/bbs/?tid=3936
--[[
    // quick and dirty way of rotating a sprite
    sx = spritecheet x-coord
    sy = spritecheet y-coord
    sw = pixel width of source sprite
    sh = pixel height of source sprite
    px = x-coord of where to draw rotated sprite on screen
    py = x-coord of where to draw rotated sprite on screen
    r = amount to rotate (radians)
    s = 1.0 for normal scale, 0.5 for half, etc
]]
function spr_r(spr,sw,sh,px,py,r,s)
	-- loop through all the pixels
	sw *= 8
	sh *= 8
	local sr = flr(spr / 16)
	local sc = (spr % 16)
	local sx = sc * 8
	local sy = sr * 8
	for y=sy,sy+sh,1 do for x=sx,sx+sw,1 do
		-- get source pixel color
		col = sget(x,y)
		-- skip transparent pixel (zero in this case)
		if (col != 0) then
			-- rotate pixel around center
			local xx = (x-sx)-sw/2
			local yy = (y-sy)-sh/2
			local x2 = (xx*cos(r) - yy*sin(r))*s
			local y2 = (yy*cos(r) + xx*sin(r))*s
			-- translate rotated pixel to where we want to draw it on screen
			local x3 = flr(x2+px)
			local y3 = flr(y2+py)
			-- use rectfill if scale is > 1, otherwise just pixel it
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
				del(world.entities, e)
			end
		elseif not e.toss.started then
			e.toss.vx = (e.x - hero.x) * 8
			e.toss.vy = 200
			e.x += flr(e.toss.w * 8 / 2)
			e.y += flr(e.toss.h * 8 / 2)
			e.toss.started = true
		elseif not e.toss.bounce then
			if e.y >= (ground + 25) then
				e.toss.vx /= 2
				e.toss.vy = -100
				e.toss.bounce = true
				e.toss.rotation = 0
				e.toss.desired_rotation = rnd(360)
				e.toss.desired_zoom = e.toss.zoom + rnd(1.5)
				e.toss.lifetime = 60
				e.toss.ttl = e.toss.lifetime
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

system.create('collector', {'collectable', 'defensive_collider'},
	function(e, dt)
		if overlap(hero, e, 'defensive_collider', 'defensive_collider') then
			if hero.health.current >= hero.health.limit then return end
			e:detach('defensive_collider')
			if e.collectable.type == 'code' then
				hero.health.current += 1
				hero.health.letters = hero.health.letters .. e.recttext.char
			end
			sfx(40)
			del(world.entities, e)
		end
	end,
	nil
)

system.create('bounding_box_debug', {'offensive_collider'},
	nil,
	function(e)
		if true then return end
		if not e.offensive_collider.enabled then return end
		rect(e.x + e.offensive_collider.ox, 
			e.y + e.offensive_collider.oy, e.x + e.offensive_collider.ox + e.offensive_collider.w - 1, 
			e.y + e.offensive_collider.oy + e.offensive_collider.h - 1,
			14
		)
	end
)
system.create('defensive_bounding_box_debug', {'defensive_collider'},
	nil,
	function(e)
		if true then return end
		if not e.defensive_collider.enabled then return end
		rect(e.x + e.defensive_collider.ox, 
			e.y + e.defensive_collider.oy, e.x + e.defensive_collider.ox + e.defensive_collider.w - 1, 
			e.y + e.defensive_collider.oy + e.defensive_collider.h - 1,
			12
		)
	end
)
