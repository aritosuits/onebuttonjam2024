-- components

-- Hide the entity
component.create('hidden')

-- Items related to the display of an entity
component.create('sprite', function(num, w, h)
	return { num = num, w = w or 1, h = h or 1 }
end)

function add_anim(e, name, anim)
	e.frames[name] = anim
end
function change_anim(e, name)
	if e.frames.anim == name then return end
	e.frames.anim = name
	e.frames.frame = 1
end
component.create('frames', function()
	return {
		animating = true,
		anim = 'default',
		tick = 0,
		delay = 4,
		frame = 1,
		default = {
			{ num = 0, delay = 4 }
		}
	}
end)

component.create('autorun', function(speed)
	return { speed = speed or 1 }
end)

component.create('controller', function()
	return {
		press = false,
		hold = false,
		release = false,
		secs = 0
	}
end)

-- Items related to physics
component.create('physics', function(vx, vy, mass)
	return { grounded = false, vx = vx or 0, vy = vy or 0, mass = mass or 1 }
end)

-- A timer to despawn the entity
-- Usually used while playing a death animation
component.create('despawn', function(ttl)
	return { ttl = ttl or 0 } -- in frames
end)

-- Stuff related to flying damaging stuff
component.create('projectile', function(damage)
	return { damage = damage or 1 }
end)

-- Entity health
component.create('health', function(num)
	return num or 3
end)

-- Entity colliders for physics and collisions
component.create('collider', function(ox, oy, w, h)
	return {
		ox = ox or 0,
		oy = oy or 0,
		w = w or 8,
		h = h or 8
	}
end)

-- Weapon for hero
component.create('weapon', function(level)
	return { level = level or 1 }
end)
