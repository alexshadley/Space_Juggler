star = {}

function star:new()
	o = {}
	setmetatable(o, {__index = self})
	
	local selector = math.random();
	if selector < .8 then -- white star (80% chance)
		o.r, o.g, o.b = 255, 255, 255
	elseif selector > .8 and selector < .9 then -- blue star (10% chance)
		o.r, o.g, o.b = 155, 163, 255
	else -- red star (10% chance)
		o.r, o.g, o.b = 255, 155, 155
	end
	
	selector = math.random() -- set size to a random value between 1 and 3
	if selector < .5 then -- small (50% chance)
		o.size = 1
	elseif selector > .5 and selector < .9 then -- meduim (40% chance)
		o.size = 2
	else -- large (10% chance)
		o.size = 3
	end
	
	
	o.x = math.random(love.graphics.getWidth())
	o.y = math.random(love.graphics.getHeight())
	
	return o
end

function star:draw()
	love.graphics.setColor(self.r, self.g, self.b)
	love.graphics.setPointSize(self.size)
	love.graphics.points(self.x + .5, self.y + .5)
end