-- title screen state

title = state.create('title')
title.fade = true

function title.enter()
	music(-1)
	music(10)
	title.paw = false
	scroll.init(title, 15, 'employment agreement|......................||thank you for applying|to dome enterprises.||your job will be to|investigate why the|printer isn\'t wo%King|correctly after|embers, ari and sun|our program#ers|insta!1ed the last|buggy upd*te. .$)&&&$|   : . . |f e l d o #1buttonjam .|      . . :  :|your supervisor %&*|requests{ that you|refrain* from stomping|or jumping in your|cubicle += we have|sustained recent|damage from <undef>|employees doing so.|   i1   \' ` ~!:  .|press 🅾️ to sign this|agreement and clock in!|$*%)@!mwa#ah!@*@(@#||X..........%:.:.......||○2024 dangerous office| machine enterprises|         #::.|*  ($% ]*  (&h @% @#$')
end

function title.update(dt)
	scroll.update(dt)
end

function title.draw()
	scroll.draw()

	if title.paw then
		spr(106, 40, 212, 2, 2)
	end
end

function title.press() end
function title.hold(secs) end
function title.release(secs)
	title.paw = true
	sfx(40)
	state.switch('game')
end

function title.leave()
	music(-1)
end
