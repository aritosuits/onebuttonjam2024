-- systems

system.create('display', {'sprite'},
	nil,
	function(e)
		if e.hidden then return end
		spr(e.sprite.num, e.x, e.y, e.sprite.w, e.sprite.h)
	end
)

system.create('character', {'controller', 'physics'},
	function(e, dt)
		if e.controller.press then
			e.controller.press = false
			assemblage.create('player_bullet', e.x, e.y + 4, 20)
		elseif e.controller.release then
			e.controller.release = false
		elseif e.controller.hold then
			e.controller.hold = false
			if e.controller.secs >= 0.1 and e.physics.grounded then
				e.physics.vy = -3
			end
		end
	end,
	nil
)

gravity = 0.1
system.create('gravity', {'collider', 'physics'},
	function(e, dt)
		-- the hardcoded 96 should be removed
		-- and a ground collider added if we want pits
		if e.y < 96 then
			e.physics.vy += gravity
			e.physics.grounded = false
		else
			e.physics.vy = 0
			e.y = 96
			e.physics.grounded = true
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
system.create('bullet', {'projectile', 'physics', 'collider'},
	function(e, dt)
		e.x += e.sx * dt
		e.y += e.sy * dt
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

system.create('dying', {'health', 'despawn'},
	function(e, dt)
		e.despawn.ttl -= 1
		if e.despawn.ttl <= 0 then
			del(world.entities, e)
		end
	end,
	nil
)
