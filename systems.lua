-- systems

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
		if e.sprite.scale > 1 then 
			zspr(s, e.sprite.w, e.sprite.h, e.x, e.y, e.sprite.scale)
		else
			spr(s, e.x, e.y, e.sprite.w, e.sprite.h)
		end
	end
)

system.create('recttext_display', {'recttext'},
	nil,
	function(e)
		if e.hidden then return end
		rectfill(e.x, e.y, e.x + e.recttext.w, e.y + e.recttext.h, 8)
		print(e.recttext.char, e.x + 1, e.y + 1, 7)
	end
)

system.create('controller', {'controller', 'physics'},
	function(e, dt)
		if e.controller.press then
			e.controller.press = false
			if e.physics.grounded then
				e.physics.vy = -6.5
				particle.create('smoke', e.x + 10, e.y + 21, 5)
			else
				e.physics.vy = 6
				change_anim(e, 'kick')
				e:attach('smash')
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
system.create('gravity', {'collider', 'physics'},
	function(e, dt)
		if e:has('floating') then return end 
		if e.physics.mass <= 0 then return end
		-- the hardcoded 80 should be removed
		-- and a ground collider added if we want pits
		if e.y < 80 then
			e.physics.vy += gravity * dt
			if e.physics.grounded then
				e.physics.grounded = false
				if e:has('frames') then
					change_anim(e, 'jump')
				end
			end
		else
			e.physics.vy /= 1.5
			e.y = 80
		 	if not e.physics.grounded then
				e.physics.grounded = true
				if e:has('frames') then
					change_anim(e, 'walk')
				end
				if e:has({'player', 'smash'}) then
					particle.create('smash', e.x + 10, e.y + 21, 10)
					e:detach('smash')
					shake.screen(4, 3)
				else
					particle.create('smoke', e.x + 10, e.y + 21, 10)
				end
			end
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

function overlap(e, o)
	return e.x + e.collider.ox < o.x + o.collider.ox + o.collider.w and o.x + o.collider.ox < e.x + e.collider.ox + e.collider.w and e.y + e.collider.oy < o.y + o.collider.oy + o.collider.h and o.y + o.collider.oy < e.y + e.collider.oy + e.collider.h
end

system.create('do_harm', {'damage', 'collider'},
	function(e, dt)
		world.each({'collider', 'health'}, function(o)
			if e == o then return end
			if e:has('parent') and e.parent == o then return end 
			if not o:has('player') then return end 
			if overlap(e, o) then
				if time() < o.health.iframes then return end 

				o.health.current -= e.damage.damage
				if o:has('knockback') then
					o.physics.vx = -2
				end
				o.health.iframes = time() + 0.5
				if o.health.current <= 0 then
					o.health.current = 0
					if not o:has('player') then
						particle.create('smoke', e.x + 10, e.y + 21, 5)
						o:attach('despawn', 1)
					else 
						-- player death here
					end
				end
				if e:has('bullet') then
					del(world.entities, e) -- remove bullet
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
		e.ai_shoot_smrt.ttsa = 20
		if e.y == hero.y then
			if hero.x <= (e.x + e.ai_shoot_smrt.max_range) then
				change_anim(e, 'shooting', true)
	 			assemblage.enemy_bullet(e, e.x + 2, e.y + 1, -2)
			else 
				--printh(e.ai_shoot_smrt.ttsa .. "range: " .. e.ai_shoot_smrt.max_range .. "hero dist: " .. (e.ai_shoot_smrt.max_range - hero.x))
				change_anim(e, 'idle')
			end
		end
	else
	 e.ai_shoot_smrt.ttsa -= 1
	end
   end, nil
) 

system.create('bounding_box_debug', {'collider'},
	nil,
	function(e)
		rect(e.x + e.collider.ox, 
			e.y + e.collider.oy, e.x + e.collider.ox + e.collider.w - 1, 
			e.y + e.collider.oy + e.collider.h - 1,
			14
		)
	end
)
