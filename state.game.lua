-- game state

game = state.create('game')
game.fade = true

function game.enter()
	hero = assemblage.player(24, 72)
	spawner.init()
end

function game.update(dt)
	system.update(dt)
	particle.update(dt)
	spawner.update(dt)
end

function game.draw()
	-- camera(hero.x - 30, 0)
	cls()
	-- background
	map(0, 0)
	-- particles
	particle.draw()
	-- entities
	system.draw()
	-- ui
	camera()
	for i = 1, 3 do
		spr(hero.health.current >= i and 223 or 207, (i-1) * 9 + 2, 3) -- health
	end
	for i = 1, 4 do
		spr(hero.weapon.level >= i and 255 or 239, (i-1) * 8 + 2, 13) -- gun
	end
	-- change brown and purple to better colors
	pal(4, 134, 1)
	pal(2, 133, 1)
	-- debug
	--print(#particle.list, 3, 120, 7)
end

function game.press()
	hero.controller.press = true
end
function game.hold(secs)
	hero.controller.hold = true
	hero.controller.secs = secs
end
function game.release(secs)
	hero.controller.release = true
	hero.controller.secs = secs
end

function game.leave()
	hero = nil
end
