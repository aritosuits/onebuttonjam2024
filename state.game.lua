-- game state

game = state.create('game')
game.fade = true

function game.enter()
	ground = 104
	score.reset()
	spawner.init()
	music(0)
end

function game.update(dt)
	spawner.update(dt)
	system.update(dt)
	particle.update(dt)
	if flr(rnd(10)) == 0 and hero then
		world.cull_not('player', function(e)
			return e.x <= hero.x - 50
		end)
	end
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
	-- for i = 1, 3 do
	-- 	spr(hero.health.current >= i and 223 or 207, (i-1) * 9 + 2, 3) -- health
	-- end
	if hero then
		local m = min(16, #hero.collector.letters)
		for i = 1, m do
			recttext(0, sub(hero.collector.letters, i, i), (i-1) * 8 + 1, 3)
		end
	end
	-- print(flr(hero.x) ..",".. flr(hero.y), 30,5)
	-- change brown and purple to better colors
	pal(4, 134, 1)
	pal(2, 133, 1)
	-- debug
	--print(#particle.list, 3, 120, 7)
	if DEV_UI then
		print('p', 2, 15, 11)
		print('e', 2, 21, 11)
		print(#particle.list, 7, 15, 7)
		print(#world.entities, 7, 21, 7)
	end
	--[[
		printh(hero) -- DUMP ENTITY INFO
		dump(hero.defensive_collider) -- DUMP ANY OBJECT OR VARIABLE
	--]]
	-- dump(hero.health)
	score.draw()
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
	music(-1)
	hero = nil
end
