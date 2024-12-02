-- fading system

fade = {}

fade._table = { -- [0] sets 0 based indexing
	'1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0',
	'1,2,3,4,5,6,6,8,9,10,139,12,13,14,143,0',
	'129,2,3,132,133,134,6,136,9,138,139,12,141,14,143,0',
	'129,130,131,132,133,13,6,136,4,138,139,140,141,134,134,0',
	'129,130,131,132,133,13,134,136,4,138,139,140,5,134,134,0',
	'129,130,131,132,133,13,134,136,4,4,3,140,5,141,134,0',
	'129,130,131,132,130,141,134,132,4,4,3,140,5,141,134,0',
	'129,130,129,132,130,5,134,132,132,4,3,131,133,2,5,0',
	'129,128,129,130,128,5,5,132,132,132,3,131,133,2,5,0',
	'129,128,129,128,128,5,5,130,132,132,129,131,130,133,5,0',
	'0,128,129,128,128,133,5,128,128,133,129,1,129,130,133,0',
	'0,128,129,128,128,130,133,128,128,128,129,129,129,130,133,0',
	'0,128,0,128,128,128,130,128,128,128,0,129,128,128,128,0',
	'0,0,0,0,0,128,128,128,128,128,0,129,128,128,128,0',
	'0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'
}
fade._dir = 0
for k, v in pairs(fade._table) do
	fade._table[k] = split(v, ',', true)
end

function fade.disappear(callback, speed) fade._start(callback, 1, speed) end
function fade.appear(callback, speed) fade._start(callback, -1, speed) end

function fade.update()
	if fade._dir == 0 then return end
	fade._accumulator += 1
	if fade._accumulator < fade._speed then return end
	fade._accumulator = 0
	pal(fade._table[fade._frame])
	fade._frame += fade._dir
	if fade._frame > 15 or fade._frame < 1 then
		fade._dir = 0
		if type(fade._callback) == 'function' then
			fade._callback()
			--fade._callback = function() end
		end
	end
end

function fade._start(callback, dir, speed)
	fade._accumulator = 0
	if type(callback) != 'function' then
		callback = function() end
	end
	fade._callback = callback
	fade._dir = dir
	fade._speed = speed or 1
	fade._frame = 1
	if dir < 0 then fade._frame = 15 end
end

-- shaking system

shake = {}
shake.active = false

function shake.screen(amount, time)
	shake.ttl = time
	shake.amount = amount
	shake.strength = 1
	shake.active = true
end

function shake.update(dt)
	local hero_x = 0
	if hero != nil and hero.x != nil then hero_x = hero.x - 30 end
	if not shake.active then
		camera(hero_x, (ground - 104))
		return
	end
	shake.ttl -= 1
	if shake.ttl <= 0 then
		shake.active = false
	end
	local s_x = rnd(shake.amount) - (shake.amount / 2)
	local s_y = rnd(shake.amount) - (shake.amount / 2)
	local camera_x = shake.strength * s_x
	local camera_y = shake.strength * s_y
	camera(hero_x + camera_x, (ground - 104) + camera_y)
	shake.strength *= 0.9
	if shake.strength < 0.025 then shake.strength = 0 end
end
