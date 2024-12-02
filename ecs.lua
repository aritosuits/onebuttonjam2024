-- entity component system

--[[
--|| The world object is very simple with a list of
--|| entities and a function to clear all of them at
--|| once.
--]]

world = {} -- holds entities
world.entities = {}
function world.destroy()
	world.entities = {}
end
function world.each(comps, code)
	for e in all(world.entities) do
		if comps == nil or e:has(comps) then
			code(e)
		end
	end
end
function world.cull_not(comps, code)
	for e in all(world.entities) do
		if comps == nil or not e:has(comps) then
			local r = code(e)
			if r then del(world.entities, e) end
		end
	end
end

--[[
--|| The entity class is used by all entities and is
--|| a true class/object system! setmetatable does
--|| this because it goes "if we don't have something,
--|| look it up in this second table instead."
--|| local e = entity.create('test', 5, 5) -- create entity
--|| e:attach('sprite', 10) -- attach pos component
--|| if e:has({'sprite'}) then -- see if entity has pos
--|| e:destroy() -- mark entity for destruction
--]]

entity = {} -- entity class
function entity.create(name, x, y)
	local obj = {}
	obj.name = name
	obj.x = x or 0 -- all entities have x
	obj.y = y or 0 -- all entities have y
	setmetatable(obj, {__index = entity, __tostring = function(self) return examine(self) end })
	add(world.entities, obj)
	return obj
end
function entity:attach(comp, ...)
	local params = true
	if type(component[comp]) == 'function' then
		params = component[comp](...)
	end
	self[comp] = params
end
function entity:detach(comp)
	self[comp] = nil
end
function entity:has(comps)
	if type(comps) != 'table' then return self[comps] != nil end
	for c in all(comps) do
		if not self[c] then return false end
	end
	return true
end
function entity:destroy()
	self.destroying = true
	self.destroy_time = time()
end

--[[
--|| The component system is very simple and just
--|| installs all components as properties of the
--|| component object. Here's a position component:
--|| component.create('pos', function(x, y)
--||  return { x = x, y = y }
--|| end)
--|| And here's how to use it:
--|| hero_entity:attach('pos', 15, 13)
--]]

component = {}
function component.create(name, code)
	component[name] = code
end

--[[
--|| The assemblage system is very simple and just
--|| installs all assemblages as properties of the
--|| assemblage object. Here's an assemblage that
--|| creates flowers:
--|| assemblage.create('flower', function(color, x, y)
--||  local e = entity.create(name, x, y)
--||  e:attach('color', color)
--||  return e
--|| end)
--|| And here's how to use it:
--|| local b = assemblage.flower('blue', 10, 10)
--]]

assemblage = {}
function assemblage.create(name, code)
	assemblage[name] = code
end

--[[
--|| The systems... system is pretty straightforward.
--|| Create a system like so:
--|| system.create(
--||  'display', -- name of system
--||  {'pos', 'sprite'}, -- required components
--||  function(e, dt) -- "update" function
--||   [code and stuff]
--||  end,
--||  function(e) -- "draw" function
--||   [code and stuff]
--||  end,
--|| )
--|| Finally, in your game state, just do:
--|| state.update(dt) system.update(dt) end
--|| state.draw() system.draw() end
--|| and that will automatically run all systems!
--]]

system = {}
system.list = {}
function system.create(name, comps, update, draw)
	local s = {}
	s.name = name
	s.comps = comps
	function s:update(dt)
		for e in all(world.entities) do
			if e:has(self.comps) then
				if update then update(e, dt) end
			end
		end
	end
	function s:draw()
		for i = #world.entities, 1, -1 do
			local e = world.entities[i]
			if e:has(self.comps) then
				if draw then draw(e) end
			end
		end
	end
	add(system.list, s)
	return s
end
function system.update(dt)
	for s in all(system.list) do
		s:update(dt)
	end
end
function system.draw()
	for s in all(system.list) do
		s:draw()
	end
end

function examine(o)
	if type(o) == 'table' then
		local s = '{ '
		local sep = ''
		for k, v in pairs(o) do
			s = s .. sep .. k .. ': ' .. examine(v)
			sep = ', '
		end
		s = s .. ' }'
		return s
	else
		return tostring(o)
	end
end
function dump(o)
	printh(examine(o))
end
