-- game state

game = state.create('game')
game.fade = true

function game.enter()
	hero = assemblage.player(20, 70)
	enemy = assemblage.machine('', 60, 90)
	--for i = 1, hero.health do
	--	assemblage.healthSprite(i,true)
	--end
end

function game.update(dt)
	system.update(dt)
	
end

function game.draw()
	cls()
	camera(hero.x - 30, 0)
	-- background
	map(0, 0)
	-- entities
	system.draw()
	camera()
	-- ui
	game.drawHealth()
	--for i = 1, 4 do
	--	spr(hero.weapon.level >= i and 255 or 239, (i-1) * 8 + 2, 13) -- gun
	--end
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

function game.drawHealth()
	for i = 1, 3 do
		spr(hero.health >= i and 223 or 207, (i-1) * 9 + 2, 3) -- health
	end
end

function game.leave()
	hero = nil
end
