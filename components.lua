-- components

-- Hide the entity
component.create('hidden')

-- Items related to the display of an entity
component.create('sprite', function(num, w, h)
	return { num = num, w = w, h = h }
end)

-- A timer to destroy the entity
-- Usually used while playing a death animation
component.create('destroy', function(ttl)
	return { ttl = ttl } -- in frames
end)

-- Stuff related to flying damaging stuff
component.create('projectile', function(sx, sy, damage)
	return { sx = sx, sy = sy, damage = damage }
end)

-- Entity health
component.create('health', function(num)
	return num
end)

-- Entity colliders for physics and collisions
component.create('collider', function(ox, oy, w, h)
	return { ox = ox, oy = oy, w = w, h = h }
end)

-- Weapon for hero
component.create('weapon', function(level)
	return { level = level }
end)
