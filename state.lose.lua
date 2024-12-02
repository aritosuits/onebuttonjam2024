-- lose screen state

lose = state.create('lose')
lose.fade = true

function lose.enter()
	music(-1)
	scroll.init(lose, 14, 'employee #' .. (flr(rnd(1000)) + 1000) .. '|terminated after|brutal encounter|with ' .. stats.killed_by .. '||employee earned|$' .. score.points .. ' in bonuses|' .. (score.points > 0 and 'but due to regulatory|mandate, only $2 will|be paid out|' or '') .. '|   :*#  *@ * %$(   @*|laura please send|in an intern to|fix:this pr1nt#r|  :   ::  3 *!@ **@||press 🅾️ to re-apply')
end

function lose.update(dt)
	scroll.update(dt)
end

function lose.draw()
	scroll.draw()
end

function lose.press() end
function lose.hold(secs) end
function lose.release(secs)
	sfx(40)
	reload()
	state.switch('title')
end

function lose.leave()
end
