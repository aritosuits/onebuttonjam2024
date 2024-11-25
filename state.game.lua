-- game state

game = state.create('game')
game.fade = true

function game.enter()
	hero = assemblage.player()
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
