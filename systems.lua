-- systems

system.create('display', {'pos', 'sprite'},
	nil,
	function(e)
		if e.hidden then return end
		spr(e.sprite.num, e.pos.x, e.pos.y, e.sprite.w or 1, e.sprite.h or 1)
	end
)

function overlap(e, o)
	return e.x + e.collider.ox < o.x + o.collider.ox + o.collider.w and o.x + o.collider.ox < e.x + e.collider.ox + e.collider.w and e.y + e.collider.oy < o.y + o.collider.oy + o.collider.h and o.y + o.collider.oy < e.y + e.collider.oy + e.collider.h
end
system.create('bullet', {'projectile', 'collider'},
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

system.create('dying', {'health', 'destroy'},
	function(e, dt)
		e.destroy.ttl -= 1
		if e.destroy.ttl <= 0 then
			del(world.entities, e)
		end
	end,
	nil
)
