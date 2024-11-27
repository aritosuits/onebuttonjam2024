-- systems

system.create('display', {'sprite'},
	nil,
	function(e)
		if e.hidden then return end
		local s = e.sprite.num
		if e:has('frames') and e.frames[e.frames.anim] then
			s = e.frames[e.frames.anim][e.frames.frame].num
		end
		spr(s, e.x, e.y, e.sprite.w, e.sprite.h)
	end
)

system.create('character', {'controller', 'physics'},
	function(e, dt)
		if e.controller.press then
			e.controller.press = false
			assemblage.player_bullet(e.x + 2, e.y + 1, 6)
		elseif e.controller.release then
			e.controller.release = false
		elseif e.controller.hold then
			e.controller.hold = false
			if e.controller.secs >= 0.1 and e.physics.grounded then
				e.physics.vy = -4
			end
		end
	end,
	nil
)

gravity = 8
system.create('gravity', {'collider', 'physics'},
	function(e, dt)
		if e.physics.mass <= 0 then return end
		-- the hardcoded 96 should be removed
		-- and a ground collider added if we want pits
		if e.y < 96 then
			e.physics.vy += gravity * dt
			e.physics.grounded = false
			if e:has('frames') then
				change_anim(hero, 'jump')
			end
		elseif not e.physics.grounded then
			e.physics.vy = 0
			e.y = 96
			e.physics.grounded = true
			if e:has('frames') then
				change_anim(hero, 'walk')
			end
		end
	end,
	nil
)

system.create('autorun', {'physics', 'autorun'},
	function(e, dt)
		e.physics.vx += 0.5 * dt
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
system.create('bullet', {'projectile', 'collider'},
	function(e, dt)
		world.each({'collider', 'health'}, function(o)
			if e == o then return end
			if overlap(e, o) then
				o.health -= e.projectile.damage
				if o.health <= 0 then
					o.health = 0
					o:attach('destroy', 5)
				end
				del(world.entities, e) -- remove bullet
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
				e.frames.frame = e.frames.frame % #e.frames[e.frames.anim] + 1
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
