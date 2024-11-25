-- state system

state = {}
state.list = {}
state._frozen = false
state._button_held = false
state._button_held_at = 0
state._next = ''

function state.create(name, fade)
	local obj = {}
	obj.name = name
	obj.fade = fade or false
	obj.enter = function() end
	obj.update = function(dt) end
	obj.draw = function() end
	obj.press = function() end
	obj.hold = function(secs) end
	obj.release = function(secs) end
	obj.leave = function() end
	state.list[name] = obj
	return state.list[name]
end

function state.switch(name)
	state._frozen = true
	if state.active and state.active.name == name then return end
	if state.active then
		if not state.active.fade then
			state.active.leave()
		else
			state._next = name
			fade.disappear(function()
				state.active.leave()
				state._finish_switch(state._next)
			end)
			return
		end
	end
	state._finish_switch(name)
end

function state._finish_switch(name)
	if state.active and state.active.name != 'default' then
		printh('state leave ' ..  state.active.name)
	end
	state.active = state.list[name]
	printh('state enter ' .. state.active.name)
	state._next = ''
	state.active.enter()
	if state.active.fade then
		fade.appear(function()
			state._frozen = false
		end)
	else
		state._frozen = false
	end
end

function state.init()
	state.switch('default')
end

function state.update()
	local dt = 1/30
	if state._frozen then return end
	local secs = time() - state._button_held_at
	if btnp(4) then -- just pressed
		state._button_held = true
		state._button_held_at = time()
		state.active.press()
	elseif state._button_held and not btn(4) then -- just released
		state._button_held = false
		state._button_held_at = 0
		state.active.release(secs)
	elseif btn(4) then -- held
		state.active.hold(secs)
	end
	state.active.update(dt)
end

function state.draw()
	cls()
	fade.update()
	color(6)
	state.active.draw()
end

state.create('default')
state.switch('default')
