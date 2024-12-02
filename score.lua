score = {}
score.points = 0
score.killed_by = ''
score.max_bounces = 0

function score.reset()
	score.points = 0
	score.killed_by = ''
	score.max_bounces = 0
end

function score.calculate(base_value, frames_since_stomp, code_characters)
	frames_since_stomp = min(frames_since_stomp, 10)
	code_characters = min(code_characters, 20)
	return base_value + (frames_since_stomp * 10) + (code_characters * 5)
end

function score.add(points)
	score.points += (points or 0)
end

function score.draw()
	local p = tostring(score.points)
	local x = 2
	-- local x = 127 - (#p * 4)
	local y = 120
	print(p, x, y, 7)
end
