-- lose screen state

lose = state.create('lose')
lose.fade = true

function lose.enter()
	lose.lock = 120
	music(-1)
	scroll.init(lose, 14, 'employee #' .. (flr(rnd(1000)) + 1000) .. '|terminated after|brutal encounter|with ' .. score.killed_by .. '||||||employee earned|$' .. score.points .. ' in bonuses|' .. (score.points > 0 and 'but due to regulatory|mandate, only $2 will|be paid out|' or '') .. '|   :*#  *@ * %$(   @*|laura please send|in an intern to|fix:this pr1nt#r|  :   ::  3 *!@ **@||press 🅾️ to re-apply')
end

function lose.update(dt)
	lose.lock -= 1
	scroll.update(dt)
end

function lose.draw()
	scroll.draw()
	if lose.line >= 7 then
		spr(103, 40, 70, 3, 2)
	end
end

function lose.press() end
function lose.hold(secs) end
function lose.release(secs)
	if lose.lock <= 0 then
		sfx(40)
		reload()
		state.switch('title')
	end
end

function lose.leave()
end
