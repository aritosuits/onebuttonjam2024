-- assemblages

--[[
--|| A helper function that adds all general
--|| components that a player needs.
--]]
assemblage.create('player', function(x, y)
	e = entity.create(x, y)
	e:attach('health', 3)
	e:attach('weapon', 0)
	-- ...
	return e
end)

--[[
--|| A helper function that adds all general
--|| components that an enemy machine would need.
--]]
assemblage.create('machine', function(type, x, y)
	e = entity.create(x, y)
	e:attach('health', 3)
	-- ...
	return e
end)
