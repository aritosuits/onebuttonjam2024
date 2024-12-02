-- components

component.create('hidden')
component.create('smash')
component.create('player')
component.create('floating')
component.create('bullet')
component.create('stats')
component.create('enemy_team')
component.create('collector', function()
	return { letters = '' }
end)
component.create('crushable')
component.create('scorer')

component.create('timer', function(start_time)
	return {start_time = start_time or time()}
end)

component.create('repeat_every', function(delay, code)
	return { delay = delay or 30, reset = delay or 30, code = code or function(e) end }
end)
component.create('do_after', function(delay, code)
	return { delay = delay or 30, reset = delay or 30, code = code or function(e) end }
end)

component.create('collectable_delay', function(delay)
	return delay or 30
end)
component.create('collectable', function(type)
	return { type = type }
end)

component.create('bounce', function(vx, vy)
	return { vx = vx or 0, vy = vy or -4 }
end)

component.create('knockable')
component.create('knockback', function(vx, vy)
	return { vx = vx or -10, vy = vy or 0 }
end)

component.create('tossable')
component.create('toss', function(sprite_comp)
	return {
		vx = 0,
		vy = 0,
		ttl = 0,
		sprite = sprite_comp.num,
		w = sprite_comp.w,
		h = sprite_comp.h,
		started = false,
		bounce = false,
		rotation = 0,
		desired_rotation = 0,
		zoom = sprite_comp.scale,
		desired_zoom = 0
	}
end)

-- Items related to the display of an entity
component.create('sprite', function(num, w, h, scale)
	return { num = num or 255, w = w or 1, h = h or 1, scale = scale or 1}
end)

-- It's what you see when an enemy shoots code
component.create('recttext', function(color, char, w, h)
	return { color = color, char = char, w = w or 6, h = h or 6, frame = 0, delay = 4, accumulator = 0 }
end)

function add_anim(e, name, anim)
	if type(anim) == 'table' then printh('accepts only strings') end
	local anim = split(anim, ',')
	for k, v in pairs(anim) do
		anim[k] = split(v, ':', true)
	end
	-- dump(anim)
	e.frames[name] = anim
end
function change_anim(e, name, one_shot)
	if e.frames.anim == name then return end
	if type(e.frames[name]) != 'table' then return end
	e.frames.anim = name
	e.frames.one_shot = one_shot or false
	e.frames.frame = 1
end
component.create('frames', function(e)
	return {
		animating = true,
		anim = 'default',
		tick = 0,
		delay = 4,
		frame = 1,
		one_shot = false,
		default = {
			{ 255 }
		}
	}
end)

component.create('autorun', function(speed)
	return { speed = speed or 1 }
end)

component.create('boss_autorun', function(speed)
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
	return { grounded = false, vx = vx or 0, vy = vy or 0, mass = mass or 1, smashing = -1 }
end)

component.create('movement', function(speed, max_x, max_y)
	return {speed = speed or 1, max_x = max_x or 5, max_y = max_y or 5}
end)

-- A timer to despawn the entity
-- Usually used while playing a death animation
component.create('despawn', function(ttl)
	return { ttl = ttl or 0 } -- in frames
end)
component.create('sound_on_despawn', function(sound)
	return sound
end)
component.create('on_despawn', function(code)
	return code or function(e) end
end)

-- Stuff related to damaging stuff
component.create('damage', function(damage)
	return damage or 1
end)
component.create('sound_on_damage', function(sound)
	return sound
end)
component.create('on_damage', function(code)
	return code or function(e, amount) end
end)

-- Entity health
component.create('health', function(num, limit)
	return { current = num or 3, limit = limit or 16 }
end)

-- Entity colliders for physics and collisions
component.create('iframes', function(e)
	if e:has('defensive_collider') then e.defensive_collider.enabled = false end
	return { flash = true, ttl = 30 }
end)
component.create('offensive_collider', function(ox, oy, w, h)
	return {
		enabled = true,
		ox = ox or 2,
		oy = oy or 2,
		w = w or 4,
		h = h or 4
	}
end)
component.create('defensive_collider', function(ox, oy, w, h)
	return {
		enabled = true,
		ox = ox or 2,
		oy = oy or 2,
		w = w or 4,
		h = h or 4
	}
end)

component.create('ai_shoot_dumb', function ()
	return {ttsa = 30}	
end)

component.create('ai_shoot_smrt', function(max_range) 
	return {
		max_range = max_range or 130,
		ttsa = 40 --time to shoot again
	}
end)

component.create('ai_boss', function(max_range_shoot, max_range_lunge, can_shoot, is_lunging, is_returning, times_struck)
	return {
		times_struck = times_struck or 0,
		max_range_shoot = max_range_shoot or 30,
		max_range_lunge = max_range_lunge or 30,
		ttsa = 0,
		ttla = 0,
		can_shoot = can_shoot or true,
		is_lunging = is_lunging or false,
		is_returning = is_returning or false
	}
end)

component.create('parent', function (obj) 
	return obj
end)

component.create('scorable', function(amount)
	return amount
end)

component.create('teleport', function(x, y, autorun, ends_game)
	return {x = x or 0, y = y or 0, autorun = autorun or true, ends_game = ends_game or false}
end)
