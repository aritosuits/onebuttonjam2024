-- game state

game = state.create('game')
game.fade = true

function game.enter()
	printh("Entered game state enter")
	hero = assemblage.player()
	embers = entity.create(50, 50) 
	embers:attach("sprite", 0)
	printh("Drew embers?")
	printh(embers:has({'sprite'})) --presently returns false
	printh(hero:has({'health'})) --false
	printh(hero:has({'weapon'})) --false
	printh(embers:has({'health'})) --false
	printh(embers:has({'weapon'})) --false
	printh(world.entities)
end

function game.update(dt)
	system.update(dt)
end

function game.draw()
	cls()
	map(0,0)
	system.draw(dt)
	-- health display
	for i = 1, 3 do
		spr(hero.health >= i and 223 or 207, (i-1) * 9 + 2, 3)
	end
	-- gun level display
	for i = 1, 4 do
		spr(hero.weapon.level >= i and 255 or 239, (i-1) * 8 + 2, 13)
	end
end

function game.press() end
function game.hold(secs) end
function game.release(secs)
	state.switch('title')
end

function game.leave()
	hero = nil
end
