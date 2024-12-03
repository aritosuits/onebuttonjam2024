-- sub systems

subsystem = {}

function subsystem.toss(target)
	target:attach('toss', target.sprite)
	target:detach('physics')
	target:detach('offensive_collider')
	target:detach('defensive_collider')
	target:detach('sprite')
	target:detach('ai_shoot_smrt')
	target:detach('ai_shoot_dumb')
	target:detach('ai_boss')
end

function subsystem.crush(target)
	change_anim(target, 'crushed', false)
	target:detach('iframes')
	target:detach('health')
	target:detach('physics')
	target:detach('offensive_collider')
	target:detach('defensive_collider')
	target:detach('crushable')
	target:attach('despawn', 150)
end

function subsystem.smash_collide(source)
	particle.create('smash', source.x + 10, source.y + 21, 10)
	source:detach('smash')
	source.offensive_collider.enabled = false
	sfx(33)
	sfx(34)
	if source:has({'player', 'health'}) then
		shake.screen(source.health.current * 0.75 + 0.25, lerp(3, 5, source.health.current / 16))
	end
	source.physics.smashing = -1
end

function subsystem.bounce(source, target)
	if target:has('physics') then
		target.physics.vx += source.bounce.vx
		target.physics.vy = source.bounce.vy
	end
	-- smash again
	subsystem.smash_collide(target)
end

function subsystem.score(source, target)
	local s = score.calculate(source.scorable, target.physics.smashing, hero.health.current)
	-- printh('base score: ' .. source.scorable .. ' smash frames: ' .. target.physics.smashing .. ' health: ' .. target.health.current .. ' total: ' .. s)
	score.add(s)
end

function subsystem.boss_complete(source)
	hero:attach('autorun', 30)
	hero:detach('timer')
end

function subsystem.knock(source, target)
	target.physics.vx = source.knockback.vx
	target.physics.vy = source.knockback.vy
end

function subsystem.throw_code(source)
	local m = min(16, #source.collector.letters)
	local r = rnd(1)
	for i = 1, m do
		local vx = sin(i / m + r) * 2
		local vy = cos(i / m + r) * 2
		assemblage.collectable('code', source.x, source.y, sub(source.collector.letters, i, i), vx, vy)
	end
	source.health.current = 1
	source.collector.letters = ''
	sfx(41)
end

function subsystem.push_button(source)
	hero:attach('autorun', 30)
	sfx(36)
	change_anim(source, 'pressed')
	source:detach('defensive_collider')
	return true
end

function subsystem.projectile_redirect(e)
	e.physics.vx *= -1
	e:detach('enemy_team')
	e:detach('parent')
	e:attach('parent', hero)
end

function subsystem.boss_projectile_attack(e, timeComparison, numBullets)
	if e:has('frames') then change_anim(e, 'shooting', true) end
	local m = (t() - hero.timer.start_time > timeComparison) and 2 or 0
	for i = 0, m do 
		assemblage.enemy_bullet(e, e.x + (3*(i+1)), e.y + (2*(i*2)), -3, 0)
		if e:has('frames') then change_anim(e, 'idle', false) end
	end
end

function subsystem.projectile_redirect(e)
	e.physics.vx *= -1
	e:detach('enemy_team')
	e:detach('parent')
	e:attach('parent', hero)
end
