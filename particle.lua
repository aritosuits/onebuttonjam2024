-- particle system

function lerp(a, b, t)
	return a + (b - a) * (t or 0.5)
end

particle = {}
particle.list = {}

function particle.create(type, x, y, amount)
	amount = amount or 1
	for i = 1, amount do
		local p = {}
		p.type = type
		p.x = x + (rnd(3) - 1.5)
		p.y = y + (rnd(3) - 1.5)
		p.color = 6
		p.lifetime = 20
		p.gravity = 0
		p.vx = 0
		p.vy = 0
		if type == 'smoke' then
			p.color = rnd({5, 6, 7})
			p.radius = 2
			p.lifetime = 4
			p.vx = rnd(6) - 3
			p.vy = rnd(2) - 1
		elseif type == 'smash' then
			p.color = rnd({1, 12, 13})
			p.radius = 4
			p.lifetime = 6
			p.x = x + (rnd(4) - 2)
			p.y = y + (rnd(2) - 1)
			p.vx = rnd(9) - 4.5
			p.vy = rnd(1.5) - 0.75
		elseif type == 'trail' then
			p.color = 13
			p.radius = 3
			p.lifetime = 1
			p.x = x + (rnd(9) - 4)
			p.y = y + (rnd(24) - 12)
			p.w = 1.5
			p.h = 4
			p.vx = 0
			p.vy = 0
		else -- default
			p.vx = rnd(3) - 1.5
			p.vy = rnd(3) - 1.5
		end
		p.ttl = p.lifetime
		add(particle.list, p)
	end
end

function particle.update(dt)
	for p in all(particle.list) do
		p.ttl -= 1
		if p.ttl <= 0 then
			del(particle.list, p)
			break
		end
		p.vy += p.gravity
		p.x += p.vx
		p.y += p.vy
		if p.type == 'smoke' or p.type == 'smash' then
			if flr(rnd(3)) == 1 then
				p.radius -= 1
				if p.radius <= 1 then p.radius = 1 end
			end
		elseif p.type == 'trail' then
		else
		end
	end
end

function particle.draw()
	for p in all(particle.list) do
		if p.type == 'smoke' or p.type == 'smash' then
			circfill(p.x, p.y, p.radius, p.color)
		elseif p.type == 'trail' then
			rectfill(p.x, p.y, p.x + p.w, p.y + p.h, p.color)
		else
			pset(p.x, p.y, p.color)
		end
	end
end