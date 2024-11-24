-- game state

game = state.create('game')
game.fade = true

function game.enter()
	hero = entity.create()
	hero.health = 3
end

function game.update(dt)
end

function game.draw()
	cls(1)
	color(7)
	print('game screen', 20, 20)
	color(8)
	print('test test test', 20, 30)
end

function game.press() end
function game.hold(secs) end
function game.release(secs)
	state.switch('title')
end

function game.leave()
	hero = nil
end
